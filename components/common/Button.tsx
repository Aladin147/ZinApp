import React from 'react';
import { 
  TouchableOpacity, 
  Text, 
  StyleSheet, 
  ActivityIndicator,
  TouchableOpacityProps,
  ViewStyle,
  TextStyle
} from 'react-native';
import { colors } from '@constants';
import tw from 'twrnc';

interface ButtonProps extends TouchableOpacityProps {
  title: string;
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'small' | 'medium' | 'large';
  loading?: boolean;
  disabled?: boolean;
  style?: ViewStyle;
  textStyle?: TextStyle;
}

/**
 * Button component following ZinApp design system
 */
const Button: React.FC<ButtonProps> = ({
  title,
  variant = 'primary',
  size = 'medium',
  loading = false,
  disabled = false,
  style,
  textStyle,
  ...props
}) => {
  // Determine button styles based on variant
  const getButtonStyle = () => {
    switch (variant) {
      case 'primary':
        return [
          tw`bg-[#FF6A33] items-center justify-center rounded-xl`,
          styles.shadow
        ];
      case 'secondary':
        return tw`bg-[#8CBACD] items-center justify-center rounded-xl`;
      case 'outline':
        return tw`border border-[#FF6A33] bg-transparent items-center justify-center rounded-xl`;
      default:
        return tw`bg-[#FF6A33] items-center justify-center rounded-xl`;
    }
  };

  // Determine text styles based on variant
  const getTextStyle = () => {
    switch (variant) {
      case 'primary':
      case 'secondary':
        return tw`text-white font-medium`;
      case 'outline':
        return [tw`font-medium`, { color: colors.primary }];
      default:
        return tw`text-white font-medium`;
    }
  };

  // Determine padding based on size
  const getPaddingStyle = () => {
    switch (size) {
      case 'small':
        return tw`py-2 px-4`;
      case 'medium':
        return tw`py-3 px-6`;
      case 'large':
        return tw`py-4 px-8`;
      default:
        return tw`py-3 px-6`;
    }
  };

  // Determine text size based on button size
  const getTextSizeStyle = () => {
    switch (size) {
      case 'small':
        return tw`text-sm`;
      case 'medium':
        return tw`text-base`;
      case 'large':
        return tw`text-lg`;
      default:
        return tw`text-base`;
    }
  };

  // Combine all styles
  const buttonStyles = [
    getButtonStyle(),
    getPaddingStyle(),
    disabled && tw`opacity-50`,
    style,
  ];

  const textStyles = [
    getTextStyle(),
    getTextSizeStyle(),
    textStyle,
  ];

  return (
    <TouchableOpacity
      style={buttonStyles}
      disabled={disabled || loading}
      activeOpacity={0.7}
      {...props}
    >
      {loading ? (
        <ActivityIndicator 
          size="small" 
          color={variant === 'outline' ? colors.primary : 'white'} 
        />
      ) : (
        <Text style={textStyles}>{title}</Text>
      )}
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  shadow: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
});

export default Button;
