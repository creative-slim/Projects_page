/*
Auto-generated by: https://github.com/pmndrs/gltfjsx
Command: npx gltfjsx@6.5.3 ./public/models/projekte-2.glb --transform 
Files: ./public/models/projekte-2.glb [105.18KB] > /Users/slim-cd/Documents/_Projects/__Creative Directors Website/website 2025/Projects_page/projekte-2-transformed.glb [10.63KB] (90%)
*/

import React, { useEffect } from "react";
import { ContactShadows, useGLTF, useHelper } from "@react-three/drei";
import { Color, MeshBasicMaterial, ShaderMaterial } from "three";
import {
  useCursor,
  Outlines,
  AccumulativeShadows,
  RandomizedLight,
  OrbitControls,
  Bounds,
  Environment,
} from "@react-three/drei";
import { useThree, useFrame } from "@react-three/fiber";
import { useRef } from "react";
import * as THREE from "three";

export function ProjectPlane(props) {
  const textObj = useRef();
  const lightRef = useRef();
  const planeText = useRef();
  const planeObj = useRef();
  const { scene, size, camera } = useThree();

  const { nodes, materials } = useGLTF("/models/projekte-2-transformed.glb");
  useHelper(lightRef, THREE.DirectionalLightHelper, 0.5, "red");

  useEffect(() => {
    const handleMouseMove = (event) => {
      const normalizedY = (event.clientY / size.height) * 2 - 1; // Normalize mouse Y to range [-1, 1]
      const normalizedZ = (event.clientX / size.width) * 2 - 1; // Normalize mouse X to range [-1, 1]
      if (lightRef.current) {
        lightRef.current.position.z = THREE.MathUtils.lerp(
          -14, // Removed zMin
          14, // Removed zMax
          (normalizedZ + 1) / 2
        ); // Map to range [zMin, zMax] for Z-axis
      }
    };
    console.log(textObj.current.position);

    window.addEventListener("mousemove", handleMouseMove);
    return () => window.removeEventListener("mousemove", handleMouseMove);
  }, [size, camera]);

  useFrame(() => {
    if (lightRef.current && textObj.current) {
      lightRef.current.target = textObj.current; // Ensure the light targets the text object
    }
    // if (planeObj.current && planeObj.current.material) {
    //   planeObj.current.material.color = new THREE.Color("#F4E7D7"); // Default plane color
    //   planeObj.current.material.metalness = 0.16; // Default metalness
    //   planeObj.current.material.roughness = 0.5; // Default roughness
    //   planeObj.current.material.reflectivity = 0.5; // Default reflectivity
    // }
  });

  return (
    <group {...props} dispose={null}>
      {/* <directionalLight
        ref={lightRef}
        scale={[0.5, 0.5, 3]}
        intensity={0.5} // Default intensity
        color={"#ffffff"} // Default color
        position={[4, 5, 0]}
        castShadow
        shadow-mapSize={[2048, 2048]}
        shadow-radius={2000} // Increased shadow radius for softer shadows
        // shadow-bias={-0.0005} // Adjusted bias to reduce shadow artifacts
      /> */}
      <mesh
        name="Text"
        ref={textObj}
        geometry={nodes.Text.geometry}
        material={nodes.Text.material}
        position={[3.725, -0.9, 0]}
        rotation={[Math.PI / 2, 0, -Math.PI / 2]}
        scale={[2.444, 2.444, 2.444]}
        castShadow
        receiveShadow
      >
        <meshPhysicalMaterial
          color={new Color("#F4E7D7")} // Exaggerated #F4E7D7
          // emissive={new Color("#F4E7D7")} // Emissive color
          emissiveIntensity={0.5} // Emissive intensity
          toneMapped={false}
        />
      </mesh>

      {/* <mesh
        ref={planeObj}
        name="Plane"
        castShadow
        receiveShadow
        geometry={nodes.Plane.geometry}
        material={materials.Material}
      >
        <meshPhysicalMaterial
          color={"#F4E7D7"} // Default plane color
          // metalness={0.16} // Default metalness
          roughness={1} // Default roughness
          emissive={new Color("#F4E7D7")} // Emissive color
          emissiveIntensity={0.1} // Emissive intensity
          reflectivity={0.5} // Default reflectivity
          opacity={1}
        />
      </mesh> */}
    </group>
  );
}

useGLTF.preload("/models/projekte-2-transformed.glb");
