import * as THREE from "three";
import { useEffect, useRef, useState } from "react";
import { Canvas, useFrame, useThree } from "@react-three/fiber";
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
} from "@react-three/drei";

import {
  EffectComposer,
  Bloom,
  ToneMapping,
} from "@react-three/postprocessing";
import { useRoute, useLocation } from "wouter";
import { easing } from "maath";
import getUuid from "uuid-by-string";
import { useControls } from "leva";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { gsap } from "gsap"; // Import gsap

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

export default function Frames({
  images,
  setIsZoomed, // Receive setIsZoomed prop
  section2Position, // Receive section 2 position
  section2LookAtTarget, // Receive section 2 lookAt target
}) {
  const ref = useRef();
  const clicked = useRef();
  const [, params] = useRoute("/item/:id");
  const [, setLocation] = useLocation();
  const { camera } = useThree();
  const [isAnimatingOut, setIsAnimatingOut] = useState(false); // State for zoom-out animation

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
      console.log("Frames: Zoomed IN, setting isZoomed = true");
    }
    // isZoomed(false) is handled by zoom-out animation complete
  }, [params?.id, setIsZoomed]); // Removed p, q from dependencies, using refs now

  // Effect to run the zoom OUT animation
  useEffect(() => {
    if (isAnimatingOut) {
      console.log("Frames: Starting zoom OUT animation");

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

  // useFrame for animations
  useFrame((state, dt) => {
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
      console.log("Frames: Triggering zoom out");
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
  const [, params] = useRoute("/item/:id");
  const [hovered, hover] = useState(false);
  const [rnd] = useState(() => Math.random());
  const name = getUuid(url);
  const isActive = params?.id === name;
  useCursor(hovered);
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
    easing.dampC(
      frame.current.material.color,
      hovered ? "orange" : "white",
      0.1,
      dt
    );
  });
  return (
    <group {...props}>
      <mesh
        name={name}
        onPointerOver={(e) => (e.stopPropagation(), hover(true))}
        onPointerOut={() => hover(false)}
        scale={[1, GOLDENRATIO, 0.05]}
        position={[0, GOLDENRATIO / 2, 0]}
      >
        <boxGeometry />
        <meshStandardMaterial
          color="#151515"
          metalness={0.5}
          roughness={0.5}
          envMapIntensity={2}
        />
        <mesh
          ref={frame}
          raycast={() => null}
          scale={[0.9, 0.93, 0.9]}
          position={[0, 0, 0.2]}
        >
          <boxGeometry />
          <meshBasicMaterial toneMapped={false} fog={false} />
        </mesh>
        <Image
          raycast={() => null}
          ref={image}
          position={[0, 0, 0.7]}
          url={url}
        />
      </mesh>
      <Text
        maxWidth={0.1}
        anchorX="left"
        anchorY="top"
        position={[0.55, GOLDENRATIO, 0]}
        fontSize={0.025}
      >
        {props.name?.split("-").join(" ") || name.split("-").join(" ")}
      </Text>
    </group>
  );
}
