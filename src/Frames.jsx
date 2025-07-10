import * as THREE from "three";
import { useEffect, useRef, useState } from "react";
import { useFrame, useThree } from "@react-three/fiber";
import {
  useCursor,

  Text,

} from "@react-three/drei";

import { easing } from "maath";
import getUuid from "uuid-by-string";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { gsap } from "gsap";
import Portal from './Portal';
import { TextureLoader } from 'three';
import { useLoader } from '@react-three/fiber';
import { devLog, devWarn, devError } from './utils/devLog';
import { useOptimizedParticles } from './utils/useOptimizedParticles';
import { useFrameRate } from './utils/useFrameRate';
import { useCachedElements } from './utils/useCachedElements';

const GOLDENRATIO = 1;

// Helper function to calculate lookAt quaternion more robustly
const calculateLookAtQuaternion = (
  eye,
  target,
  up = new THREE.Vector3(0, 1, 0)
) => {
  const _matrix = new THREE.Matrix4();
  _matrix.lookAt(eye, target, up);
  return new THREE.Quaternion().setFromRotationMatrix(_matrix);
};

// Use cached DOM elements for better performance
const useProjectElements = () => {
  return useCachedElements("div[data-three='thumbnail'].project-links-item");
};

function getUniquePortalConfigs(seed = 0) {
  return [
    {
      radius: 0.48 + 0.01 * Math.sin(seed),
      tube: 0.045 + 0.005 * Math.cos(seed),
      opacity: 0.7,
      speed: 0.4 + 0.2 * Math.abs(Math.sin(seed * 2)),
      phase: seed,
    },
    {
      radius: 0.56 + 0.01 * Math.cos(seed),
      tube: 0.025 + 0.005 * Math.sin(seed),
      opacity: 0.4,
      speed: 0.6 + 0.2 * Math.abs(Math.cos(seed * 2)),
      phase: seed + 1,
    },
    {
      radius: 0.62 + 0.01 * Math.sin(seed * 1.5),
      tube: 0.012 + 0.005 * Math.cos(seed * 1.5),
      opacity: 0.2,
      speed: 0.3 + 0.2 * Math.abs(Math.sin(seed * 3)),
      phase: seed + 2,
    }
  ];
}

