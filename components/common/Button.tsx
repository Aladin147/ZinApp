import React from 'react';
import {
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  TouchableOpacityProps,
  ViewStyle,
  TextStyle,
  Animated,
  View
} from 'react-native';
import { colors, typography, spacing } from '../../constants';
import Typography from './Typography';
import tw from 'twrnc';
import Icon from 'react-native-vector-icons/FontAwesome';

interface ButtonProps extends TouchableOpacityProps {
  title: string;
  variant?: 'primary' | 'secondary' | 'outline' | 'text';
  size?: 'small' | 'medium' | 'large';
  loading?: boolean;
  disabled?: boolean;
  style?: ViewStyle;
  textStyle?: TextStyle;
  iconName?: string;
  iconPosition?: 'left' | 'right';
  fullWidth?: boolean;
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
  iconName,
  iconPosition = 'left',
  fullWidth = false,
  ...props
}) => {
  // Animation value for the bounce effect
  const scaleAnim = React.useRef(new Animated.Value(1)).current;

  // Handle press animation
  const handlePressIn = () => {
    Animated.spring(scaleAnim, {
      toValue: 0.92,
      useNativeDriver: true,
      speed: 25,
      bounciness: 10
    }).start();
  };

  const handlePressOut = () => {
    Animated.spring(scaleAnim, {
      toValue: 1,
      useNativeDriver: true,
      speed: 25,
      bounciness: 10
    }).start();
  };

  // Determine button styles based on variant
  const getButtonStyle = () => {
    switch (variant) {
      case 'primary':
        return [
          styles.button,
          styles.primaryButton,
          styles.shadow,
          fullWidth && styles.fullWidth
        ];
      case 'secondary':
        return [
          styles.button,
          styles.secondaryButton,
          fullWidth && styles.fullWidth
        ];
      case 'outline':
        return [
          styles.button,
          styles.outlineButton,
          fullWidth && styles.fullWidth
        ];
      case 'text':
        return [
          styles.button,
          styles.textButton,
          fullWidth && styles.fullWidth
        ];
      default:
        return [
          styles.button,
          styles.primaryButton,
          styles.shadow,
          fullWidth && styles.fullWidth
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
      case 'text':
        return colors.primary;
      default:
        return 'white';
    }
  };

  // Get icon size based on button size
  const getIconSize = () => {
    switch (size) {
      case 'small':
        return 14;
      case 'medium':
        return 18;
      case 'large':
        return 20;
      default:
        return 18;
    }
  };

  // Render icon if provided
  const renderIcon = () => {
    if (!iconName) return null;

    return (
      <Icon
        name={iconName}
        size={getIconSize()}
        color={variant === 'primary' || variant === 'secondary' ? 'white' : colors.primary}
        style={[
          iconPosition === 'left' ? styles.iconLeft : styles.iconRight,
        ]}
      />
    );
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
            color={variant === 'outline' || variant === 'text' ? colors.primary : 'white'}
          />
        ) : (
          <View style={styles.contentContainer}>
            {iconPosition === 'left' && renderIcon()}
            <Typography
              variant="button"
              color={getTextColor()}
              align="center"
              style={textStyle}
            >
              {title}
            </Typography>
            {iconPosition === 'right' && renderIcon()}
          </View>
        )}
      </TouchableOpacity>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  button: {
    borderRadius: 24, // More rounded, bubbly buttons
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 16,
  },
  primaryButton: {
    backgroundColor: colors.primary, // Coral Orange from design specs
  },
  secondaryButton: {
    backgroundColor: colors.stylistBlue, // Cool Blue Slate from design specs
  },
  outlineButton: {
    backgroundColor: 'white',
    borderWidth: 2, // 2px border per design specs
    borderColor: colors.primary,
  },
  textButton: {
    backgroundColor: 'transparent',
    paddingHorizontal: spacing.sm,
  },
  disabledButton: {
    opacity: 0.5,
  },
  shadow: {
    // No shadow per flat design specs
  },
  fullWidth: {
    width: '100%',
  },
  contentContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  iconLeft: {
    marginRight: spacing.xs,
  },
  iconRight: {
    marginLeft: spacing.xs,
  },
});

export default Button;
