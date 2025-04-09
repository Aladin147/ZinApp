/**
 * Spacing System for ZinApp
 *
 * This file defines the spacing system for ZinApp, based on a 4pt grid system.
 * All spacing values are multiples of the base unit (4pt) to ensure consistency
 * throughout the app, as specified in the audit requirements.
 *
 * The spacing system includes:
 * - Core spacing scale (xxs to xxl)
 * - Named spacing for common use cases
 * - Component-specific spacing
 * - Helper function to get custom multiples of the base unit
 *
 * Audit Requirements:
 * - 4pt spacing grid system
 * - Cards: 16px outer margin, 12px inner padding
 * - Buttons: 20px border radius
 * - Sections: 24px bottom corners
 *
 * @see docs/DESIGN_TOKENS.md for the complete spacing specifications
 */

// Base unit for the 4pt grid system
const BASE_UNIT = 4;

export const spacing = {
  // Core spacing scale based on 4pt grid
  xxs: BASE_UNIT,      // 4px - Minimal spacing
  xs: BASE_UNIT * 2,   // 8px - Tight spacing
  sm: BASE_UNIT * 3,   // 12px - Small spacing
  md: BASE_UNIT * 4,   // 16px - Medium spacing (baseline)
  lg: BASE_UNIT * 6,   // 24px - Large spacing
  xl: BASE_UNIT * 8,   // 32px - Extra large spacing
  xxl: BASE_UNIT * 12, // 48px - Double extra large spacing
  xxxl: BASE_UNIT * 16, // 64px - Triple extra large spacing

  // Named spacing for semantic use
  tight: BASE_UNIT,       // 4px - Minimal spacing between related elements
  default: BASE_UNIT * 2, // 8px - Default spacing between elements
  loose: BASE_UNIT * 4,   // 16px - Generous spacing between sections
  screenMargin: BASE_UNIT * 4, // 16px - Standard margin from screen edge

  // Layout spacing
  gutter: BASE_UNIT * 4,  // 16px - Standard gutter between columns
  sectionGap: BASE_UNIT * 6, // 24px - Gap between major sections
  verticalGap: BASE_UNIT * 4, // 16px - Vertical gap between components
  horizontalGap: BASE_UNIT * 3, // 12px - Horizontal gap between components
  inlineGap: BASE_UNIT * 2, // 8px - Gap between inline elements
  stackGap: BASE_UNIT * 3, // 12px - Gap between stacked elements

  // Component-specific spacing - Audit requirements
  card: {
    padding: BASE_UNIT * 3,     // 12px - Inner padding (audit requirement)
    innerPadding: BASE_UNIT * 3, // 12px - Inner padding for nested elements (audit requirement)
    outerMargin: BASE_UNIT * 4,  // 16px - Margin around cards (audit requirement)
    gap: BASE_UNIT * 3,          // 12px - Gap between card elements
    borderRadius: BASE_UNIT * 4,  // 16px - Card border radius (audit requirement)
  },

  button: {
    paddingVertical: BASE_UNIT * 3,   // 12px - Vertical padding for buttons
    paddingHorizontal: BASE_UNIT * 4, // 16px - Horizontal padding for buttons
    gap: BASE_UNIT * 2,               // 8px - Gap between button icon and text
    borderRadius: BASE_UNIT * 5,      // 20px - Button border radius (audit requirement)
    height: BASE_UNIT * 12,           // 48px-56px height (audit requirement)
  },

  input: {
    padding: BASE_UNIT * 3,      // 12px - Input field padding
    borderRadius: BASE_UNIT * 2,  // 8px - Input field border radius
    gap: BASE_UNIT * 2,           // 8px - Gap between label and input
  },

  header: {
    padding: BASE_UNIT * 4,      // 16px - Header padding
    height: BASE_UNIT * 14,       // 56px - Standard header height
  },

  // Section-specific spacing - Audit requirements
  section: {
    bottomCornerRadius: BASE_UNIT * 6, // 24px - Section bottom corners (audit requirement)
    padding: BASE_UNIT * 4,           // 16px - Section padding
    marginBottom: BASE_UNIT * 6,      // 24px - Section bottom margin
  },

  // Icon sizes
  iconSize: {
    xs: BASE_UNIT * 3,    // 12px - Extra small icons
    small: BASE_UNIT * 4,  // 16px - Small icons
    medium: BASE_UNIT * 6, // 24px - Medium icons
    large: BASE_UNIT * 8,  // 32px - Large icons
    xl: BASE_UNIT * 10,    // 40px - Extra large icons
  },

  // Helper function to get multiples of the base unit
  get: (multiple: number) => BASE_UNIT * multiple,
};

export default spacing;
