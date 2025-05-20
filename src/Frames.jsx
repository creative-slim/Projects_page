import * as THREE from "three";
import { useEffect, useRef, useState } from "react";
import { useFrame, useThree } from "@react-three/fiber";
import {
  useCursor,
  MeshReflectorMaterial,
  Image,
  Text,
  Environment,
  OrbitControls,
  Html,
  Resize,
  ContactShadows,
  MeshPortalMaterial,
  Svg,
} from "@react-three/drei";

import {
  EffectComposer,
  Bloom,
  ToneMapping,
} from "@react-three/postprocessing";
import { useRoute, useLocation } from "wouter";
import { easing } from "maath";
import getUuid from "uuid-by-string";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { gsap } from "gsap"; // Import gsap
import Portal from './Portal';

const GOLDENRATIO = 1.61803398875;

// Helper function to calculate lookAt quaternion more robustly
const calculateLookAtQuaternion = (
  eye,
  target,
  up = new THREE.Vector3(0, 1, 0)
) => {
  const _matrix = new THREE.Matrix4(); // Use local temp variable
  _matrix.lookAt(eye, target, up);
  return new THREE.Quaternion().setFromRotationMatrix(_matrix);
};
const clearActiveProjectClasses = () => {
  console.log("Clearing active project classes");
  const allProjectElements = document.querySelectorAll("[data-projects]");
  allProjectElements.forEach((el) => {
    el.classList.remove("active");
  });
};

export default function Frames({
  images,
  setIsZoomed, // Receive setIsZoomed prop
  section2Position, // Receive section 2 position
  section2LookAtTarget, // Receive section 2 lookAt target
  initialFov, // Receive initial FOV
}) {
  const ref = useRef();
  const clicked = useRef();
  const [, params] = useRoute("/item/:id");
  const [, setLocation] = useLocation();
  const { camera } = useThree(); // Get camera instance here
  const [isAnimatingOut, setIsAnimatingOut] = useState(false); // State for zoom-out animation
  const targetFovRef = useRef(initialFov); // Ref to store target FOV

  // Refs for animation targets
  const finalZoomInPosition = useRef(new THREE.Vector3());
  const frameCenterWorld = useRef(new THREE.Vector3()); // Point to look at
  const zoomInTargetQ = useRef(new THREE.Quaternion());
  const zoomOutTargetQ = useRef(new THREE.Quaternion()); // Store the target quaternion for zoom-out

  // Effect to handle zoom IN state and target calculation
  useEffect(() => {
    clicked.current = ref.current.getObjectByName(params?.id);
    if (clicked.current) {
      // Item is selected: Calculate zoom-in targets, set isZoomed true
      clicked.current.parent.updateWorldMatrix(true, true);

      // 1. Calculate the world position the camera should move TO
      clicked.current.parent.localToWorld(
        finalZoomInPosition.current.set(0, GOLDENRATIO / 2, 1.25) // Camera position in front of frame
      );

      // 2. Calculate the world position the camera should LOOK AT
      clicked.current.parent.localToWorld(
        frameCenterWorld.current.set(0, GOLDENRATIO / 2, 0.7) // Center of image plane
      );

      // 3. Calculate the target quaternion based on the final position and lookAt point
      zoomInTargetQ.current.copy(
        calculateLookAtQuaternion(
          finalZoomInPosition.current,
          frameCenterWorld.current
        )
      );

      setIsZoomed(true); // Signal APP that we are zoomed
      targetFovRef.current = 70; // Set TARGET FOV for zoom in
      console.log(
        "Frames : Zoomed IN, setting isZoomed = true, target FOV = 100"
      );
    }
    // Target FOV reset is handled by zoom-out trigger
  }, [params?.id, setIsZoomed, camera, initialFov]); // Add camera and initialFov to dependencies, remove setFov

  // Effect to run the zoom OUT animation
  useEffect(() => {
    if (isAnimatingOut) {
      console.log("Frames : Starting zoom OUT animation");

      // Calculate the target quaternion for the final zoom-out state
      zoomOutTargetQ.current.copy(
        calculateLookAtQuaternion(section2Position, section2LookAtTarget)
      );

      // Animate position only using GSAP
      gsap.to(camera.position, {
        duration: 1.2, // Adjust duration as needed
        x: section2Position.x,
        y: section2Position.y,
        z: section2Position.z,
        ease: "power1.inOut",
        onComplete: () => {
          // Use delayedCall to allow dampQ one more frame to settle
          gsap.delayedCall(0.5, () => {
            // Small delay (approx 1-2 frames)
            console.log("Frames: Zoom OUT animation complete (after delay)");
            clearActiveProjectClasses(); // Clear active classes
            // No need to manually set quaternion if dampQ finishes
            setIsAnimatingOut(false);
            setIsZoomed(false); // Signal APP that zoom is finished AFTER animation and delay
          });
        },
      });
    }
  }, [
    isAnimatingOut,
    camera,
    section2Position,
    section2LookAtTarget,
    setIsZoomed,
  ]); // Add 'p' dependency

  // useFrame for animations (including FOV)
  useFrame((state, dt) => {
    // Animate FOV towards the target value
    const fovChanged = Math.abs(state.camera.fov - targetFovRef.current) > 0.01;
    if (fovChanged) {
      easing.damp(state.camera, "fov", targetFovRef.current, 0.4, dt);
      state.camera.updateProjectionMatrix(); // Update projection matrix if FOV changed
    }

    if (isAnimatingOut) {
      // During zoom-out animation, smoothly rotate towards the target quaternion using dampQ
      easing.dampQ(state.camera.quaternion, zoomOutTargetQ.current, 0.5, dt); // Adjust speed (0.5) as needed
    } else if (params?.id && clicked.current) {
      // During zoom-in animation (and while zoomed), use maath easing for position and rotation
      easing.damp3(state.camera.position, finalZoomInPosition.current, 0.4, dt); // Move towards final position
      easing.dampQ(state.camera.quaternion, zoomInTargetQ.current, 0.4, dt); // Rotate towards final orientation
    }
    // If !isAnimatingOut and !params?.id, GSAP ScrollTrigger controls the camera
  });

  // Effect to handle scroll UP while zoomed in
  useEffect(() => {
    if (params?.id) {
      // Only listen when zoomed in
      const handleWheel = (event) => {
        if (event.deltaY < 0) {
          // Scrolling UP
          console.log("Frames: Scroll UP detected while zoomed, zooming out.");
          event.preventDefault(); // Prevent default scroll
          triggerZoomOut(); // Use the trigger function
        }
      };
      window.addEventListener("wheel", handleWheel, { passive: false });
      return () => window.removeEventListener("wheel", handleWheel);
    }
  }, [params?.id, setLocation]); // Rerun when zoom state changes

  // Function to trigger zoom out
  const triggerZoomOut = () => {
    if (!isAnimatingOut && params?.id) {
      // Only trigger if zoomed in and not already animating out
      console.log("Frames: Triggering zoom out, setting target FOV");
      targetFovRef.current = initialFov; // Set TARGET FOV for zoom out
      setIsAnimatingOut(true);
      setLocation("/"); // Update route to exit item view
    }
  };

  return (
    <group
      ref={ref}
      onClick={(e) => {
        e.stopPropagation();
        if (clicked.current === e.object) {
          // Clicked active frame: Zoom out
          triggerZoomOut();
        } else {
          // Clicked inactive frame: Zoom in
          if (!isAnimatingOut) {
            setLocation("/item/" + e.object.name);
          }
        }
      }}
      onPointerMissed={() => {
        // Clicked background: Zoom out
        triggerZoomOut(); // Will only run if params.id exists and not already animating
      }}
    >
      {images.map(
        (props) => <Frame key={props.url} {...props} /> /* prettier-ignore */
      )}
    </group>
  );
}

