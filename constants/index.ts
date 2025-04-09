// Barrel file for all constants, allowing easy imports like:
// import { colors, spacing } from '@constants';

export { default as colors, themeColors } from './colors';
export { default as spacing } from './spacing';
export { default as typography } from './typography';
export { default as animations } from './animations';
export { default as flags } from './flags';

// API endpoints for the mock server
export const API_BASE_URL = 'http://192.168.100.24:3001'; // Use local network IP
export const API_ENDPOINTS = {
  STYLISTS: '/stylists',
  SERVICES: '/services',
  BOOKINGS: '/bookings',
  USERS: '/users',
  RATINGS: '/ratings',
};

// Default state for development/testing
export const DEFAULT_USER_ID = 10; // Default to "Yassine" for mock data
