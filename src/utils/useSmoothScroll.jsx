import { useRef, useEffect } from "react";
import { gsap } from "gsap";

export default function useSmoothScroll({
  easeSpeed = 0.07,
  scrollSpeed = 1.0,
} = {}) {
  const wrapperRef = useRef(null);
  const containerRef = useRef(null);

  useEffect(() => {
    const wrapper = wrapperRef.current;
    const container = containerRef.current;

    // Ensure the elements exist before proceeding
    if (!wrapper || !container) {
      console.error(
        "useSmoothScroll: wrapperRef or containerRef is not attached to a valid DOM element."
      );
      return;
    }

    let targetScrollY = 0;
    let currentScrollY = 0;
    let maxScroll = 0;

    /**
     * updateMaxScroll
     *
     * Calculates the maximum scrollable distance based on
     * container height minus the viewport height.
     */
    function updateMaxScroll() {
      maxScroll = Math.max(0, container.offsetHeight - window.innerHeight);
    }

    /**
     * onWheel
     *
     * Handles the wheel event to update the target scroll position.
     * Prevents native scrolling behavior.
     */
    function onWheel(e) {
      e.preventDefault(); // Prevent the default scroll action
      targetScrollY += e.deltaY * scrollSpeed;
      // Clamp the target scroll position
      targetScrollY = Math.max(0, Math.min(targetScrollY, maxScroll));
    }

    /**
     * smoothScroll
     *
     * Animation loop that smoothly interpolates the current scroll position
     * toward the target position. Uses GSAP to update the container's y position.
     */
    function smoothScroll() {
      currentScrollY += (targetScrollY - currentScrollY) * easeSpeed;
      gsap.set(container, { y: -currentScrollY });
      requestAnimationFrame(smoothScroll);
    }

    /**
     * init
     *
     * Sets up the wheel listener and starts the animation loop.
     */
    function init() {
      // Listen for wheel events on the wrapper element
      wrapper.addEventListener("wheel", onWheel, { passive: false });
      // Update max scroll on resize
      window.addEventListener("resize", updateMaxScroll);
      // Calculate initial max scroll
      updateMaxScroll();
      // Start the smooth scrolling
      smoothScroll();
    }

    // Initialize
    init();

    // Cleanup on unmount
    return () => {
      wrapper.removeEventListener("wheel", onWheel, { passive: false });
      window.removeEventListener("resize", updateMaxScroll);
    };
  }, [easeSpeed, scrollSpeed]);

  return { wrapperRef, containerRef };
}
