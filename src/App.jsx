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
  Stars,
  Center,
} from "@react-three/drei";

import {
  EffectComposer,
  Bloom,
  ToneMapping,
  Vignette,
} from "@react-three/postprocessing";
import { useRoute, useLocation } from "wouter";
import { easing } from "maath";
import getUuid from "uuid-by-string";
import { TextModel } from "./Projects_text_plane";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { Kreaton } from "./Kreaton_A";
import { Armchair } from "./Armchair";
import { ProjectPlane } from "./Projekte-2";
import Frames from "./Frames";

const GOLDENRATIO = 1.61803398875;

// --- Camera Configuration ---
const section1Position = new THREE.Vector3(0, 8, 5);
// Note: section1LookAtTarget is dynamic based on projectTextRef,
// but we can define a fallback or initial target if needed.
// const section1LookAtFallback = new THREE.Vector3(0, 1, 0); // Example fallback
const section2Position = new THREE.Vector3(0, 0.8, 7.5);
const section2LookAtTarget = new THREE.Vector3(0, 0, -5);
// --- End Camera Configuration ---

// Define CameraRig component
function CameraRig({ activeSection, projectTextRef }) {
  const { camera } = useThree();
  const targetPosition = useRef(new THREE.Vector3()).current;
  const targetLookAt = useRef(new THREE.Vector3()).current;
  const currentLookAt = useRef(new THREE.Vector3(0, 1, 0)).current; // Initial lookAt, lerps towards target

  useFrame((state, delta) => {
    const isSection2 = activeSection === "section2";

    // Define target position and lookAt based on activeSection using variables
    if (isSection2) {
      // Section 2: Use defined variables
      targetPosition.copy(section2Position);
      targetLookAt.copy(section2LookAtTarget);
    } else {
      // Section 1: Use defined variable for position
      targetPosition.copy(section1Position);
      // Section 1 LookAt: Still dynamic based on projectTextRef
      if (projectTextRef && projectTextRef.current) {
        const projectPlanePosition = projectTextRef.current.position;
        targetLookAt.set(
          projectPlanePosition.x,
          projectPlanePosition.y,
          projectPlanePosition.z
        );
      } else {
        // Use a fallback if projectTextRef isn't ready or defined
        // targetLookAt.copy(section1LookAtFallback); // Use the fallback if defined
        targetLookAt.set(0, 1, 0); // Or keep the simple fallback
      }
    }

    // Smoothly interpolate camera position
    easing.damp3(camera.position, targetPosition, 0.5, delta); // Adjust smoothness (0.5) as needed

    // Smoothly interpolate lookAt target
    currentLookAt.lerp(targetLookAt, 0.05); // Adjust lerp factor (0.05) for lookAt smoothness
    camera.lookAt(currentLookAt);
  });

  return null; // This component only controls the camera
}