function Frame({ url, c = new THREE.Color(), ...props }) {
  const image = useRef();
  const frame = useRef();
  const linkRef = useRef();
  const portalRef = useRef();
  const particlesRef = useRef();
  const [, params] = useRoute("/item/:id");
  const [hovered, hover] = useState(false);
  const [rnd] = useState(() => Math.random());
  const name = getUuid(url);
  const isActive = params?.id === name;
  useCursor(hovered);

  // Create initial particle positions and velocities
  const particlePositions = useRef(
    new Float32Array(50 * 3).map(() => (Math.random() - 0.5) * 2)
  );
  const particleVelocities = useRef(
    new Float32Array(50 * 3).map(() => (Math.random() - 0.5) * 0.001)
  );

  // Custom shader for gradient rings
  const gradientShader = {
    uniforms: {
      time: { value: 0 },
      colors: {
        value: [
          new THREE.Color("#4a9eff"),
          new THREE.Color("#00ffaa"),
          new THREE.Color("#ff4a9e")
        ]
      }
    },
    vertexShader: `
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
    fragmentShader: `
      uniform float time;
      uniform vec3 colors[3];
      varying vec2 vUv;
      
      void main() {
        vec2 center = vec2(0.5, 0.5);
        vec2 pos = vUv - center;
        float angle = atan(pos.y, pos.x) + time;
        float normalizedAngle = (angle + 3.14159) / (2.0 * 3.14159);
        
        // Create gradient based on angle
        vec3 color = mix(
          mix(colors[0], colors[1], smoothstep(0.0, 0.5, normalizedAngle)),
          mix(colors[1], colors[2], smoothstep(0.5, 1.0, normalizedAngle)),
          smoothstep(0.0, 1.0, normalizedAngle)
        );
        
        gl_FragColor = vec4(color, 0.4);
      }
    `
  };

  useFrame((state, dt) => {
    image.current.material.zoom =
      2 + Math.sin(rnd * 10000 + state.clock.elapsedTime / 3) / 2;
    easing.damp3(
      image.current.scale,
      [
        0.85 * (!isActive && hovered ? 0.85 : 1),
        0.9 * (!isActive && hovered ? 0.905 : 1),
        1,
      ],
      0.1,
      dt
    );
    // Safely update frame color if frame.current exists
    if (frame.current && frame.current.material) {
      easing.dampC(
        frame.current.material.color,
        hovered ? "orange" : "white",
        0.1,
        dt
      );
    }

    // Update shader time uniform
    if (portalRef.current) {
      portalRef.current.children.forEach(child => {
        if (child.material.uniforms) {
          child.material.uniforms.time.value = state.clock.elapsedTime * 0.2;
        }
      });
    }

    // Animate particles with random movement
    if (particlesRef.current) {
      const positions = particlesRef.current.geometry.attributes.position.array;
      const velocities = particleVelocities.current;

      for (let i = 0; i < positions.length; i += 3) {
        // Update positions based on velocities
        positions[i] += velocities[i];
        positions[i + 1] += velocities[i + 1];
        positions[i + 2] += velocities[i + 2];

        // Add some random acceleration
        velocities[i] += (Math.random() - 0.5) * 0.0005;
        velocities[i + 1] += (Math.random() - 0.5) * 0.0005;
        velocities[i + 2] += (Math.random() - 0.5) * 0.0005;

        // Dampen velocities
        velocities[i] *= 0.995;
        velocities[i + 1] *= 0.995;
        velocities[i + 2] *= 0.995;

        // Keep particles within bounds
        const maxRadius = 1.2;
        const distance = Math.sqrt(
          positions[i] * positions[i] +
          positions[i + 1] * positions[i + 1]
        );

        if (distance > maxRadius) {
          const angle = Math.atan2(positions[i + 1], positions[i]);
          positions[i] = Math.cos(angle) * maxRadius;
          positions[i + 1] = Math.sin(angle) * maxRadius;

          // Bounce off the boundary
          velocities[i] *= -0.2;
          velocities[i + 1] *= -0.2;
        }

        // Keep z position within bounds
        if (Math.abs(positions[i + 2]) > 0.2) {
          positions[i + 2] = Math.sign(positions[i + 2]) * 0.2;
          velocities[i + 2] *= -0.2;
        }
      }
      particlesRef.current.geometry.attributes.position.needsUpdate = true;
    }
  });

  const handleLinkClick = (e) => {
    console.log("Frame clicked, handling link logic:", props);
    if (props.slug) {
      const targetSelector = `[data-projects="${props.slug}"]`;
      const targetElement = document.querySelector(targetSelector);

      if (targetElement) {
        console.log("Found target element:", targetElement);

        const allProjectElements = document.querySelectorAll("[data-projects]");
        allProjectElements.forEach((el) => {
          el.classList.remove("active");
        });

        targetElement.classList.add("active");
      } else {
        console.warn(`Element with data-projects="${props.slug}" not found.`);
      }
    } else {
      console.warn("Slug prop is missing from Frame component.");
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
        onClick={handleLinkClick}
      >
        <boxGeometry />
        <meshStandardMaterial
          transparent
          opacity={0}
        />
        {/* Subtle inner rim in front of the image for portal depth */}
        <mesh position={[0, 0, 0.81]} scale={[0.72, 0.72 * GOLDENRATIO, 1]} raycast={() => null}>
          <ringGeometry args={[0.34, 0.37, 64]} />
          <meshBasicMaterial color="#fff" opacity={0.18} transparent blending={THREE.AdditiveBlending} />
        </mesh>
        {/* Subtle glow behind the image */}
        <mesh position={[0, 0, 0.65]} scale={[0.7, 0.7 * GOLDENRATIO, 1]} raycast={() => null}>
          <ringGeometry args={[0.28, 0.36, 64]} />
          <meshBasicMaterial color="#fff8b0" opacity={0.10} transparent blending={THREE.AdditiveBlending} />
        </mesh>
        <Image
          raycast={() => null}
          ref={image}
          position={[0, 0, 0.75]} // Move image slightly back so it's inside the portal
          url={url}
        />
        <Portal position={[0, 0, 0.35]} scale={[1, GOLDENRATIO, 1]} />
        {/* Energy particles */}
        <points ref={particlesRef} raycast={() => null}>
          <bufferGeometry>
            <bufferAttribute
              attach="attributes-position"
              count={50}
              array={particlePositions.current}
              itemSize={3}
            />
          </bufferGeometry>
          <pointsMaterial
            color="#ffffff"
            size={0.02}
            transparent
            opacity={0.8}
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
