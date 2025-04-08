// Color constants from DESIGN_TOKENS.md
export const colors = {
  // Primary colors
  primary: '#FF6A33', // CTA buttons, icons
  accent: '#8CBACD',  // QR trust theme

  // Backgrounds
  bgLight: '#FFFFFF', // Backgrounds (light)
  bgDark: '#1C1C1E',  // Backgrounds (dark)
  
  // Text
  textMain: '#2B2B2B',  // Headlines
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
  buttonDisabled: colors.gray300,
  buttonPressed: '#E55929', // Darker variant of primary

  // Backgrounds
  background: colors.bgLight,
  cardBg: colors.gray50,
  
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
};

export default colors;
