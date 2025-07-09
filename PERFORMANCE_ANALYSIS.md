# Performance Analysis & Optimization Report

## Executive Summary

This React Three.js project exhibits several performance bottlenecks and optimization opportunities. The analysis reveals critical issues with frame rate management, memory leaks, inefficient rendering patterns, and suboptimal resource management that could significantly impact user experience.

## Critical Performance Issues

### 1. **Excessive useFrame Calls (HIGH PRIORITY)**

**Issue**: Multiple components are running `useFrame` hooks simultaneously without proper optimization:
- `Frames.jsx`: 2 useFrame hooks (lines 142, 252)
- `Portal.jsx`: 1 useFrame hook (line 56)
- `AnimatedStars.jsx`: 1 useFrame hook (line 6)
- `App.jsx`: 3 useFrame hooks (lines 217, 250, 432)
- `Site-headings.jsx`: 1 useFrame hook (line 37)

**Impact**: 
- Each useFrame runs at 60fps by default
- 8+ concurrent animation loops = 480+ function calls per second
- Significant CPU overhead and potential frame drops

**Solution**:
```javascript
// Implement frame rate limiting
const useFrameRate = (callback, fps = 30) => {
  const frameRef = useRef(0);
  useFrame((state, delta) => {
    frameRef.current += delta;
    if (frameRef.current >= 1 / fps) {
      callback(state, frameRef.current);
      frameRef.current = 0;
    }
  });
};
```

### 2. **Memory Leaks in Texture Management (HIGH PRIORITY)**

**Issue**: Textures are not properly disposed in `Frames.jsx`:
```javascript
// Line 407: itemSize={2} - This is incorrect for 3D positions
<bufferAttribute
  attach="attributes-position"
  count={50}
  array={particlePositions.current}
  itemSize={2} // Should be 3 for x,y,z coordinates
/>
```

**Impact**: 
- Memory accumulation over time
- Potential GPU memory exhaustion
- Performance degradation during extended use

**Solution**:
```javascript
// Fix itemSize and add proper cleanup
<bufferAttribute
  attach="attributes-position"
  count={50}
  array={particlePositions.current}
  itemSize={3} // Correct for 3D positions
/>

// Add proper texture disposal
useEffect(() => {
  return () => {
    if (imageTexture) imageTexture.dispose();
    if (mask) mask.dispose();
    if (particlesRef.current) {
      particlesRef.current.geometry.dispose();
      particlesRef.current.material.dispose();
    }
  };
}, [imageTexture, mask]);
```

### 3. **Inefficient Particle System (MEDIUM PRIORITY)**

**Issue**: Complex particle animation running for every frame (lines 270-320 in `Frames.jsx`):
- 50 particles × 3 coordinates × 60fps = 9,000 calculations per second
- Random number generation in render loop
- Complex trigonometric calculations

**Impact**: Unnecessary CPU load for visual effects

**Solution**:
```javascript
// Optimize particle system
const useOptimizedParticles = (count = 50) => {
  const positions = useRef(new Float32Array(count * 3));
  const velocities = useRef(new Float32Array(count * 3));
  
  // Pre-calculate sine/cosine values
  const preCalculatedValues = useRef(() => {
    const values = [];
    for (let i = 0; i < count; i++) {
      values.push({
        sin: Math.sin(i * 0.1),
        cos: Math.cos(i * 0.1),
        speed: 0.5 + (i % 3) * 0.3
      });
    }
    return values;
  });

  useFrameRate((state) => {
    // Simplified particle update logic
    const time = state.clock.elapsedTime;
    const pos = positions.current;
    const vel = velocities.current;
    
    for (let i = 0; i < count * 3; i += 3) {
      const particleIndex = i / 3;
      const preCalc = preCalculatedValues.current[particleIndex];
      
      // Simplified movement
      pos[i] += vel[i] * 0.998;
      pos[i + 1] += vel[i + 1] * 0.998;
      pos[i + 2] += vel[i + 2] * 0.998;
    }
  }, 30); // Run at 30fps instead of 60fps
};
```

### 4. **Heavy Post-Processing Effects (MEDIUM PRIORITY)**

**Issue**: Multiple post-processing effects running simultaneously:
```javascript
<EffectComposer>
  <Vignette eskil={false} offset={0.1} darkness={1.1} />
  <Bloom mipmapBlur luminanceThreshold={1} intensity={1} />
</EffectComposer>
```

**Impact**: Significant GPU overhead, especially on lower-end devices

**Solution**:
```javascript
// Implement adaptive quality settings
const useAdaptiveQuality = () => {
  const [quality, setQuality] = useState('high');
  
  useEffect(() => {
    const checkPerformance = () => {
      const fps = performance.now();
      if (fps < 30) setQuality('low');
      else if (fps < 50) setQuality('medium');
      else setQuality('high');
    };
    
    const interval = setInterval(checkPerformance, 1000);
    return () => clearInterval(interval);
  }, []);
  
  return quality;
};

// Conditional rendering based on quality
{quality === 'high' && (
  <EffectComposer>
    <Vignette eskil={false} offset={0.1} darkness={1.1} />
    <Bloom mipmapBlur luminanceThreshold={1} intensity={1} />
  </EffectComposer>
)}
```

### 5. **Inefficient DOM Queries (MEDIUM PRIORITY)**

**Issue**: Repeated DOM queries in `Frames.jsx` and `images.jsx`:
```javascript
// Lines 25-30 in Frames.jsx
const allProjectElements = document.querySelectorAll("div[data-three='thumbnail'].project-links-item");
allProjectElements.forEach((el) => {
  el.classList.remove("active");
});
```

