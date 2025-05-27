function isDevMode() {
  return import.meta.env.DEV || localStorage.getItem('devmode');
}

export function devLog(...args) {
  if (isDevMode()) {
    // eslint-disable-next-line no-console
    console.log(...args);
  }
}

export function devWarn(...args) {
  if (isDevMode()) {
    // eslint-disable-next-line no-console
    console.warn(...args);
  }
}

export function devError(...args) {
  if (isDevMode()) {
    // eslint-disable-next-line no-console
    console.error(...args);
  }
} 