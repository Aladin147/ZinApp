// Barrel file for all constants, allowing easy imports like:
// import { colors, spacing } from '@constants';

export { default as colors, themeColors } from './colors';
export { default as spacing } from './spacing';
export { default as typography } from './typography';
export { default as animations } from './animations';
export { default as flags } from './flags';

// API endpoints for the mock server
// Try multiple potential API URLs to handle port conflicts
export const API_BASE_URLS = [
  'http://localhost:3001',  // Default mock API port
  'http://127.0.0.1:3001',  // Alternative localhost
  'http://10.0.2.2:3001',   // Android emulator to host
  'http://localhost:3000',  // Fallback port
];

// Default API URL (will be tried first)
export const API_BASE_URL = API_BASE_URLS[0];
export const API_ENDPOINTS = {
  STYLISTS: '/stylists',
  SERVICES: '/services',
  BOOKINGS: '/bookings',
  USERS: '/users',
  RATINGS: '/ratings',
};

// Default state for development/testing
export const DEFAULT_USER_ID = 10; // Default to "Yassine" for mock data