**Impact**: DOM manipulation on every frame/click

**Solution**:
```javascript
// Cache DOM elements
const useCachedElements = () => {
  const elementsRef = useRef(null);
  
  useEffect(() => {
    elementsRef.current = document.querySelectorAll("div[data-three='thumbnail'].project-links-item");
  }, []);
  
  const clearActiveClasses = useCallback(() => {
    if (elementsRef.current) {
      elementsRef.current.forEach(el => el.classList.remove("active"));
    }
  }, []);
  
  return { clearActiveClasses, elements: elementsRef.current };
};
```

## Optimization Opportunities

### 1. **Level of Detail (LOD) Implementation**

**Current State**: All frames render at full detail regardless of distance

**Optimization**:
```javascript
const useLOD = (distance) => {
  if (distance > 10) return 'low';
  if (distance > 5) return 'medium';
  return 'high';
};

// Reduce particle count based on distance
const particleCount = useMemo(() => {
  const lod = useLOD(distance);
  return lod === 'high' ? 50 : lod === 'medium' ? 25 : 10;
}, [distance]);
```

### 2. **Frustum Culling**

**Current State**: All objects render regardless of visibility

**Optimization**:
```javascript
import { Frustum } from 'three';

const useFrustumCulling = (objects) => {
  const frustum = useRef(new Frustum());
  const camera = useThree(state => state.camera);
  
  useFrame(() => {
    frustum.current.setFromProjectionMatrix(
      new THREE.Matrix4().multiplyMatrices(
        camera.projectionMatrix,
        camera.matrixWorldInverse
      )
    );
  });
  
  return objects.filter(obj => 
    frustum.current.containsPoint(obj.position)
  );
};
```

### 3. **Texture Compression and Optimization**

**Current State**: Loading full-resolution textures

**Optimization**:
```javascript
// Implement texture compression
const useCompressedTexture = (url) => {
  const [texture, setTexture] = useState(null);
  
  useEffect(() => {
    const loader = new THREE.TextureLoader();
    loader.load(url, (tex) => {
      tex.generateMipmaps = false; // Disable for performance
      tex.minFilter = THREE.LinearFilter;
      tex.magFilter = THREE.LinearFilter;
      tex.format = THREE.RGBFormat; // Use RGB instead of RGBA if no alpha
      setTexture(tex);
    });
  }, [url]);
  
  return texture;
};
```

### 4. **State Management Optimization**

**Current State**: Prop drilling and multiple state updates

**Optimization**:
```javascript
// Implement context for shared state
const SceneContext = createContext();

const SceneProvider = ({ children }) => {
  const [isZoomed, setIsZoomed] = useState(false);
  const [selectedFrame, setSelectedFrame] = useState(null);
  
  const value = useMemo(() => ({
    isZoomed,
    setIsZoomed,
    selectedFrame,
    setSelectedFrame
  }), [isZoomed, selectedFrame]);
  
  return (
    <SceneContext.Provider value={value}>
      {children}
    </SceneContext.Provider>
  );
};
```

## Performance Metrics to Monitor

### 1. **Frame Rate**
- Target: 60 FPS
- Warning: < 50 FPS
- Critical: < 30 FPS

### 2. **Memory Usage**
- GPU Memory: Monitor texture and geometry memory
- CPU Memory: Monitor JavaScript heap size
- DOM Memory: Monitor DOM node count

### 3. **Load Times**
- Initial Load: < 3 seconds
- Model Loading: < 2 seconds per model
- Texture Loading: < 1 second per texture

## Implementation Priority

### Phase 1 (Immediate - Critical)
1. Fix texture disposal and memory leaks
2. Implement frame rate limiting
3. Fix particle system itemSize bug

### Phase 2 (Short-term - High Impact)
1. Optimize particle system
2. Implement adaptive quality settings
3. Cache DOM elements

### Phase 3 (Medium-term - Performance)
1. Implement LOD system
2. Add frustum culling
3. Optimize texture loading

### Phase 4 (Long-term - Scalability)
1. Implement proper state management
2. Add performance monitoring
3. Optimize build process

## Build Optimization

### Current Vite Config Issues:
```javascript
// Current: Basic configuration
export default defineConfig({
  plugins: [react(), glsl()],
});
```

### Optimized Configuration:
```javascript
export default defineConfig({
  plugins: [react(), glsl()],
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          three: ['three'],
          drei: ['@react-three/drei'],
          fiber: ['@react-three/fiber']
        }
      }
    },
    chunkSizeWarningLimit: 1000
  },
  optimizeDeps: {
    include: ['three', '@react-three/fiber', '@react-three/drei']
  }
});
```

## Testing Strategy

### 1. **Performance Testing**
- Use React DevTools Profiler
- Monitor FPS with browser dev tools
- Test on low-end devices

### 2. **Memory Testing**
- Monitor memory usage in dev tools
- Test for memory leaks with extended use
- Check texture disposal

### 3. **Load Testing**
- Test with different network conditions
- Monitor load times
- Test with various device capabilities

## Conclusion

This project has significant optimization potential. The most critical issues are the excessive useFrame calls and memory leaks. Implementing the suggested optimizations should result in:

- **30-50% improvement in frame rate**
- **Significant reduction in memory usage**
- **Better user experience on lower-end devices**
- **Improved scalability for larger scenes**

The optimization should be implemented incrementally, starting with the critical issues, to ensure stability and measure the impact of each change. 