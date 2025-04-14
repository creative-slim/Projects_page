import { MeshPhysicalMaterial, Color } from "three";
import { extend } from "@react-three/fiber";

// Register the material for JSX usage
extend({ MeshPhysicalMaterial });

// Create the gold color (RGB: 238, 208, 145)
const kreatonGoldColor = new Color("#fad078");

// Material instance for direct usage
export const kreatonGoldMaterial = new MeshPhysicalMaterial({
  color: kreatonGoldColor,
  roughness: 0.2,
  metalness: 1,
  reflectivity: 0.5,
  //emissive: kreatonGoldColor,
  // emissiveIntensity: 1,
  // ior: 1.5,
  // sheenRoughness: 1,
});

// React component version for JSX contexts
export function KreatonGoldMaterial(props) {
  return (
    <meshPhysicalMaterial
      // color={kreatonGoldColor}
      // roughness={0.3}
      // metalness={1}
      // reflectivity={0.5}
      // emissiveIntensity={1}
      {...props}
    />
  );
}
