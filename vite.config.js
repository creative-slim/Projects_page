import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  define: {
    'process.env': {},
    'process': {},
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks: undefined, // disables code splitting
        entryFileNames: 'projects-page.[hash].js', // cache-busting hash
        chunkFileNames: 'projects-page.[hash].js',
        assetFileNames: 'projects-page.[hash].[ext]'
      }
    },
    cssCodeSplit: false, // inlines CSS into JS
    minify: 'terser',
    sourcemap: false, // set to true if you want debugging
    target: 'es2015',
    lib: {
      entry: 'src/main.jsx', // your entry point
      name: 'MyWidget',      // global variable name (change as needed)
      fileName: 'projects-page',
      formats: ['iife']      // <--- THIS IS THE KEY
    }
  }
})
