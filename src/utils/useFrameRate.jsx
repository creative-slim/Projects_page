import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { useState } from 'react';

/**
 * Custom hook to limit frame rate for performance optimization
 * @param {Function} callback - The function to call at the specified frame rate
 * @param {number} fps - Target frame rate (default: 30)
 * @param {boolean} enabled - Whether the hook is enabled (default: true)
 */
export const useFrameRate = (callback, fps = 30, enabled = true) => {
    const frameRef = useRef(0);
    const lastTimeRef = useRef(0);

    useFrame((state, delta) => {
        if (!enabled) return;

        frameRef.current += delta;
        const targetInterval = 1 / fps;

        if (frameRef.current >= targetInterval) {
            const currentTime = state.clock.elapsedTime;
            const actualDelta = currentTime - lastTimeRef.current;

            callback(state, actualDelta);

            frameRef.current = 0;
            lastTimeRef.current = currentTime;
        }
    });
};

/**
 * Hook for conditional frame rate limiting based on performance
 * @param {Function} callback - The function to call
 * @param {Object} options - Configuration options
 */
export const useAdaptiveFrameRate = (callback, options = {}) => {
    const {
        highFps = 60,
        mediumFps = 30,
        lowFps = 15,
        performanceThreshold = 50
    } = options;

    const [currentFps, setCurrentFps] = useState(highFps);
    const frameCountRef = useRef(0);
    const lastFpsCheckRef = useRef(0);

    useFrame((state, delta) => {
        frameCountRef.current++;
        const currentTime = state.clock.elapsedTime;

        // Check performance every second
        if (currentTime - lastFpsCheckRef.current >= 1) {
            const actualFps = frameCountRef.current / (currentTime - lastFpsCheckRef.current);

            // Adjust frame rate based on performance
            if (actualFps < performanceThreshold * 0.8) {
                setCurrentFps(lowFps);
            } else if (actualFps < performanceThreshold) {
                setCurrentFps(mediumFps);
            } else {
                setCurrentFps(highFps);
            }

            frameCountRef.current = 0;
            lastFpsCheckRef.current = currentTime;
        }
    });

    useFrameRate(callback, currentFps);
}; 