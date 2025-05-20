import React, { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import * as THREE from 'three';

// Custom shader for animated rainbow gradient
const getGradientShader = (opacity = 0.7) => ({
    uniforms: {
        time: { value: 0 }
    },
    vertexShader: `
    varying vec3 vPos;
    void main() {
      vPos = position;
      gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    }
  `,
    fragmentShader: `
    uniform float time;
    varying vec3 vPos;
    // HSV to RGB conversion
    vec3 hsv2rgb(vec3 c) {
      vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
      vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
      return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
    }
    void main() {
      float angle = atan(vPos.y, vPos.x) + time;
      float t = mod(angle / (2.0 * 3.14159), 1.0);
      vec3 color = hsv2rgb(vec3(t, 1.0, 1.0));
      gl_FragColor = vec4(color, ${opacity.toFixed(2)});
    }
  `
});

/**
 * Portal component renders multiple animated rainbow portals (torus).
 * @param {Object} props
 * @param {Array} [props.configs] - Array of portal configs: { radius, tube, opacity, scale, position }
 * @param {Array} [props.position] - Position of the group
 * @param {Array} [props.scale] - Scale of the group
 */
export default function Portal({
    configs = [
        { radius: 0.48, tube: 0.045, opacity: 0.7 },
        { radius: 0.56, tube: 0.025, opacity: 0.4 },
        { radius: 0.62, tube: 0.012, opacity: 0.2 }
    ],
    position = [0, 0, 0],
    scale = [1, 1, 1]
}) {
    const meshRefs = useRef([]);

    useFrame((state) => {
        meshRefs.current.forEach((ref) => {
            if (ref && ref.material.uniforms) {
                ref.material.uniforms.time.value = state.clock.elapsedTime * 0.5;
            }
        });
    });

    return (
        <group position={position} scale={scale}>
            {configs.map((cfg, i) => (
                <mesh
                    key={i}
                    ref={el => meshRefs.current[i] = el}
                    raycast={() => null}
                >
                    <torusGeometry args={[cfg.radius, cfg.tube, 64, 128]} />
                    <shaderMaterial
                        attach="material"
                        args={[getGradientShader(cfg.opacity)]}
                        transparent
                        side={THREE.DoubleSide}
                        depthWrite={false}
                        blending={THREE.AdditiveBlending}
                    />
                </mesh>
            ))}
        </group>
    );
} 