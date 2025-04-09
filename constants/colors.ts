/**
 * Color constants from DESIGN_TOKENS.md and zinapp_visual_guidelines.md
 *
 * Based on the specifications in the design documentation:
 * - Primary color: Coral Orange (#F4805D)
 * - Warm Sand (#F8F3ED)
 * - Cool Blue Slate (#8CBACD)
 * - Dark Slate (#3C3C3C)
 */
export const colors = {
  // Primary colors
  primary: '#F4805D', // Coral Orange - CTA buttons, icons
  accent: '#8CBACD',  // Cool Blue Slate - QR trust theme
  warmSand: '#F8F3ED', // Warm Sand - Background
  darkSlate: '#3C3C3C', // Dark Slate - Text

  // Backgrounds
  bgLight: '#FFFFFF', // Backgrounds (light)
  bgDark: '#1C1C1E',  // Backgrounds (dark)
  bgWarm: '#F8F3ED', // Warm Sand background

  // Text
  textMain: '#3C3C3C',  // Headlines (Dark Slate)
  textMuted: '#7A7A7A', // Secondary text

  // Utility colors
  success: '#34D399',
  error: '#EF4444',
  warning: '#F59E0B',
  info: '#3B82F6',

  // Grayscale
  gray50: '#F9FAFB',
  gray100: '#F3F4F6',
  gray200: '#E5E7EB',
  gray300: '#D1D5DB',
  gray400: '#9CA3AF',
  gray500: '#6B7280',
  gray600: '#4B5563',
  gray700: '#374151',
  gray800: '#1F2937',
  gray900: '#111827',
};

// Named aliases for common use cases
export const themeColors = {
  // Button states
  buttonPrimary: colors.primary,
  buttonSecondary: colors.accent,
  buttonDisabled: colors.gray300,
  buttonPressed: '#E06A4A', // Darker variant of primary

  // Backgrounds
  background: colors.bgLight,
  backgroundWarm: colors.warmSand,
  cardBg: colors.bgLight,

  // Text variants
  text: colors.textMain,
  textSecondary: colors.textMuted,
  textLight: colors.bgLight,

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
};

export default colors;
