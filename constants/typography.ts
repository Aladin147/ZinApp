/**
 * Typography System for ZinApp
 *
 * This file defines the typography system for ZinApp, including font sizes, weights,
 * line heights, and font families. It follows the specifications in the audit requirements.
 *
 * Font Family: Inter (as a fallback for Uber Move)
 *
 * The typography system is organized into a set of variants that can be used throughout the app.
 * Each variant has a specific font family, size, weight, and line height.
 *
 * Audit Requirements:
 * - ScreenTitle: 24px, Bold - Screen headers
 * - SectionHeader: 18px, Bold - Card titles, small blocks
 * - BodyText: 14px, Regular - Descriptive text, labels
 * - ButtonText: 16px, Medium - Button labels
 *
 * @see docs/DESIGN_TOKENS.md for the complete typography specifications
 */

export const typography = {
  // Font sizes (in pixels) - Audit requirements
  sizes: {
    screenTitle: 24, // Screen headers
    sectionHeader: 18, // Card titles, small blocks
    body: 14, // Descriptive text, labels
    button: 16, // Button labels
    // Additional sizes for flexibility
    heading: 20,
    subheading: 16,
    caption: 12,
  },

  // Font weights - Audit requirements
  weights: {
    regular: '400', // Regular - Body text
    medium: '500',  // Medium - Button text
    semiBold: '600',
    bold: '700',    // Bold - Screen titles, section headers
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

  // Font families - Audit requirements
  fontFamilies: {
    // Primary font family (Inter as fallback for Uber Move)
    // Audit specifies: "Font: Uber Move (fallback: Inter/Satoshi)"
    primary: 'Inter',         // Regular weight
    primaryMedium: 'Inter-Medium',   // Medium weight
    primarySemiBold: 'Inter-SemiBold', // SemiBold weight
    primaryBold: 'Inter-Bold',    // Bold weight
    // Monospace font family for code or tabular data
    mono: 'monospace',
  },

  // Styled text variants - Audit requirements
  variants: {
    // ScreenTitle: 24px, Bold - Screen headers
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

    // SectionHeader: 18px, Bold - Card titles, small blocks
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

    // BodyText: 14px, Regular - Descriptive text, labels
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

    // ButtonText: 16px, Medium - Button labels
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
