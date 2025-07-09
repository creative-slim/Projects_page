import { useRef } from "react";
import { Stars } from "@react-three/drei";
import { useFrameRate } from "./utils/useFrameRate";

export default function AnimatedStars(props) {
    const starsRef = useRef();

    useFrameRate((state, delta) => {
        if (starsRef.current) {
            starsRef.current.rotation.y += delta * 0.01; // Slow rotation
            starsRef.current.rotation.x += delta * 0.002; // Subtle drift
        }
    }, 30); // Reduced from 60fps to 30fps

    return (
        <group ref={starsRef}>
            <Stars {...props} />
        </group>
    );
} 