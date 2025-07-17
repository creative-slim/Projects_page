import React, { useRef } from 'react';
import { useHelper } from '@react-three/drei';
import { PointLightHelper } from 'three';
import { useFrame } from '@react-three/fiber';

/**
 * FloatingLight
 * Renders a PointLight with a Drei PointLightHelper for visualization.
 * 
 * @param {object} props - Props to pass to the PointLight (e.g., position, intensity, color)
 */
export default function FloatingLight(props) {
    const lightRef = React.useRef();
    const lightRef2 = React.useRef();
    // useHelper(lightRef, PointLightHelper, 0.2, 'red');
    useFrame((state) => {
        const t = state.clock.getElapsedTime() / 1;
        lightRef.current.position.x = Math.sin(t) * 8;
        lightRef.current.position.z = -Math.cos(t) * 5 - 10;

        lightRef2.current.position.x = -Math.sin(t - 1.5) * 8;
        lightRef2.current.position.z = -Math.cos(t - 1.5) * 5 - 10;
    });
    return (
        <>
            <pointLight ref={lightRef} {...props} intensity={30}
                //  distance={10}
                color="hotpink" />

            <pointLight ref={lightRef2} {...props} intensity={30}
                //  distance={10}
                color="yellow" />
        </>
    );
}
