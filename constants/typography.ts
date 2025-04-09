// Typography constants from DESIGN_TOKENS.md and zinapp_visual_guidelines.md

/**
 * Typography system for ZinApp
 * Based on the specifications in the design documentation:
 * - Font Family: Uber Move (fallback: Inter / Satoshi)
 * - Screen Title: 24px, Bold, 32px line height
 * - Section Header: 18px, Bold, 26px line height
 * - Paragraph / Body: 14px, Regular, 20px line height
 * - Button Text: 16px, Medium, 20px line height
 */
export const typography = {
  // Font sizes
  sizes: {
    screenTitle: 24,
    sectionHeader: 18,
    body: 14,
    button: 16,
    caption: 12,
  },

  // Font weights
  weights: {
    regular: '400',
    medium: '500',
    semiBold: '600',
    bold: '700',
  },

  // Line heights
  lineHeights: {
    screenTitle: 32,
    sectionHeader: 26,
    body: 20,
    button: 20,
    caption: 16,
  },

  // Font families
  fontFamilies: {
    // Primary font family (Uber Move with fallbacks)
    primary: 'Inter',
    primaryMedium: 'Inter-Medium',
    primarySemiBold: 'Inter-SemiBold',
    primaryBold: 'Inter-Bold',
  },

  // Styled text variants
  variants: {
    screenTitle: {
      fontFamily: 'Inter-Bold',
      fontSize: 24,
      lineHeight: 32,
    },
    sectionHeader: {
      fontFamily: 'Inter-Bold',
      fontSize: 18,
      lineHeight: 26,
    },
    body: {
      fontFamily: 'Inter',
      fontSize: 14,
      lineHeight: 20,
    },
    bodyMedium: {
      fontFamily: 'Inter-Medium',
      fontSize: 14,
      lineHeight: 20,
    },
    button: {
      fontFamily: 'Inter-Medium',
      fontSize: 16,
      lineHeight: 20,
    },
    caption: {
      fontFamily: 'Inter',
      fontSize: 12,
      lineHeight: 16,
    },
    captionMedium: {
      fontFamily: 'Inter-Medium',
      fontSize: 12,
      lineHeight: 16,
    },
  },
};

export default typography;
