import { devLog, devWarn, devError } from './utils/devLog';

// Cache for storing image data
const imageCache = new Map();

// Preload an image
const preloadImage = (url) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = reject;
    img.src = url;
  });
};

// DOM extraction function following the carousel pattern
const extractProjectDataFromDOM = () => {
  try {
    devLog("Extracting project data from DOM");
    devLog("Document ready state:", document.readyState);

    // Find all project elements with data-three="thumbnail" and class project-links-item
    const projectElements = Array.from(document.querySelectorAll('div[data-three="thumbnail"].project-links-item'));

    if (projectElements.length === 0) {
      devWarn("No project elements found in DOM");
      devLog("Available elements with data-three attribute:",
        Array.from(document.querySelectorAll('[data-three]'))
          .map(el => ({ tag: el.tagName, attrs: Array.from(el.attributes).map(attr => `${attr.name}="${attr.value}"`).join(', '), classes: el.className }))
      );
      return [];
    }

    devLog(`Found ${projectElements.length} project elements in DOM`);
    devLog("Project elements:", projectElements.map(el => ({
      hasImage: !!el.querySelector('img'),
      hasHeading: !!el.querySelector('.project-heading'),
      hasLink: !!el.querySelector('a')
    })));

    // Limit to first 9 projects (matching the original API limit)
    const limitedElements = projectElements.slice(0, 9);

    const data = limitedElements.map((element, idx) => {
      // Extract slug from <a href>
      const linkEl = element.querySelector('a[href]');
      let slug = '';
      if (linkEl) {
        const href = linkEl.getAttribute('href');
        if (href) {
          const parts = href.split('/');
          slug = parts[parts.length - 1] || parts[parts.length - 2] || '';
        }
      }
      devLog(`Element ${idx} extracted slug:`, slug);

      // Extract name from heading
      const headingEl = element.querySelector('.project-heading');
      const name = headingEl ? headingEl.textContent : slug;

      // Extract image URL from img tag
      const imgEl = element.querySelector('img');
      let imageUrl = '';
      if (imgEl) {
        devLog(`Element ${idx} has image:`, imgEl.getAttribute('src'));
        // Try to get the best quality image from srcset
        const srcset = imgEl.getAttribute('srcset');
        if (srcset) {
          devLog(`Element ${idx} has srcset:`, srcset);
          // Look for 720w or 800w image first, then fallback to first available
          const match = srcset.match(/([^\s]+)\s+(720w|800w)/);
          if (match) {
            imageUrl = match[1];
            devLog(`Element ${idx} using srcset match:`, imageUrl);
          } else {
            // Fallback to first image in srcset
            imageUrl = srcset.split(',')[0].split(' ')[0];
            devLog(`Element ${idx} using first srcset:`, imageUrl);
          }
        } else {
          // Fallback to src attribute
          imageUrl = imgEl.getAttribute('src') || '';
          devLog(`Element ${idx} using src:`, imageUrl);
        }
      } else {
        devWarn(`Element ${idx} has no image element`);
      }

      if (!slug) {
        devWarn(`Project element ${idx} has no identifiable slug`);
        return null;
      }
      if (!imageUrl) {
        devWarn(`Project element ${idx} (${slug}) has no image URL`);
        return null;
      }

      // Assign data-carousel-index for easier matching (following carousel pattern)
      element.setAttribute('data-carousel-index', idx);

      devLog(`Extracted project ${idx}: ${name} (${slug}) -> ${imageUrl}`);

      return {
        slug,
        name,
        images: [imageUrl], // Match the API structure
        index: idx
      };
    }).filter(Boolean); // Remove any null entries

    devLog("Extracted project data:", data);
    return data;

  } catch (error) {
    devError("Error extracting project data from DOM:", error);
    return [];
  }
};

const getApiData = async () => {
  // Check cache first
  const cacheKey = 'dom-extracted-data';
  if (imageCache.has(cacheKey)) {
    devLog("Using cached DOM-extracted data");
    return imageCache.get(cacheKey);
  }

  // Extract data from DOM instead of API
  const projectData = extractProjectDataFromDOM();

  if (projectData.length === 0) {
    devWarn("No project data extracted from DOM, returning empty array");
    return [];
  }

  devLog(`Successfully extracted ${projectData.length} projects from DOM`);

  const oldImages = [
    // Front
    {
      position: [0, 0, 1.5],
      rotation: [0, 0, 0],
    },
    // Back
    {
      position: [-0.8, 0, -0.6],
      rotation: [0, 0, 0],
    },
    {
      position: [0.8, 0, -0.6],
      rotation: [0, 0, 0],
    },
    // Left
    {
      position: [-1.75, 0, 0.25],
      rotation: [0, Math.PI / 2.5, 0],
    },
    {
      position: [-2.15, 0, 1.5],
      rotation: [0, Math.PI / 2.5, 0],
    },
    {
      position: [-2, 0, 2.75],
      rotation: [0, Math.PI / 2.5, 0],
    },
    // Right
    {
      position: [1.75, 0, 0.25],
      rotation: [0, -Math.PI / 2.5, 0],
    },
    {
      position: [2.15, 0, 1.5],
      rotation: [0, -Math.PI / 2.5, 0],
    },
    {
      position: [2, 0, 2.75],
      rotation: [0, -Math.PI / 2.5, 0],
    },
  ];

  const images = projectData.map((project, index) => ({
    position: oldImages[index].position,
    rotation: oldImages[index].rotation,
    url: project.images[0] || "https://placehold.co/600x400",
    name: project.name,
    slug: project.slug,
  }));

  // Cache the results
  imageCache.set(cacheKey, images);

  // Preload images in the background
  images.forEach(image => {
    if (image.url) {
      preloadImage(image.url).catch(error => {
        devWarn(`Failed to preload image: ${image.url}`, error);
      });
    }
  });

  devLog("Processed DOM data into images array:", images);
  return images;
};

// Keep the old fetchImageData function for reference but mark as deprecated
const fetchImageData = async (webhookUrl) => {
  devWarn("fetchImageData is deprecated - using DOM extraction instead");
  try {
    const response = await fetch(webhookUrl);

    if (!response.ok) {
      throw new Error(
        `Failed to fetch image data: ${response.status} ${response.statusText}`
      );
    }

    const data = await response.json();
    return data;
  } catch (error) {
    devError("Error fetching image data:", error);
    // Return empty array as fallback
    return [];
  }
};

export default getApiData;
