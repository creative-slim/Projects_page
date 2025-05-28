import { useGLTF } from '@react-three/drei'
import { useState, useEffect } from 'react';
import { devLog, devWarn, devError } from './devLog'

export function useModelLoader(localModelUrl, remoteModelUrl) {
    const isDevelopment = import.meta.env.DEV;
    const modelUrl = isDevelopment ? localModelUrl : remoteModelUrl;
    const [loading, setLoading] = useState(true);
    const result = useGLTF(modelUrl);

    useEffect(() => {
        if (result && result.scene) {
            setLoading(false);
        }
    }, [result]);

    devLog(`Loading model from: ${modelUrl} (loading: ${loading})`);

    return { ...result, loading };
}

// Preload function to be used in the main component
export function preloadModel(localModelUrl, remoteModelUrl) {
    const isDevelopment = import.meta.env.DEV;
    const modelUrl = isDevelopment ? localModelUrl : remoteModelUrl;
    useGLTF.preload(modelUrl);
} 