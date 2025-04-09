import React from 'react';
import { Text, TextProps, TextStyle } from 'react-native';
import { colors } from '@constants';
import tw from 'twrnc';

interface TypographyProps extends TextProps {
  variant?: 'heading' | 'subheading' | 'body' | 'caption' | 'button';
  color?: string;
  align?: 'left' | 'center' | 'right';
  weight?: 'normal' | 'medium' | 'bold';
  style?: TextStyle;
  children: React.ReactNode;
}

/**
 * Typography component following ZinApp design system
 */
const Typography: React.FC<TypographyProps> = ({
  variant = 'body',
  color,
  align = 'left',
  weight,
  style,
  children,
  ...props
}) => {
  // Determine text styles based on variant
  const getVariantStyle = () => {
    switch (variant) {
      case 'heading':
        return [tw`text-2xl`, { color: color || colors.textMain }];
      case 'subheading':
        return [tw`text-xl`, { color: color || colors.textMain }];
      case 'body':
        return [tw`text-base`, { color: color || colors.textMain }];
      case 'caption':
        return [tw`text-sm`, { color: color || colors.textMuted }];
      case 'button':
        return [tw`text-base`, { color: color || colors.textMain }];
      default:
        return [tw`text-base`, { color: color || colors.textMain }];
    }
  };

  // Determine font weight
  const getWeightStyle = () => {
    if (!weight) {
      // Default weights based on variant
      switch (variant) {
        case 'heading':
          return tw`font-bold`;
        case 'subheading':
          return tw`font-semibold`;
        case 'button':
          return tw`font-medium`;
        default:
          return tw`font-normal`;
      }
    }

    switch (weight) {
      case 'normal':
        return tw`font-normal`;
      case 'medium':
        return tw`font-medium`;
      case 'bold':
        return tw`font-bold`;
      default:
        return tw`font-normal`;
    }
  };

  // Determine text alignment
  const getAlignStyle = () => {
    switch (align) {
      case 'left':
        return tw`text-left`;
      case 'center':
        return tw`text-center`;
      case 'right':
        return tw`text-right`;
      default:
        return tw`text-left`;
    }
  };

  // Combine all styles
  const textStyles = [
    getVariantStyle(),
    getWeightStyle(),
    getAlignStyle(),
    style,
  ];

  return (
    <Text style={textStyles} {...props}>
      {children}
    </Text>
  );
};

export default Typography;
