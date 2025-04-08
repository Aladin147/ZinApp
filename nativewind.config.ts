
// nativewind.config.ts (or tailwind.config.js if using JS)

import { type Config } from "tailwindcss";

const config: Config = {
  content: ["./App.{js,ts,jsx,tsx}", "./screens/**/*.{js,ts,jsx,tsx}", "./components/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#FF6A33", // CTA buttons
        accent: "#8CBACD",  // QR visual accents
        "bg-light": "#FFFFFF",
        "bg-dark": "#1C1C1E",
        "text-main": "#2B2B2B",
        "text-muted": "#7A7A7A"
      },
      spacing: {
        "xs": "4px",
        "sm": "8px",
        "md": "16px",
        "lg": "24px"
      },
      fontSize: {
        headline: ["24px", { lineHeight: "32px", fontWeight: "700" }],
        body: ["16px", { lineHeight: "24px" }],
        caption: ["12px", { lineHeight: "16px", fontWeight: "500" }]
      },
      transitionTimingFunction: {
        'ease-fast': 'cubic-bezier(0.4, 0, 1, 1)',
        'ease-mid': 'cubic-bezier(0.4, 0, 0.2, 1)',
        'ease-slow': 'cubic-bezier(0.2, 0.6, 0.4, 1)',
      },
      transitionDuration: {
        fast: '200ms',
        mid: '400ms',
        slow: '600ms',
      },
      boxShadow: {
        card: '0 2px 8px rgba(0, 0, 0, 0.08)',
        pressed: '0 1px 3px rgba(0, 0, 0, 0.12)',
        modal: '0 8px 32px rgba(0, 0, 0, 0.2)'
      },
      borderRadius: {
        soft: "12px",
        full: "9999px"
      },
      scale: {
        '95': '0.95'
      }
    },
  },
  plugins: [],
};

export default config;
