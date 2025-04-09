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
  // Brand colors
  primary: '#FF6A33',    // Coral Orange - CTA buttons, icons
  secondary: '#F8F0E3',  // Secondary buttons, cards
  accent: '#8CBACD',     // Cool Blue Slate - Stylist-related elements
  warmSand: '#F5E8D3',   // Warm backgrounds, cards
  darkSlate: '#2B2B2B',  // Dark backgrounds, headers

  // Backgrounds
  bgLight: '#FFFFFF',    // Backgrounds (light)
  bgDark: '#1C1C1E',     // Backgrounds (dark)

  // Text
  textPrimary: '#2B2B2B', // Headlines, primary text
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
  buttonAccent: colors.accent,
  buttonDisabled: colors.gray300,
  buttonPressed: '#E05A23', // Darker variant of primary

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
  trustHighlight: colors.accent,

  // UI Elements
  border: colors.gray200,
  divider: colors.gray100,
  shadow: 'rgba(0, 0, 0, 0.1)',
  shadowDark: 'rgba(0, 0, 0, 0.2)',
  overlay: 'rgba(0, 0, 0, 0.5)',
};

export default colors;
