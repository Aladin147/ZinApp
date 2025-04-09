import React from 'react';
import { Text, TextProps, TextStyle, StyleSheet } from 'react-native';
import { colors, typography } from '@constants';
import tw from 'twrnc';

interface TypographyProps extends TextProps {
  variant?: 'screenTitle' | 'sectionHeader' | 'body' | 'bodyMedium' | 'button' | 'caption' | 'captionMedium';
  color?: string;
  align?: 'left' | 'center' | 'right';
  style?: TextStyle;
  children: React.ReactNode;
}

/**
 * Typography component following ZinApp design system
 *
 * Based on the specifications in the design documentation:
 * - Font Family: Uber Move (fallback: Inter / Satoshi)
 * - Screen Title: 24px, Bold, 32px line height
 * - Section Header: 18px, Bold, 26px line height
 * - Paragraph / Body: 14px, Regular, 20px line height
 * - Button Text: 16px, Medium, 20px line height
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
    color: color || colors.textMain,
  };

  // Add text alignment
  const alignStyle = {
    textAlign: align as 'left' | 'center' | 'right',
  };

  // Special case for caption variant - use textMuted color if no color specified
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
