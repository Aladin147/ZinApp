/**
 * Typography System for ZinApp
 *
 * This file defines the typography system for ZinApp, including font sizes, weights,
 * line heights, and font families. It follows the specifications in the design documentation.
 *
 * Font Family: Inter (as a fallback for Uber Move)
 *
 * The typography system is organized into a set of variants that can be used throughout the app.
 * Each variant has a specific font family, size, weight, and line height.
 *
 * @see docs/DESIGN_TOKENS.md for the complete typography specifications
 */

export const typography = {
  // Font sizes (in pixels)
  sizes: {
    screenTitle: 24,
    heading: 20,
    sectionHeader: 18,
    subheading: 16,
    button: 16,
    body: 14,
    caption: 12,
  },

  // Font weights
  weights: {
    regular: '400',
    medium: '500',
    semiBold: '600',
    bold: '700',
  },

  // Line heights (in pixels)
  lineHeights: {
    screenTitle: 32,
    heading: 28,
    sectionHeader: 26,
    subheading: 24,
    body: 20,
    button: 20,
    caption: 16,
  },

  // Letter spacing (in pixels)
  letterSpacing: {
    tight: -0.5,
    normal: 0,
    wide: 0.5,
    extraWide: 1,
  },

  // Font families
  fontFamilies: {
    // Primary font family (Inter as fallback for Uber Move)
    primary: 'Inter',
    primaryMedium: 'Inter-Medium',
    primarySemiBold: 'Inter-SemiBold',
    primaryBold: 'Inter-Bold',
    // Monospace font family for code or tabular data
    mono: 'monospace',
  },

  // Styled text variants
  variants: {
    // Screen titles (24px Bold)
    screenTitle: {
      fontFamily: 'Inter-Bold',
      fontSize: 24,
      lineHeight: 32,
      letterSpacing: -0.5,
    },

    // Headings (20px Bold)
    heading: {
      fontFamily: 'Inter-Bold',
      fontSize: 20,
      lineHeight: 28,
      letterSpacing: -0.5,
    },

    // Section headers (18px Bold)
    sectionHeader: {
      fontFamily: 'Inter-Bold',
      fontSize: 18,
      lineHeight: 26,
      letterSpacing: -0.25,
    },

    // Subheadings (16px Bold)
    subheading: {
      fontFamily: 'Inter-Bold',
      fontSize: 16,
      lineHeight: 24,
      letterSpacing: 0,
    },

    // Body text (14px Regular)
    body: {
      fontFamily: 'Inter',
      fontSize: 14,
      lineHeight: 20,
      letterSpacing: 0,
    },

    // Emphasized body text (14px Medium)
    bodyMedium: {
      fontFamily: 'Inter-Medium',
      fontSize: 14,
      lineHeight: 20,
      letterSpacing: 0,
    },

    // Important body text (14px Bold)
    bodyBold: {
      fontFamily: 'Inter-Bold',
      fontSize: 14,
      lineHeight: 20,
      letterSpacing: 0,
    },

    // Button text (16px Medium)
    button: {
      fontFamily: 'Inter-Medium',
      fontSize: 16,
      lineHeight: 20,
      letterSpacing: 0,
    },

    // Caption text (12px Regular)
    caption: {
      fontFamily: 'Inter',
      fontSize: 12,
      lineHeight: 16,
      letterSpacing: 0,
    },

    // Emphasized caption text (12px Medium)
    captionMedium: {
      fontFamily: 'Inter-Medium',
      fontSize: 12,
      lineHeight: 16,
      letterSpacing: 0,
    },
  },
};

export default typography;