export default function Frames({
  images,
  setIsZoomed,
  section2Position,
  section2LookAtTarget,
  initialFov,
}) {
  const ref = useRef();
  const clicked = useRef();
  const { camera } = useThree();
  const [isAnimatingOut, setIsAnimatingOut] = useState(false);
  const [selectedFrameId, setSelectedFrameId] = useState(null);
  const targetFovRef = useRef(initialFov);
  const { clearActiveClasses } = useProjectElements();

  // Refs for animation targets
  const finalZoomInPosition = useRef(new THREE.Vector3());
  const frameCenterWorld = useRef(new THREE.Vector3());
  const zoomInTargetQ = useRef(new THREE.Quaternion());
  const zoomOutTargetQ = useRef(new THREE.Quaternion());

  // Effect to handle zoom IN state and target calculation
  useEffect(() => {
    clicked.current = ref.current?.getObjectByName(selectedFrameId);
    if (clicked.current) {
      clicked.current.parent.updateWorldMatrix(true, true);

      clicked.current.parent.localToWorld(
        finalZoomInPosition.current.set(0, GOLDENRATIO / 2, 1.25)
      );

      clicked.current.parent.localToWorld(
        frameCenterWorld.current.set(0, GOLDENRATIO / 2, 0.7)
      );

      zoomInTargetQ.current.copy(
        calculateLookAtQuaternion(
          finalZoomInPosition.current,
          frameCenterWorld.current
        )
      );

      setIsZoomed(true);
      targetFovRef.current = 70;
      devLog("Frames : Zoomed IN, setting isZoomed = true, target FOV = 70");
    }
  }, [selectedFrameId, setIsZoomed, camera, initialFov]);

  // Effect to run the zoom OUT animation
  useEffect(() => {
    if (isAnimatingOut) {
      devLog("Frames : Starting zoom OUT animation");

      zoomOutTargetQ.current.copy(
        calculateLookAtQuaternion(section2Position, section2LookAtTarget)
      );

      gsap.to(camera.position, {
        duration: 1.2,
        x: section2Position.x,
        y: section2Position.y,
        z: section2Position.z,
        ease: "power1.inOut",
        onComplete: () => {
          gsap.delayedCall(0.5, () => {
            devLog("Frames: Zoom OUT animation complete (after delay)");
            clearActiveClasses();
            setIsAnimatingOut(false);
            setIsZoomed(false);
            setSelectedFrameId(null);
          });
        },
      });
    }
  }, [isAnimatingOut, camera, section2Position, section2LookAtTarget, setIsZoomed]);

  useFrame((state, dt) => {
    const fovChanged = Math.abs(state.camera.fov - targetFovRef.current) > 0.01;
    if (fovChanged) {
      easing.damp(state.camera, "fov", targetFovRef.current, 0.4, dt);
      state.camera.updateProjectionMatrix();
    }

    if (isAnimatingOut) {
      easing.dampQ(state.camera.quaternion, zoomOutTargetQ.current, 0.5, dt);
    } else if (selectedFrameId && clicked.current) {
      easing.damp3(state.camera.position, finalZoomInPosition.current, 0.4, dt);
      easing.dampQ(state.camera.quaternion, zoomInTargetQ.current, 0.4, dt);
    }
  });

  // Effect to handle scroll UP while zoomed in
  useEffect(() => {
    if (selectedFrameId) {
      const handleWheel = (event) => {
        if (event.deltaY < 0) {
          devLog("Frames: Scroll UP detected while zoomed, zooming out.");
          event.preventDefault();
          triggerZoomOut();
        }
      };
      window.addEventListener("wheel", handleWheel, { passive: false });
      return () => window.removeEventListener("wheel", handleWheel);
    }
  }, [selectedFrameId]);

  const triggerZoomOut = () => {
    if (!isAnimatingOut && selectedFrameId) {
      devLog("Frames: Triggering zoom out, setting target FOV");
      targetFovRef.current = initialFov;
      setIsAnimatingOut(true);
    }
  };

  // Debug: get all slugs from images
  const allSlugs = images.map(img => img.slug);

  return (
    <group
      ref={ref}
      onClick={(e) => {
        e.stopPropagation();
        if (clicked.current === e.object) {
          triggerZoomOut();
        } else {
          if (!isAnimatingOut) {
            setSelectedFrameId(e.object.name);
          }
        }
      }}
      onPointerMissed={() => {
        triggerZoomOut();
      }}
    >
      {images.map((props) => (
        <Frame
          key={props.url}
          {...props}
          selectedFrameId={selectedFrameId}
        />
      ))}
    </group>
  );
}

