import { MeshPhysicalMaterial, Color } from "three";
import { extend } from "@react-three/fiber";

// Register the material for JSX usage
extend({ MeshPhysicalMaterial });

// Create the Armor color (RGB: 238, 208, 145)
const kreatonArmorColor = new Color("#FFF4E5");

// Material instance for direct usage
export const kreatonArmorMaterial = new MeshPhysicalMaterial({
  color: kreatonArmorColor,
  roughness: 0.2,
  metalness: 0.4,
  reflectivity: 0.5,
  iridescence: 0.5,
  //   emissive: kreatonArmorColor,
  emissiveIntensity: 1,
  //   ior: 1.5,
  //   sheenRoughness: 1,
});

// React component version for JSX contexts
// export function KreatonArmorMaterial(props) {
//   return (
//     <meshPhysicalMaterial
//       color={kreatonArmorColor}
//       //   roughness={0.33}
//       //   metalness={0.33}
//       //   reflectivity={0.5}
//       //   emissiveIntensity={1}
//       {...props}
//     />
//   );
// }
