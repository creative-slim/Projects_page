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

const getApiData = async () => {
  const url =
    "https://webhook.creative-directors.com/webhook/7bd04d17-2d35-49e1-a2aa-10b5c8ee3429";

  // Check cache first
  if (imageCache.has(url)) {
    devLog("Using cached image data");
    return imageCache.get(url);
  }

  const endpointResponse = await fetchImageData(url);
  devLog("Endpoint Response:", endpointResponse);

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

  const images = endpointResponse.slice(0, 9).map((image, index) => ({
    position: oldImages[index].position,
    rotation: oldImages[index].rotation,
    url: image.images[0] || "https://placehold.co/600x400",
    name: image.name,
    slug: image.slug,
  }));

  // Cache the results
  imageCache.set(url, images);

  // Preload images in the background
  images.forEach(image => {
    if (image.url) {
      preloadImage(image.url).catch(error => {
        devWarn(`Failed to preload image: ${image.url}`, error);
      });
    }
  });

  return images;
};

const fetchImageData = async (webhookUrl) => {
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
