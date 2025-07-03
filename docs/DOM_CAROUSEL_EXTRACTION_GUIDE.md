# DOM-Based Carousel Data Extraction Guide

## Overview

This guide provides a comprehensive approach to refactor a carousel component that currently fetches project data from an API to instead extract the data directly from the DOM, similar to the pattern used in the reference implementation.

## Current State vs Target State

### Current State
- The carousel currently receives data via props or API calls
- Project images and metadata are fetched from a backend service
- The component renders based on this external data source

### Target State
- Extract carousel data directly from existing DOM elements
- Look for elements with specific data attributes or classes
- Parse image URLs from `<img>` tags, handling srcset attributes
- Assign data-carousel-index attributes for easier matching
- Maintain the same visual and interaction behavior

## Key Requirements

### 1. DOM Extraction Function

Create a utility function that scans the DOM for project elements:

- Look for elements with classes like `project-links-item` or similar
- Extract image URLs from `<img>` tags, prioritizing specific srcset sizes (e.g., 720w)
- Handle cases where images might be in srcset format
- Assign `data-carousel-index` attributes to both wrapper and image elements

### 2. Data Structure

Return an array of objects with the following structure:
```javascript
{
  imgEl: HTMLImageElement,
  wrapperEl: HTMLElement,
  imageUrl: string,
  index: number
}
```

- Limit the number of items (e.g., first 6 projects)
- Maintain the same data structure the carousel expects

### 3. Integration Points

- Replace API calls with DOM extraction on component mount
- Update any state management to use the extracted data
- Ensure the carousel renders the same way with DOM data
- Maintain all existing hover, click, and interaction behaviors

### 4. Error Handling

- Gracefully handle cases where DOM elements don't exist
- Provide fallbacks for missing image URLs
- Log extraction results for debugging

## Reference Implementation Pattern

```javascript
const extractCarouselDataFromDOM = () => {
  const wrappers = Array.from(document.querySelectorAll('div[data-three="thumbnail"].project-links-item'));
  const data = wrappers.slice(0, NUM_CARDS_TO_DISPLAY).map((wrapper, idx) => {
    const img = wrapper.querySelector('img');
    let imageUrl = img ? img.getAttribute('src') : null;
    if (!imageUrl && img && img.getAttribute('srcset')) {
      const srcset = img.getAttribute('srcset');
      const match = srcset.match(/([^\s]+)\s+720w/);
      if (match) imageUrl = match[1];
      else imageUrl = srcset.split(',')[0].split(' ')[0];
    }
    wrapper.setAttribute('data-carousel-index', idx);
    if (img) img.setAttribute('data-carousel-index', idx);
    return { imgEl: img, wrapperEl: wrapper, imageUrl, index: idx };
  });
  return data;
};
```

## Implementation Steps

### Step 1: Create the Extraction Function
```javascript
// Utility to extract carousel data from DOM
const extractCarouselDataFromDOM = () => {
  const wrappers = Array.from(document.querySelectorAll('div[data-three="thumbnail"].project-links-item'));
  const data = wrappers.slice(0, NUM_CARDS_TO_DISPLAY).map((wrapper, idx) => {
    // Find the first <img> inside
    const img = wrapper.querySelector('img');
    let imageUrl = img ? img.getAttribute('src') : null;
    if (!imageUrl && img && img.getAttribute('srcset')) {
      // Try to find 720w in srcset
      const srcset = img.getAttribute('srcset');
      const match = srcset.match(/([^\s]+)\s+720w/);
      if (match) imageUrl = match[1];
      else imageUrl = srcset.split(',')[0].split(' ')[0]; // fallback to first
    }
    // Assign data-carousel-index for easier matching
    wrapper.setAttribute('data-carousel-index', idx);
    if (img) img.setAttribute('data-carousel-index', idx);
    return { imgEl: img, wrapperEl: wrapper, imageUrl, index: idx };
  });
  console.log('[CAROUSEL] Extracted carousel data:', data);
  return data;
};
```

### Step 2: Replace API Calls with DOM Extraction
```javascript
// Replace this:
// const [carouselData, setCarouselData] = useState([]);
// useEffect(() => {
//   fetch('/api/projects').then(res => res.json()).then(setCarouselData);
// }, []);

// With this:
const [carouselData, setCarouselData] = useState([]);
const [isLoading, setIsLoading] = useState(true);

useEffect(() => {
  // Extract carousel data from DOM on mount
  setIsLoading(true);
  const data = extractCarouselDataFromDOM();
  setCarouselData(data);
  setIsLoading(false);
}, []);
```

### Step 3: Update Component Rendering
```javascript
// Only render Carousel when data is loaded
{!isLoading && (
  <Carousel
    data={carouselData}
    onHoverStart={handleCardHoverStart}
    onHoverEnd={handleCardHoverEnd}
    onViewChange={handleCardViewChange}
  />
)}
```

## Additional Considerations

### Performance
- Ensure the DOM extraction happens after the page content is loaded
- Consider using a loading state while extracting data
- Maintain any existing performance optimizations

### Testing
- Test with different image formats and srcset configurations
- Verify that the carousel still works correctly with the new data source
- Test edge cases like missing images or malformed srcset attributes

### Debugging
- Add console logs to track extraction process
- Log the extracted data structure for verification
- Monitor for any missing or incorrect data

### Error Handling
```javascript
const extractCarouselDataFromDOM = () => {
  try {
    const wrappers = Array.from(document.querySelectorAll('div[data-three="thumbnail"].project-links-item'));
    
    if (wrappers.length === 0) {
      console.warn('[CAROUSEL] No project elements found in DOM');
      return [];
    }
    
    const data = wrappers.slice(0, NUM_CARDS_TO_DISPLAY).map((wrapper, idx) => {
      const img = wrapper.querySelector('img');
      let imageUrl = img ? img.getAttribute('src') : null;
      
      if (!imageUrl && img && img.getAttribute('srcset')) {
        const srcset = img.getAttribute('srcset');
        const match = srcset.match(/([^\s]+)\s+720w/);
        if (match) imageUrl = match[1];
        else imageUrl = srcset.split(',')[0].split(' ')[0];
      }
      
      if (!imageUrl) {
        console.warn(`[CAROUSEL] No image URL found for project ${idx}`);
      }
      
      wrapper.setAttribute('data-carousel-index', idx);
      if (img) img.setAttribute('data-carousel-index', idx);
      
      return { imgEl: img, wrapperEl: wrapper, imageUrl, index: idx };
    });
    
    console.log('[CAROUSEL] Extracted carousel data:', data);
    return data;
  } catch (error) {
    console.error('[CAROUSEL] Error extracting carousel data:', error);
    return [];
  }
};
```

## Benefits of DOM-Based Extraction

1. **Reduced API Dependencies**: No need for backend API calls
2. **Faster Loading**: Data is already available in the DOM
3. **Simplified Architecture**: Fewer moving parts and dependencies
4. **Better Performance**: Eliminates network requests for carousel data
5. **Easier Maintenance**: Data source is directly tied to the rendered content

## Migration Checklist

- [ ] Create DOM extraction function
- [ ] Replace API calls with DOM extraction
- [ ] Add loading states and error handling
- [ ] Test with various image formats and srcset configurations
- [ ] Verify all carousel interactions still work
- [ ] Add debugging logs and error handling
- [ ] Test performance impact
- [ ] Update documentation
- [ ] Remove unused API-related code 