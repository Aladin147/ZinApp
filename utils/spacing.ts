import { spacing } from '@constants';

/**
 * Spacing utility function for consistent application of spacing
 * 
 * @param size - The size of the spacing to apply (xxs, xs, sm, md, lg, xl, xxl)
 * @param multiplier - Optional multiplier to apply to the spacing
 * @returns The calculated spacing value
 * 
 * @example
 * // Returns 16 (md spacing)
 * getSpacing('md')
 * 
 * @example
 * // Returns 32 (md spacing * 2)
 * getSpacing('md', 2)
 */
export const getSpacing = (
  size: keyof typeof spacing | number,
  multiplier = 1
): number => {
  // If size is a number, use it directly with the multiplier
  if (typeof size === 'number') {
    return size * multiplier;
  }
  
  // Otherwise, look up the size in the spacing object
  return spacing[size] * multiplier;
};

/**
 * Creates a spacing object with all directions (top, right, bottom, left)
 * 
 * @param value - The spacing value to apply to all directions
 * @returns An object with top, right, bottom, and left properties
 * 
 * @example
 * // Returns { top: 16, right: 16, bottom: 16, left: 16 }
 * getSpacingObject(16)
 */
export const getSpacingObject = (value: number) => ({
  top: value,
  right: value,
  bottom: value,
  left: value,
});

/**
 * Creates a spacing object with horizontal and vertical values
 * 
 * @param horizontal - The horizontal spacing value
 * @param vertical - The vertical spacing value
 * @returns An object with top, right, bottom, and left properties
 * 
 * @example
 * // Returns { top: 8, right: 16, bottom: 8, left: 16 }
 * getSpacingObjectHV(16, 8)
 */
export const getSpacingObjectHV = (horizontal: number, vertical: number) => ({
  top: vertical,
  right: horizontal,
  bottom: vertical,
  left: horizontal,
});

/**
 * Creates a spacing object with individual values for each direction
 * 
 * @param top - The top spacing value
 * @param right - The right spacing value
 * @param bottom - The bottom spacing value
 * @param left - The left spacing value
 * @returns An object with top, right, bottom, and left properties
 * 
 * @example
 * // Returns { top: 8, right: 16, bottom: 24, left: 16 }
 * getSpacingObjectTRBL(8, 16, 24, 16)
 */
export const getSpacingObjectTRBL = (
  top: number,
  right: number,
  bottom: number,
  left: number
) => ({
  top,
  right,
  bottom,
  left,
});

export default {
  getSpacing,
  getSpacingObject,
  getSpacingObjectHV,
  getSpacingObjectTRBL,
};
