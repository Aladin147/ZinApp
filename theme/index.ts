/**
 * Theme index file
 * Exports all theme-related utilities
 */

import { colors, themeColors } from '@constants/colors';
import { spacing } from '@constants/spacing';
import { typography } from '@constants/typography';
import tw from 'twrnc';

// Create a utility function to combine tailwind styles with theme colors
export const themed = (style: string, additionalStyles = {}) => {
  return [tw`${style}`, additionalStyles];
};

// Common style combinations
export const styles = {
  // Layout
  screen: tw`flex-1 bg-white p-4`,
  container: tw`w-full px-4`,
  
  // Typography
  heading: [tw`text-2xl font-bold`, { color: colors.textMain }],
  subheading: [tw`text-xl font-semibold`, { color: colors.textMain }],
  body: [tw`text-base`, { color: colors.textMain }],
  caption: [tw`text-sm`, { color: colors.textMuted }],
  
  // Buttons
  buttonPrimary: [
    tw`bg-[#FF6A33] py-3 px-6 rounded-xl items-center justify-center`,
    { shadowColor: colors.primary, shadowOpacity: 0.2, shadowRadius: 4, elevation: 2 }
  ],
  buttonText: tw`text-white font-medium text-base`,
  
  // Cards
  card: [
    tw`bg-white rounded-2xl p-4 mb-4`,
    { shadowColor: '#000', shadowOpacity: 0.1, shadowRadius: 4, elevation: 2 }
  ],
  
  // Lists
  listItem: tw`flex-row items-center py-3 border-b border-gray-100`,
};

export { colors, themeColors, spacing, typography };

export default {
  colors,
  themeColors,
  spacing,
  typography,
  styles,
};
