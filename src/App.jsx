import * as THREE from "three";
import { useEffect, useRef, useState } from "react"; // Import useState
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
import getUuid from "uuid-by-string";

import { AccumulativeShadows, RandomizedLight } from "@react-three/drei";
import { Kreaton } from "./Kreaton_A";
import { Armchair } from "./Armchair";
import { ProjectPlane } from "./Projekte-2";
import Frames from "./Frames";

import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Heading } from "./Site-headings";

import getApiData from "./images";

gsap.registerPlugin(ScrollTrigger);

const GOLDENRATIO = 1.61803398875;

// --- Camera Configuration ---
const section1Position = new THREE.Vector3(0, 8, 5);
const section2Position = new THREE.Vector3(0, 0.8, 7.5);
const section2LookAtTarget = new THREE.Vector3(0, 0, -5);
// --- End Camera Configuration ---

// Determine the model URL based on the environment
const isDevelopment = import.meta.env.DEV;
const localimages = {
  color: "/terrain_color_4x_blobby.jpg",
  normal: "/terrain_normal_4x_blobby.jpg",
  height: "/terrain_height_4x_blobby.jpg",
};
const remoteImages = {
  color:
    "https://files.creative-directors.com/creative-website/creative25/scenes_imgs/terrain_color_4x_blobby.jpg",
  normal:
    "https://files.creative-directors.com/creative-website/creative25/scenes_imgs/terrain_normal_4x_blobby.jpg",
  height:
    "https://files.creative-directors.com/creative-website/creative25/scenes_imgs/terrain_height_4x_blobby.jpg",
};
const img = isDevelopment ? localimages : remoteImages;

console.log(`Loading model from: ${img}`); // Log which URL is being used

// Helper component to apply lookAt smoothly using the proxy target
// Only applies lookAt when not zoomed into a frame
function CameraUpdater({ lookAtTarget, isZoomed }) {
  const { camera } = useThree();
  useFrame(() => {
    // Only let GSAP control lookAt when not zoomed
    if (!isZoomed) {
      camera.lookAt(lookAtTarget.current);
    }
  });
  return null;
}

// New component to handle GSAP setup and useThree hook
function SceneSetup({ projectTextRef, isZoomed }) {
  // Receive isZoomed prop
  const { camera } = useThree();
  const section1LookAtTarget = useRef(new THREE.Vector3(0, 8, -10)).current;
  const proxyLookAtTarget = useRef(
    new THREE.Vector3().copy(section1LookAtTarget)
  );
  const scrollTriggerRef = useRef(null); // Ref to store ScrollTrigger instance

  // GSAP ScrollTrigger setup effect
  useEffect(() => {
    camera.position.copy(section1Position);
    camera.lookAt(proxyLookAtTarget.current);

    const tl = gsap.timeline({
      scrollTrigger: {
        trigger: document.documentElement,
        start: "top top",
        end: "+=100%",
        scrub: 1,
        snap: {
          snapTo: "labels",
          duration: { min: 0.2, max: 1 },
          delay: 0.1,
          ease: "power1.inOut",
        },
        // markers: true,
        // Store the instance
        onInit: (self) => (scrollTriggerRef.current = self),
      },
    });

    // Define animation states
    tl.addLabel("section1")
      .to(
        camera.position,
        {
          x: section1Position.x,
          y: section1Position.y,
          z: section1Position.z,
          duration: 1,
        },
        "section1"
      )
      .to(
        proxyLookAtTarget.current,
        {
          x: section1LookAtTarget.x,
          y: section1LookAtTarget.y,
          z: section1LookAtTarget.z,
          duration: 1,
        },
        "section1"
      );

    tl.addLabel("section2")
      .to(
        camera.position,
        {
          x: section2Position.x,
          y: section2Position.y,
          z: section2Position.z,
          duration: 1,
        },
        "section2"
      )
      .to(
        proxyLookAtTarget.current,
        {
          x: section2LookAtTarget.x,
          y: section2LookAtTarget.y,
          z: section2LookAtTarget.z,
          duration: 1,
        },
        "section2"
      );

    return () => {
      scrollTriggerRef.current?.kill(); // Kill on unmount
      tl.kill();
    };
  }, [camera, section1LookAtTarget]);

  // Effect to enable/disable ScrollTrigger based on isZoomed state
  useEffect(() => {
    const st = scrollTriggerRef.current; // Get the ScrollTrigger instance
    if (st) {
      if (isZoomed) {
        console.log("Disabling ScrollTrigger");
        st.disable(false); // Disable but don't revert position immediately
      } else {
        console.log("Enabling ScrollTrigger and updating");
        st.enable(); // Re-enable
        st.update(); // Force immediate update based on scroll position
      }
    }
  }, [isZoomed]); // Run when isZoomed changes

  // Pass isZoomed to CameraUpdater
  return <CameraUpdater lookAtTarget={proxyLookAtTarget} isZoomed={isZoomed} />;
}

const App = ({}) => {
  const innerSceneRef = useRef();
  const projectTextRef = useRef();
  const [isZoomed, setIsZoomed] = useState(false); // State to track zoom

  // use getApiData to fetch images
  const [images, setImages] = useState([]);
  useEffect(() => {
    const fetchImages = async () => {
      const data = await getApiData();
      setImages(data);
    };
    fetchImages();
  }, []);
  console.log("Images:", images);

  return (
    <>
      <Canvas
        shadows
        dpr={[1, 1.5]}
        gl={{ antialias: true }}
        camera={{ fov: 50, position: section1Position.toArray() }}
        flat
      >
        <color attach="background" args={["#000000"]} />
        <fog attach="fog" args={["#000000", 0, 50]} />

        {/* Render SceneSetup inside Canvas */}
        <SceneSetup projectTextRef={projectTextRef} isZoomed={isZoomed} />

        {/* <Resize width={1000} height={1000}> */}
        {/* <ProjectPlane
          ref={projectTextRef}
          rotation={[0.1, Math.PI / -2, 0]}
          position={[0, 8, -10]}
          scale={1}
          castShadow
          receiveShadow
        /> */}

        <Heading
          position={[0.2, 7.8, -5]}
          scale={2.5}
          rotation={[Math.PI / 2, 0, 0]}
          castShadow
        />
        <InnerScene
          images={images}
          ref={innerSceneRef}
          setIsZoomed={setIsZoomed}
          // Pass down section 2 camera targets
          section2Position={section2Position}
          section2LookAtTarget={section2LookAtTarget}
        />
        {/* <Environment preset="city" /> */}
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
    new THREE.TextureLoader().load(img.color, (texture) => {
      texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
      texture.repeat.set(1, 1);
    })
  );

  const normalMapRef = useRef(
    new THREE.TextureLoader().load(img.normal, (texture) => {
      texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
      texture.repeat.set(1, 1);
    })
  );

  const displacementMapRef = useRef(new THREE.TextureLoader().load(img.height));

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

// Pass props down to Frames
const InnerScene = ({
  images,
  setIsZoomed,
  section2Position,
  section2LookAtTarget,
}) => {
  return (
    <group name="innerScene">
      <Stars />
      <ambientLight intensity={1} />
      <pointLight
        position={[2, 5, 4]}
        intensity={50}
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
        {/* Pass props to Frames */}
        <Frames
          images={images}
          setIsZoomed={setIsZoomed}
          section2Position={section2Position}
          section2LookAtTarget={section2LookAtTarget}
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
    </group>
  );
};

export default App;
