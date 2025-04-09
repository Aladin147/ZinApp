import React from 'react';
import {
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  TouchableOpacityProps,
  ViewStyle,
  TextStyle,
  Animated
} from 'react-native';
import { colors, typography } from '@constants';
import Typography from './Typography';
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
 *
 * Based on the specifications in the design documentation:
 * - Primary color: Coral Orange (#F4805D)
 * - Border radius: 12px
 * - Height: 48px (standard), 56px (hero)
 * - Animation: Slight bounce on tap
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
  // Animation value for the bounce effect
  const scaleAnim = React.useRef(new Animated.Value(1)).current;

  // Handle press animation
  const handlePressIn = () => {
    Animated.spring(scaleAnim, {
      toValue: 0.95,
      useNativeDriver: true,
      speed: 20,
      bounciness: 6
    }).start();
  };

  const handlePressOut = () => {
    Animated.spring(scaleAnim, {
      toValue: 1,
      useNativeDriver: true,
      speed: 20,
      bounciness: 6
    }).start();
  };

  // Determine button styles based on variant
  const getButtonStyle = () => {
    switch (variant) {
      case 'primary':
        return [
          styles.button,
          styles.primaryButton,
          styles.shadow
        ];
      case 'secondary':
        return [
          styles.button,
          styles.secondaryButton
        ];
      case 'outline':
        return [
          styles.button,
          styles.outlineButton
        ];
      default:
        return [
          styles.button,
          styles.primaryButton,
          styles.shadow
        ];
    }
  };

  // Determine height based on size
  const getHeightStyle = () => {
    switch (size) {
      case 'small':
        return { height: 40 };
      case 'medium':
        return { height: 48 }; // Standard height from design specs
      case 'large':
        return { height: 56 }; // Hero height from design specs
      default:
        return { height: 48 };
    }
  };

  // Determine text color based on variant
  const getTextColor = () => {
    switch (variant) {
      case 'primary':
      case 'secondary':
        return 'white';
      case 'outline':
        return colors.primary;
      default:
        return 'white';
    }
  };

  // Combine all styles
  const buttonStyles = [
    getButtonStyle(),
    getHeightStyle(),
    disabled && styles.disabledButton,
    { transform: [{ scale: scaleAnim }] },
    style,
  ];

  return (
    <Animated.View style={{ transform: [{ scale: scaleAnim }] }}>
      <TouchableOpacity
        style={buttonStyles}
        disabled={disabled || loading}
        activeOpacity={0.7}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        {...props}
      >
        {loading ? (
          <ActivityIndicator
            size="small"
            color={variant === 'outline' ? colors.primary : 'white'}
          />
        ) : (
          <Typography
            variant="button"
            color={getTextColor()}
            align="center"
            style={textStyle}
          >
            {title}
          </Typography>
        )}
      </TouchableOpacity>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  button: {
    borderRadius: 12, // 12px border-radius from design specs
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 16,
  },
  primaryButton: {
    backgroundColor: colors.primary, // Coral Orange from design specs
  },
  secondaryButton: {
    backgroundColor: colors.accent, // Cool Blue Slate from design specs
  },
  outlineButton: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: colors.primary,
  },
  disabledButton: {
    opacity: 0.5,
  },
  shadow: {
    shadowColor: colors.primary,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 3,
  },
});

export default Button;
