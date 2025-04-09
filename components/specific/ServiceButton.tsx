import React from 'react';
import { TouchableOpacity, View, StyleSheet, ViewStyle, Animated } from 'react-native';
import { colors, spacing } from '@constants';
import { Typography } from '@components';
import { FontAwesome } from '@expo/vector-icons';

interface ServiceButtonProps {
  name: string;
  icon: string;
  color?: string;
  onPress: () => void;
  style?: ViewStyle;
  variant?: 'circle' | 'pill';
  size?: 'small' | 'medium' | 'large';
}

/**
 * ServiceButton component for playful service selection
 *
 * This component creates circular or pill-shaped buttons for service selection
 * with a more playful, engaging style compared to traditional cards.
 * Includes a subtle scale animation on press for more interactivity.
 */
const ServiceButton: React.FC<ServiceButtonProps> = ({
  name,
  icon,
  color = colors.primary,
  onPress,
  style,
  variant = 'circle',
  size = 'medium',
}) => {
  // Animation value for the scale effect
  const scaleAnim = React.useRef(new Animated.Value(1)).current;

  // Handle press animation
  const handlePressIn = () => {
    Animated.spring(scaleAnim, {
      toValue: 0.92,
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
  // Determine size based on prop
  const getSize = () => {
    switch (size) {
      case 'small':
        return {
          container: variant === 'circle' ? { width: 80, height: 80 } : { height: 40 },
          icon: 18,
        };
      case 'medium':
        return {
          container: variant === 'circle' ? { width: 100, height: 100 } : { height: 48 },
          icon: 24,
        };
      case 'large':
        return {
          container: variant === 'circle' ? { width: 120, height: 120 } : { height: 56 },
          icon: 30,
        };
      default:
        return {
          container: variant === 'circle' ? { width: 100, height: 100 } : { height: 48 },
          icon: 24,
        };
    }
  };

  const sizeStyles = getSize();

  return (
    <Animated.View style={{ transform: [{ scale: scaleAnim }] }}>
      <TouchableOpacity
        style={[
          styles.container,
          variant === 'circle' ? styles.circle : styles.pill,
          { backgroundColor: colors.cream },
          sizeStyles.container,
          style,
        ]}
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        activeOpacity={0.7}
      >
        <View style={[styles.iconContainer, { backgroundColor: color }]}>
          <FontAwesome name={icon} size={sizeStyles.icon} color="white" />
        </View>
        <Typography
          variant={size === 'small' ? 'caption' : 'bodyMedium'}
          align="center"
          style={styles.name}
        >
          {name}
        </Typography>
      </TouchableOpacity>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.sm,
    margin: spacing.xs,
    // Add shadow for depth
    shadowColor: 'rgba(0,0,0,0.15)',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 6,
    // Add border for more definition
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.3)',
  },
  circle: {
    borderRadius: 50, // Make it fully circular
  },
  pill: {
    borderRadius: 24,
    paddingHorizontal: spacing.md,
    flexDirection: 'row',
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.xs,
    // Add inner shadow effect with border
    borderWidth: 2,
    borderColor: 'rgba(255,255,255,0.2)',
  },
  name: {
    marginTop: spacing.xs,
    fontWeight: '600',
  },
});

export default ServiceButton;
