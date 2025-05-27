import { useGLTF } from '@react-three/drei'

export function useModelLoader(localModelUrl, remoteModelUrl) {
    const isDevelopment = import.meta.env.DEV;
    const modelUrl = isDevelopment ? localModelUrl : remoteModelUrl;
    const result = useGLTF(modelUrl);

    // Log which URL is being used
    console.log(`Loading model from: ${modelUrl}`);

    return result;
}

// Preload function to be used in the main component
export function preloadModel(localModelUrl, remoteModelUrl) {
    const isDevelopment = import.meta.env.DEV;
    const modelUrl = isDevelopment ? localModelUrl : remoteModelUrl;
    useGLTF.preload(modelUrl);
} 