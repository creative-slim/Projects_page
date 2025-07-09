import { useRef, useEffect, useState } from 'react';
import { useFrame } from '@react-three/fiber';

/**
 * Hook to monitor performance metrics
 * @param {Object} options - Configuration options
 */
export const usePerformanceMonitor = (options = {}) => {
    const {
        enabled = true,
        logInterval = 5000, // Log every 5 seconds
        warningThreshold = 50, // FPS warning threshold
        criticalThreshold = 30 // FPS critical threshold
    } = options;

    const [metrics, setMetrics] = useState({
        fps: 0,
        memory: 0,
        quality: 'high'
    });

    const frameCountRef = useRef(0);
    const lastTimeRef = useRef(0);
    const lastLogTimeRef = useRef(0);

    useFrame((state) => {
        if (!enabled) return;

        frameCountRef.current++;
        const currentTime = state.clock.elapsedTime * 1000; // Convert to milliseconds

        // Calculate FPS every second
        if (currentTime - lastTimeRef.current >= 1000) {
            const fps = Math.round((frameCountRef.current * 1000) / (currentTime - lastTimeRef.current));

            // Get memory info if available
            let memory = 0;
            if (performance.memory) {
                memory = Math.round(performance.memory.usedJSHeapSize / 1024 / 1024); // MB
            }

            // Determine quality level
            let quality = 'high';
            if (fps < criticalThreshold) {
                quality = 'low';
            } else if (fps < warningThreshold) {
                quality = 'medium';
            }

            setMetrics({ fps, memory, quality });

            // Log performance issues
            if (currentTime - lastLogTimeRef.current >= logInterval) {
                if (fps < criticalThreshold) {
                    console.warn(`Performance Critical: ${fps} FPS, ${memory}MB memory`);
                } else if (fps < warningThreshold) {
                    console.warn(`Performance Warning: ${fps} FPS, ${memory}MB memory`);
                } else {
                    console.log(`Performance OK: ${fps} FPS, ${memory}MB memory`);
                }
                lastLogTimeRef.current = currentTime;
            }

            frameCountRef.current = 0;
            lastTimeRef.current = currentTime;
        }
    });

    return metrics;
};

/**
 * Hook to adapt quality based on performance
 * @param {Object} options - Configuration options
 */
export const useAdaptiveQuality = (options = {}) => {
    const {
        highFps = 60,
        mediumFps = 30,
        lowFps = 15,
        checkInterval = 2000
    } = options;

    const [quality, setQuality] = useState('high');
    const { fps } = usePerformanceMonitor({ enabled: true, logInterval: checkInterval });

    useEffect(() => {
        if (fps < 30) {
            setQuality('low');
        } else if (fps < 50) {
            setQuality('medium');
        } else {
            setQuality('high');
        }
    }, [fps]);

    const getFrameRate = () => {
        switch (quality) {
            case 'low': return lowFps;
            case 'medium': return mediumFps;
            case 'high': return highFps;
            default: return highFps;
        }
    };

    const shouldRenderEffects = () => {
        return quality !== 'low';
    };

    const getParticleCount = (baseCount) => {
        switch (quality) {
            case 'low': return Math.floor(baseCount * 0.3);
            case 'medium': return Math.floor(baseCount * 0.6);
            case 'high': return baseCount;
            default: return baseCount;
        }
    };

    return {
        quality,
        fps,
        getFrameRate,
        shouldRenderEffects,
        getParticleCount
    };
}; 