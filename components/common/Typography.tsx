import React from 'react';
import { Text, TextProps, TextStyle } from 'react-native';
import { colors, typography } from '@constants';

/**
 * Typography component variants based on the ZinApp design system
 */
type TypographyVariant =
  | 'screenTitle'   // 24px Bold - Main screen titles
  | 'heading'       // 20px Bold - Large headings
  | 'sectionHeader' // 18px Bold - Section headers
  | 'subheading'    // 16px Bold - Subheadings
  | 'body'          // 14px Regular - Standard text
  | 'bodyMedium'    // 14px Medium - Emphasized body text
  | 'bodyBold'      // 14px Bold - Important body text
  | 'button'        // 16px Medium - Button text
  | 'caption'       // 12px Regular - Labels, taglines
  | 'captionMedium'; // 12px Medium - Emphasized small text

/**
 * Props for the Typography component
 */
interface TypographyProps extends TextProps {
  /**
   * Typography variant based on the design system
   * @default 'body'
   */
  variant?: TypographyVariant;

  /**
   * Text color
   * @default colors.textPrimary for most variants, colors.textMuted for captions
   */
  color?: string;

  /**
   * Text alignment
   * @default 'left'
   */
  align?: 'left' | 'center' | 'right';

  /**
   * Additional styles to apply to the text
   */
  style?: TextStyle;

  /**
   * Text content
   */
  children: React.ReactNode;
}

/**
 * Typography component following ZinApp design system
 *
 * This component provides consistent text styling throughout the app based on the
 * typography system defined in the design documentation. It supports various text
 * variants like screenTitle, heading, body, etc., each with specific font properties.
 *
 * @example
 * // Basic usage
 * <Typography>Default body text</Typography>
 *
 * @example
 * // Using a specific variant
 * <Typography variant="screenTitle">Screen Title</Typography>
 *
 * @example
 * // With custom color and alignment
 * <Typography variant="caption" color={colors.primary} align="center">
 *   Centered caption with custom color
 * </Typography>
 */
const Typography: React.FC<TypographyProps> = ({
  variant = 'body',
  color,
  align = 'left',
  style,
  children,
  ...props
}) => {
  // Get the variant style from our typography system
  const variantStyle = typography.variants[variant] || typography.variants.body;

  // Create the base style with the variant properties
  const baseStyle = {
    fontFamily: variantStyle.fontFamily,
    fontSize: variantStyle.fontSize,
    lineHeight: variantStyle.lineHeight,
    letterSpacing: variantStyle.letterSpacing,
    color: color || colors.textPrimary,
  };

  // Add text alignment
  const alignStyle = {
    textAlign: align as 'left' | 'center' | 'right',
  };

  // Special case for caption variants - use textMuted color if no color specified
  if ((variant === 'caption' || variant === 'captionMedium') && !color) {
    baseStyle.color = colors.textMuted;
  }

  // Combine all styles
  const textStyles = [
    baseStyle,
    alignStyle,
    style,
  ];

  return (
    <Text style={textStyles} {...props}>
      {children}
    </Text>
  );
};

export default Typography;
