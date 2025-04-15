/*
Auto-generated by: https://github.com/pmndrs/gltfjsx
Command: npx gltfjsx@6.5.3 ./public/models/site-headings.glb --transform 
Files: ./public/models/site-headings.glb [2MB] > /Users/slim-cd/Documents/_Projects/__Creative Directors Website/website 2025/Projects_page/site-headings-transformed.glb [173.8KB] (91%)
*/

import React from 'react'
import { useGLTF } from '@react-three/drei'

export function Model(props) {
  const { nodes, materials } = useGLTF('/site-headings-transformed.glb')
  return (
    <group {...props} dispose={null}>
      <mesh geometry={nodes.Text008.geometry} material={materials.blau} position={[-5.821, -0.031, -2.622]} scale={[1, 0.423, 1]} />
      <mesh geometry={nodes.Text009.geometry} material={materials.weiß} position={[-9.172, -0.025, -2.642]} scale={[1, 0.423, 1]} />
    </group>
  )
}

useGLTF.preload('/site-headings-transformed.glb')
