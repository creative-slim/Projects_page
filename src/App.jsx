import * as THREE from "three";
import { useEffect, useRef, useState } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
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
import { useControls } from "leva";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { Kreaton } from "./Kreaton_A";
import { Armchair } from "./Armchair";
import { ProjectPlane } from "./Projekte-2";
import Frames from "./Frames";

const GOLDENRATIO = 1.61803398875;

const App = ({ images }) => {
  const [isCloseCamera, setIsCloseCamera] = useState(false);

  // Add Leva controls for camera settings with X and Y positions
  const {
    fov,
    farDistance,
    closeDistance,
    closePositionX,
    closePositionY,
    farPositionX,
    farPositionY,
  } = useControls("Camera", {
    fov: { value: 70, min: 30, max: 120, step: 1 },
    farDistance: { value: 10.5, min: 5, max: 30, step: 0.1 },
    closeDistance: { value: 5.5, min: 1, max: 10, step: 0.1 },
    farPositionX: { value: 0, min: -10, max: 10, step: 0.1 },
    farPositionY: { value: 2, min: -10, max: 10, step: 0.1 },
    closePositionX: { value: 0, min: -10, max: 10, step: 0.1 },
    closePositionY: { value: 0, min: -10, max: 10, step: 0.1 },
  });

  useEffect(() => {
    const handleScroll = () => {
      const scrollPosition = window.scrollY;
      const windowHeight = window.innerHeight;
      setIsCloseCamera(scrollPosition > windowHeight * 0.5); // 50vh threshold
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <>
      <Canvas
        shadows
        dpr={[1, 1.5]}
        gl={{ antialias: true }}
        camera={{ fov: fov, position: [0, 2, 10] }}
        flat
      >
        <Stars />
        <ambientLight intensity={1} />
        <pointLight
          position={[2, 5, 4]}
          intensity={150}
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
        <color attach="background" args={["#000000"]} />
        <fog attach="fog" args={["#000000", 0, 30]} />
        {/* <TextModel position={[1.2, -0.6, 4]} rotation={[0, -Math.PI / 2, 0]} /> */}

        {/* <ProjectPlane position={[1.2, 0, 4]} rotation={[0, -Math.PI / 2, 0]} /> */}

        <Kreaton
          position={[0, -0.6, 4]}
          scale={0.5}
          rotation={[0, Math.PI, 0]}
        />
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
          <Frames
            images={images}
            isCloseCamera={isCloseCamera}
            farDistance={farDistance}
            closeDistance={closeDistance}
            farPositionX={farPositionX}
            farPositionY={farPositionY}
            closePositionX={closePositionX}
            closePositionY={closePositionY}
          />

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

        {/* <Environment preset="city" /> */}
        <OrbitControls />
        <EffectComposer>
          <Vignette eskil={false} offset={0.1} darkness={1.1} />

          {/* <Bloom mipmapBlur luminanceThreshold={1} intensity={1} /> */}
          {/* No ToneMapping needed here since it's in Canvas */}
        </EffectComposer>
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

export default App;