function Frame({ url, c = new THREE.Color(), selectedFrameId, ...props }) {
  const image = useRef();
  const linkRef = useRef();
  const portalRef = useRef();
  const particlesRef = useRef();
  const [hovered, hover] = useState(false);
  const [rnd] = useState(() => Math.random());
  const name = getUuid(url);
  const isActive = selectedFrameId === name;
  useCursor(hovered);

  // Use optimized particle system
  const { positions: particlePositions, count: particleCount } = useOptimizedParticles(50);

  const imageTexture = useLoader(TextureLoader, url);
  const mask = useLoader(TextureLoader, 'https://files.creative-directors.com/creative-website/creative25/project-masks/circle-mask.png');

  const seed = rnd * 1000; // unique per frame
  const portalConfigs = getUniquePortalConfigs(seed);

  // Add cleanup for particles and textures
  useEffect(() => {
    return () => {
      if (particlesRef.current) {
        particlesRef.current.geometry.dispose();
        particlesRef.current.material.dispose();
      }
      if (imageTexture) {
        imageTexture.dispose();
      }
      if (mask) {
        mask.dispose();
      }
    };
  }, []);

  useFrameRate((state, dt) => {
    image.current.material.zoom =
      2 + Math.sin(rnd * 10000 + state.clock.elapsedTime / 3) / 2;

    // Scale up on hover or if frame is active
    const targetScale = (hovered || isActive) ? 1.3 : 1;
    easing.damp3(
      image.current.scale,
      [targetScale, targetScale, 1],
      0.1,
      dt
    );

    // Update particle positions from optimized system
    if (particlesRef.current) {
      const positions = particlesRef.current.geometry.attributes.position.array;
      for (let i = 0; i < particleCount * 3; i++) {
        positions[i] = particlePositions[i];
      }
      particlesRef.current.geometry.attributes.position.needsUpdate = true;
    }
  }, 30); // Reduced from 60fps to 30fps

  // Separate useFrame for smooth portal shader time updates to prevent flickering
  useFrame((state) => {
    if (portalRef.current) {
      portalRef.current.children.forEach(child => {
        if (child.material.uniforms) {
          child.material.uniforms.time.value = state.clock.elapsedTime * 0.2;
        }
      });
    }
  });

  const { setActiveBySlug } = useProjectElements();

  const handleLinkClick = (e) => {
    devLog("Frame clicked, handling link logic:", props);
    if (props.slug) {
      const result = setActiveBySlug(props.slug);
      if (result !== -1) {
        devLog("Added 'active' class to project item");
      } else {
        devWarn(`No project-links-item found for slug: ${props.slug}`);
      }
    } else {
      devWarn("Slug prop is missing from Frame component.");
      devLog("Frame props:", props);
    }
  };

  return (
    <group {...props}>
      <mesh
        visible={true}
        name={name}
        onPointerOver={(e) => (e.stopPropagation(), hover(true))}
        onPointerOut={() => hover(false)}
        scale={[1, GOLDENRATIO, 0.05]}
        position={[0, GOLDENRATIO / 2, 0]}
        onClick={(e) => { handleLinkClick(e); }}
      >
        <circleGeometry args={[0.38, 64]} />
        <meshStandardMaterial
          transparent
          opacity={0}
        />
        {/* Subtle inner rim in front of the image for portal depth */}
        {/* <mesh position={[0, 0, 0.81]} scale={[0.72, 0.72 * GOLDENRATIO, 1]} raycast={() => null}>
          <ringGeometry args={[0.34, 0.37, 64]} />
          <meshBasicMaterial color="#fff" opacity={0.18} transparent blending={THREE.AdditiveBlending} />
        </mesh> */}
        {/* Subtle glow behind the image */}
        <mesh position={[0, 0, 0.65]} scale={[0.7, 0.7 * GOLDENRATIO, 1]} raycast={() => null}>
          <ringGeometry args={[0.28, 0.36, 64]} />
          <meshBasicMaterial color="#fff8b0" opacity={0.10} transparent blending={THREE.AdditiveBlending} />
        </mesh>
        {/* Circular image with alpha mask and ref */}
        <mesh ref={image} position={[0, 0, 0.75]} raycast={() => null}>
          <circleGeometry args={[0.35, 64]} />
          <meshBasicMaterial
            map={imageTexture}
            alphaMap={mask}
            transparent
            side={THREE.DoubleSide}
          />
        </mesh>

        <Portal ref={portalRef} position={[0, 0, 0.35]} scale={[1, GOLDENRATIO, 1]} configs={portalConfigs} />
        {/* Energy particles */}
        <points ref={particlesRef} raycast={() => null}>
          <bufferGeometry>
            <bufferAttribute
              attach="attributes-position"
              count={particleCount}
              array={particlePositions}
              itemSize={3}
            />
          </bufferGeometry>
          <pointsMaterial
            color="#ffffff"
            size={0.01}
            transparent
            opacity={0.9}
            sizeAttenuation
            blending={THREE.AdditiveBlending}
            depthWrite={false}
          />
        </points>
      </mesh>
      <Text
        maxWidth={0.1}
        anchorX="left"
        anchorY="top"
        position={[0.55, GOLDENRATIO, 0]}
        fontSize={0.03}
      >
        {props.name?.split("-").join(" ") || name.split("-").join(" ")}
      </Text>
    </group>
  );
}
