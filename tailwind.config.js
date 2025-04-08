/** @type {import('tailwindcss').Config} */
module.exports = {
  // NativeWind v4 uses a different content structure
  content: {
    files: [
      './App.{js,jsx,ts,tsx}',
      './screens/**/*.{js,jsx,ts,tsx}',
      './components/**/*.{js,jsx,ts,tsx}',
      './navigation/**/*.{js,jsx,ts,tsx}' // Added navigation path
    ],
  },
  theme: {
    extend: {
      // Keep custom theme extensions
      fontSize: {
        'xs': 12,
        'sm': 14,
        'base': 16,
        'lg': 18,
        'xl': 20,
        '2xl': 24,
      },
      // Extend theme here if needed, e.g., using values from constants/
      // colors: {
      //   primary: '#FF6A33', // Example from DESIGN_TOKENS.md
      //   accent: '#8CBACD',
      //   'text-main': '#2B2B2B',
      //   'text-muted': '#7A7A7A',
      // },
    },
  },
  plugins: [],
};
