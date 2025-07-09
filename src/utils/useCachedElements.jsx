import { useRef, useCallback, useEffect } from 'react';

/**
 * Hook to cache DOM elements and reduce repeated queries
 * @param {string} selector - CSS selector for the elements
 * @param {Object} options - Configuration options
 */
export const useCachedElements = (selector, options = {}) => {
    const {
        refreshOnResize = true,
        refreshOnVisibilityChange = true
    } = options;

    const elementsRef = useRef(null);
    const selectorRef = useRef(selector);

    const refreshElements = useCallback(() => {
        try {
            elementsRef.current = document.querySelectorAll(selectorRef.current);
        } catch (error) {
            console.warn('Invalid selector:', selectorRef.current, error);
            elementsRef.current = null;
        }
    }, []);

    // Initial cache and refresh on selector change
    useEffect(() => {
        selectorRef.current = selector;
        refreshElements();
    }, [selector, refreshElements]);

    // Refresh on window resize
    useEffect(() => {
        if (!refreshOnResize) return;

        const handleResize = () => {
            // Debounce resize events
            clearTimeout(window.resizeTimeout);
            window.resizeTimeout = setTimeout(refreshElements, 100);
        };

        window.addEventListener('resize', handleResize);
        return () => {
            window.removeEventListener('resize', handleResize);
            clearTimeout(window.resizeTimeout);
        };
    }, [refreshOnResize, refreshElements]);

    // Refresh on visibility change
    useEffect(() => {
        if (!refreshOnVisibilityChange) return;

        const handleVisibilityChange = () => {
            if (!document.hidden) {
                refreshElements();
            }
        };

        document.addEventListener('visibilitychange', handleVisibilityChange);
        return () => {
            document.removeEventListener('visibilitychange', handleVisibilityChange);
        };
    }, [refreshOnVisibilityChange, refreshElements]);

    const clearActiveClasses = useCallback(() => {
        if (elementsRef.current) {
            elementsRef.current.forEach(el => el.classList.remove("active"));
        }
    }, []);

    const addActiveClass = useCallback((index) => {
        if (elementsRef.current && elementsRef.current[index]) {
            elementsRef.current[index].classList.add("active");
        }
    }, []);

    const findElementBySlug = useCallback((slug) => {
        if (!elementsRef.current) return null;

        for (let i = 0; i < elementsRef.current.length; i++) {
            const element = elementsRef.current[i];
            const link = element.querySelector(`a[href$='/${slug}']`);
            if (link) {
                return { element, index: i };
            }
        }
        return null;
    }, []);

    const setActiveBySlug = useCallback((slug) => {
        const result = findElementBySlug(slug);
        if (result) {
            clearActiveClasses();
            result.element.classList.add("active");
            return result.index;
        }
        return -1;
    }, [clearActiveClasses, findElementBySlug]);

    return {
        elements: elementsRef.current,
        clearActiveClasses,
        addActiveClass,
        findElementBySlug,
        setActiveBySlug,
        refreshElements
    };
}; 