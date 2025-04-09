/**
 * Color System for ZinApp
 *
 * This file defines the color palette for ZinApp, including primary, secondary, and accent colors,
 * as well as utility colors for different states and grayscale values.
 *
 * The color system is based on the specifications in the design documentation (DESIGN_TOKENS.md).
 *
 * @see docs/DESIGN_TOKENS.md for the complete color specifications
 */
export const colors = {
  // Brand colors - More vibrant and playful like Glovo
  primary: '#FF5E5B',    // Vibrant coral red - Primary CTA, buttons, highlights, icons
  secondary: '#F8F3ED',  // Background, card backdrops
  cream: '#FCFBF9',      // Panel sections, forms
  stylistBlue: '#00C1B2', // Teal blue for stylist elements - more vibrant like Glovo
  warmSand: '#F8F3ED',   // Warm backgrounds, cards
  textSlate: '#3C3C3C',  // Body text, titles, icons
  accent1: '#FFBD00',    // Glovo-like yellow accent
  accent2: '#7B68EE',    // Playful purple accent

  // Backgrounds
  bgLight: '#FCFBF9',    // Light backgrounds
  bgDark: '#1C1C1E',     // Dark backgrounds

  // Text
  textPrimary: '#3C3C3C', // Headlines, primary text
  textMuted: '#7A7A7A',   // Secondary text, captions

  // Status/Utility colors
  success: '#4CAF50',    // Success states, completed
  error: '#F44336',      // Error states, destructive
  warning: '#FFC107',    // Warning states, alerts
  info: '#2196F3',       // Information, notifications

  // Grayscale
  gray100: '#F5F5F5',    // Lightest gray
  gray200: '#EEEEEE',    // Light gray
  gray300: '#E0E0E0',    // Medium light gray
  gray400: '#BDBDBD',    // Medium gray
  gray500: '#9E9E9E',    // Medium dark gray
  gray600: '#757575',    // Dark gray
  gray700: '#616161',    // Darker gray
  gray800: '#424242',    // Very dark gray
  gray900: '#212121',    // Almost black
};

/**
 * Theme Colors for ZinApp
 *
 * These are named aliases for common use cases throughout the app.
 * Using these semantic color names makes it easier to maintain consistency
 * and update the theme in the future.
 */
export const themeColors = {
  // Button states
  buttonPrimary: colors.primary,
  buttonSecondary: colors.secondary,
  buttonAccent: colors.stylistBlue,
  buttonDisabled: colors.gray300,
  buttonPressed: '#E06E4B', // Darker variant of primary

  // Backgrounds
  background: colors.bgLight,
  backgroundWarm: colors.warmSand,
  cardBg: colors.bgLight,
  cardBgWarm: colors.warmSand,

  // Text variants
  text: colors.textPrimary,
  textSecondary: colors.textMuted,
  textLight: colors.bgLight,
  textOnPrimary: colors.bgLight,

  // Status
  statusSuccess: colors.success,
  statusError: colors.error,
  statusWarning: colors.warning,
  statusInfo: colors.info,

  // Trust related
  trustHighlight: colors.stylistBlue,

  // UI Elements
  border: colors.gray200,
  divider: colors.gray100,
  shadow: 'rgba(0, 0, 0, 0.1)',
  shadowDark: 'rgba(0, 0, 0, 0.2)',
  overlay: 'rgba(0, 0, 0, 0.5)',

  // Component specific
  cardBackground: colors.cream,
  screenBackground: colors.secondary,
  buttonText: colors.bgLight,
  stylistAccent: colors.stylistBlue,
};

export default colors;