const App = ({ images }) => {
  // const [isCloseCamera, setIsCloseCamera] = useState(false); // Replaced by activeSection
  const [activeSection, setActiveSection] = useState("section1");

  const innerSceneRef = useRef();
  const projectTextRef = useRef();

  useEffect(() => {
    const handleScroll = () => {
      const scrollPosition = window.scrollY;
      const windowHeight = window.innerHeight;
      // Example threshold: switch to section2 when scrolled past 80% of the first viewport height
      // Adjust this logic based on your actual section markers (#section-1, #section-2) if they exist
      const threshold = windowHeight * 0.8;
      if (scrollPosition > threshold) {
        setActiveSection("section2");
      } else {
        setActiveSection("section1");
      }
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    handleScroll(); // Initial check in case the page loads scrolled
    return () => window.removeEventListener("scroll", handleScroll);
  }, []); // Removed isCloseCamera dependency

  return (
    <>
      <Canvas
        shadows
        dpr={[1, 1.5]}
        gl={{ antialias: true }}
        // Initial camera settings - CameraRig will take over positioning
        camera={{ fov: 50, position: [0, 10, 15] }}
        flat
      >
        <color attach="background" args={["#000000"]} />
        <fog attach="fog" args={["#000000", 0, 50]} />
        {/* Pass projectTextRef to CameraRig */}
        <CameraRig
          activeSection={activeSection}
          projectTextRef={projectTextRef}
        />
        {/* <Resize width={1000} height={1000}> */}
        <ProjectPlane
          ref={projectTextRef}
          rotation={[0.1, Math.PI / -2, 0]}
          position={[0, 8, -10]} // Keep original position
          scale={1}
          castShadow
          receiveShadow
        />
        <InnerScene images={images} ref={innerSceneRef} />
        {/* <Environment preset="city" /> */}
        {/* OrbitControls might interfere with CameraRig, remove or disable if necessary */}
        {/* <OrbitControls /> */}
        <EffectComposer>
          <Vignette eskil={false} offset={0.1} darkness={1.1} />
          <Bloom mipmapBlur luminanceThreshold={1} intensity={1} />
        </EffectComposer>
        {/* </Resize> */}
      </Canvas>
    </>
  );
};

// Component to handle the moon with color animation
const AnimatedMoon = ({ position, rotation, scale }) => {
  const meshRef = useRef();
  const materialRef = useRef();

  // Create refs for the texture loaders with updated blobby versions
  const colorMapRef = useRef(
    new THREE.TextureLoader().load(
      "/terrain_color_4x_blobby.jpg",
      (texture) => {
        texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
        texture.repeat.set(1, 1);
      }
    )
  );

  const normalMapRef = useRef(
    new THREE.TextureLoader().load(
      "/terrain_normal_4x_blobby.jpg",
      (texture) => {
        texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
        texture.repeat.set(1, 1);
      }
    )
  );

  const displacementMapRef = useRef(
    new THREE.TextureLoader().load("/terrain_height_4x_blobby.jpg")
  );

  useFrame((state) => {
    // if (materialRef.current) {
    //   // Oscillate between purple (270) and blue (240) hues
    //   const time = state.clock.getElapsedTime();
    //   const hue = 230 + Math.sin(time * 0.2) * 25; // Oscillate between ~225 and ~255
    //   materialRef.current.color = new THREE.Color(`hsl(${hue}, 70%, 50%)`);
    // }
  });

  return (
    <mesh
      ref={meshRef}
      name="moon"
      position={position}
      rotation={rotation}
      scale={scale}
    >
      <planeGeometry args={[50, 50, 64, 64]} />
      <meshPhysicalMaterial
        ref={materialRef}
        roughness={0.8}
        metalness={0.2}
        map={colorMapRef.current}
        normalMap={normalMapRef.current}
        displacementMap={displacementMapRef.current}
        displacementScale={8}
        displacementBias={0}
      />
    </mesh>
  );
};

const InnerScene = ({ images }) => {
  return (
    <group name="innerScene">
      <Stars />
      <ambientLight intensity={1} />
      <pointLight
        position={[2, 5, 4]}
        intensity={1}
        color={"#ffffff"}
        castShadow
        shadow-mapSize={[1024, 1024]}
        shadow-camera-near={0.1}
        shadow-camera-far={50}
        shadow-camera-top={10}
        shadow-camera-right={10}
        shadow-camera-bottom={-10}
        shadow-camera-left={-10}
        shadow-radius={100}
        shadow-bias={-0.0001}
      />

      {/* <TextModel position={[1.2, -0.6, 4]} rotation={[0, -Math.PI / 2, 0]} /> */}

      {/* <ProjectPlane position={[1.2, 0, 4]} rotation={[0, -Math.PI / 2, 0]} /> */}

      <Kreaton position={[0, -0.6, 4]} scale={0.5} rotation={[0, Math.PI, 0]} />
      <Armchair
        position={[0, -0.6, 4]}
        scale={0.5}
        rotation={[0, Math.PI, 0]}
        castShadow
        receiveShadow
      />

      {/* <mesh position={[-0.3, 1.48, 7.1]} rotation={[-Math.PI / 2, 0, 0]}>
          <sphereGeometry args={[0.4, 32, 32]} />
          <meshStandardMaterial color="red" />
          </mesh> */}

      <group position={[0, -0.5, 0]}>
        <Frames images={images} />

        <AnimatedMoon
          position={[1, -0.74, -3]}
          rotation={[-Math.PI / 2, 0, -Math.PI / 3]}
          scale={0.7}
        />
      </group>
      <ContactShadows
        frames={1}
        opacity={1}
        scale={10}
        blur={1}
        far={10}
        position={[0, -0.6, 0]}
        resolution={256}
        color="#000000"
      />
    </group>
  );
};

export default App;
