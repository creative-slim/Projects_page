import { useRef, useMemo } from 'react';
import { useFrameRate } from './useFrameRate';

/**
 * Optimized particle system hook with pre-calculated values
 * @param {number} count - Number of particles
 * @param {Object} options - Configuration options
 */
export const useOptimizedParticles = (count = 50, options = {}) => {
    const {
        maxRadius = 0.8,
        floatSpeed = 0.5,
        floatAmplitude = 0.001,
        dampening = 0.998,
        bounds = { z: 0.15 }
    } = options;

    // Pre-calculate sine/cosine values for better performance
    const preCalculatedValues = useMemo(() => {
        const values = [];
        for (let i = 0; i < count; i++) {
            values.push({
                sin: Math.sin(i * 0.1),
                cos: Math.cos(i * 0.1),
                speed: floatSpeed + (i % 3) * 0.3,
                amplitude: floatAmplitude + (i % 2) * 0.0005,
                phase: i * 0.1
            });
        }
        return values;
    }, [count, floatSpeed, floatAmplitude]);

    const positions = useRef(new Float32Array(count * 3));
    const velocities = useRef(new Float32Array(count * 3));

    // Initialize particle positions and velocities
    useMemo(() => {
        for (let i = 0; i < count * 3; i += 3) {
            positions.current[i] = (Math.random() - 0.5) * 2;
            positions.current[i + 1] = (Math.random() - 0.5) * 2;
            positions.current[i + 2] = (Math.random() - 0.5) * 0.3;

            velocities.current[i] = (Math.random() - 0.5) * 0.001;
            velocities.current[i + 1] = (Math.random() - 0.5) * 0.001;
            velocities.current[i + 2] = (Math.random() - 0.5) * 0.0002;
        }
    }, [count]);

    const updateParticles = (state) => {
        const time = state.clock.elapsedTime;
        const pos = positions.current;
        const vel = velocities.current;

        for (let i = 0; i < count * 3; i += 3) {
            const particleIndex = i / 3;
            const preCalc = preCalculatedValues[particleIndex];

            // Update positions based on velocities
            pos[i] += vel[i];
            pos[i + 1] += vel[i + 1];
            pos[i + 2] += vel[i + 2];

            // Add optimized floating motion using pre-calculated values
            const timeOffset = time * preCalc.speed + preCalc.phase;
            pos[i] += Math.sin(timeOffset) * preCalc.amplitude;
            pos[i + 1] += Math.cos(timeOffset * 0.7) * preCalc.amplitude;
            pos[i + 2] += Math.sin(timeOffset * 0.5) * preCalc.amplitude * 0.5;

            // Dampen velocities
            vel[i] *= dampening;
            vel[i + 1] *= dampening;
            vel[i + 2] *= dampening;

            // Keep particles within circular bounds
            const distance = Math.sqrt(pos[i] * pos[i] + pos[i + 1] * pos[i + 1]);
            if (distance > maxRadius) {
                const angle = Math.atan2(pos[i + 1], pos[i]);
                pos[i] = Math.cos(angle) * maxRadius * 0.9;
                pos[i + 1] = Math.sin(angle) * maxRadius * 0.9;

                // Bounce off boundary
                vel[i] *= -0.3;
                vel[i + 1] *= -0.3;
            }

            // Keep z position within bounds
            if (Math.abs(pos[i + 2]) > bounds.z) {
                pos[i + 2] = Math.sign(pos[i + 2]) * bounds.z;
                vel[i + 2] *= -0.3;
            }
        }
    };

    // Run particle updates at 30fps instead of 60fps
    useFrameRate(updateParticles, 30);

    return {
        positions: positions.current,
        velocities: velocities.current,
        count
    };
}; 