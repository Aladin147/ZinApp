/**
 * Color System for ZinApp
 *
 * This file defines the color palette for ZinApp, including primary, secondary, and accent colors,
 * as well as utility colors for different states and grayscale values.
 *
 * The color system follows our playful, immersive design language with warm, inviting colors
 * and clear visual hierarchy.
 *
 * @see docs/DESIGN_TOKENS.md for the complete color specifications
 */
export const colors = {
  // Brand colors - Playful, immersive design language
  primary: '#F4805D',    // Coral - Primary CTA, buttons, highlights, icons
  secondary: '#FEF1D8',  // Background, card backdrops
  cream: '#FFFAF2',      // Panel sections, forms
  stylistBlue: '#8CBACD', // Cool Blue for stylist-related components only
  warmSand: '#F8F3ED',   // Warm backgrounds, cards
  textSlate: '#3C3C3C',  // Body text, titles, icons

  // Backgrounds
  bgLight: '#FCFBF9',    // Secondary Cream - Light backgrounds
  bgDark: '#3C3C3C',     // Text Slate - Dark backgrounds

  // Text
  textPrimary: '#3C3C3C', // Text/Foreground Slate - Headlines, primary text
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
 *
 * Updated to match our playful, immersive design language.
 */
export const themeColors = {
  // Button states
  buttonPrimary: colors.primary,     // Coral - Primary CTA
  buttonSecondary: colors.secondary, // Background color
  buttonAccent: colors.stylistBlue,  // Cool Blue - Only for stylist-related elements
  buttonDisabled: colors.gray300,    // Disabled state
  buttonPressed: '#E06E4B',          // Darker variant of primary for pressed state

  // Backgrounds
  background: colors.secondary,     // #F8F3ED - Background
  backgroundWarm: colors.warmSand, // #F8F3ED - Warm backgrounds
  cardBg: colors.cream,           // #FCFBF9 - Secondary Cream for cards
  cardBgWarm: colors.warmSand,    // #F8F3ED - Warm backgrounds for cards

  // Text variants
  text: colors.textPrimary,       // #3C3C3C - Text/Foreground Slate
  textSecondary: colors.textMuted, // #7A7A7A - Secondary text
  textLight: colors.bgLight,      // #FCFBF9 - Light text on dark backgrounds
  textOnPrimary: colors.bgLight,  // #FCFBF9 - Text on primary buttons

  // Status
  statusSuccess: colors.success,
  statusError: colors.error,
  statusWarning: colors.warning,
  statusInfo: colors.info,

  // Trust related - Only use Cool Blue for stylist-related elements
  trustHighlight: colors.stylistBlue, // #8CBACD - Cool Blue for stylist-related elements

  // UI Elements
  border: colors.gray200,
  divider: colors.gray100,
  shadow: 'rgba(0, 0, 0, 0.1)',
  shadowDark: 'rgba(0, 0, 0, 0.2)',
  overlay: 'rgba(0, 0, 0, 0.5)',

  // Component specific - Following audit requirements
  cardBackground: colors.cream,       // #FCFBF9 - Secondary Cream for cards
  screenBackground: colors.secondary, // #F8F3ED - Background
  buttonText: colors.bgLight,        // #FCFBF9 - Text on buttons
  stylistAccent: colors.stylistBlue, // #8CBACD - Cool Blue for stylist-related elements only
};

export default colors;
