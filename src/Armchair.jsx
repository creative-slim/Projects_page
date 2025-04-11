/*
Auto-generated by: https://github.com/pmndrs/gltfjsx
Command: npx gltfjsx@6.5.3 ./public/Armchair.glb --transform 
Files: ./public/Armchair.glb [5.28MB] > /Users/slim-cd/Documents/_Projects/__Creative Directors Website/website 2025/react-3D/cd25_website/Armchair-transformed.glb [1.59MB] (70%)
*/

import React from "react";
import { useGLTF } from "@react-three/drei";

export function Armchair(props) {
  const { nodes, materials } = useGLTF("/models/Armchair-transformed.glb");
  return (
    <group {...props} dispose={null}>
      <mesh
        geometry={nodes.Wide_cloth_arm_chair.geometry}
        material={materials["Wide cloth chair.001"]}
      />
    </group>
  );
}

useGLTF.preload("/models/Armchair-transformed.glb");
