/**
 * Spacing constants from DESIGN_TOKENS.md and zinapp_visual_guidelines.md
 *
 * Based on the specifications in the design documentation:
 * - 4pt spacing grid
 * - 16px margin baseline
 * - 8px inner padding, 16px outer margin for cards
 */

// Base unit for the 4pt grid system
const BASE_UNIT = 4;

export const spacing = {
  // Core spacing scale based on 4pt grid
  xxs: BASE_UNIT,     // 4px
  xs: BASE_UNIT * 2,  // 8px
  sm: BASE_UNIT * 3,  // 12px
  md: BASE_UNIT * 4,  // 16px - baseline margin
  lg: BASE_UNIT * 6,  // 24px
  xl: BASE_UNIT * 8,  // 32px
  xxl: BASE_UNIT * 12, // 48px

  // Named spacing
  tight: BASE_UNIT,      // 4px - Minimal spacing
  default: BASE_UNIT * 2, // 8px - General spacing
  loose: BASE_UNIT * 4,   // 16px - Generous spacing
  screenMargin: BASE_UNIT * 4, // 16px - Screen edge margin

  // Specific use cases from design specs
  cardInnerPadding: BASE_UNIT * 2, // 8px inner padding
  cardOuterMargin: BASE_UNIT * 4,  // 16px outer margin
  cardPadding: BASE_UNIT * 4,      // 16px
  cardGap: BASE_UNIT * 3,          // 12px
  inlineGap: BASE_UNIT * 2,        // 8px
  sectionGap: BASE_UNIT * 6,       // 24px
  headerPadding: BASE_UNIT * 6,    // 24px header padding
  inputPadding: BASE_UNIT * 3,     // 12px
  buttonPadding: BASE_UNIT * 4,    // 16px

  // Icon sizes
  iconSize: {
    small: BASE_UNIT * 4,  // 16px
    medium: BASE_UNIT * 6, // 24px
    large: BASE_UNIT * 8,  // 32px
  },

  // Helper function to get multiples of the base unit
  get: (multiple: number) => BASE_UNIT * multiple,
};

export default spacing;
