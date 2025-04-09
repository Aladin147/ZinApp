import React from 'react';
import {
  View,
  StyleSheet,
  ViewProps,
  ViewStyle,
  TouchableOpacity,
  Animated
} from 'react-native';
import { colors, spacing } from '../../constants';

interface CardProps extends ViewProps {
  style?: ViewStyle;
  children: React.ReactNode;
  onPress?: () => void;
  variant?: 'default' | 'flat' | 'elevated' | 'warm' | 'bubble' | 'floating';
  padding?: 'none' | 'small' | 'medium' | 'large';
  animated?: boolean;
  borderColor?: string;
  withShadow?: boolean;
}

/**
 * Card component following ZinApp design system
 *
 * Based on the specifications in the audit requirements:
 * - 16px border radius (audit requirement)
 * - 12px inner padding, 16px outer margin (audit requirement)
 * - Flat, no shadows (audit requirement)
 */
const Card: React.FC<CardProps> = ({
  style,
  children,
  onPress,
  variant = 'default',
  padding = 'medium',
  animated = false,
  borderColor,
  withShadow = false,
  ...props
}) => {
  // Animation value for fade-in effect
  const fadeAnim = React.useRef(new Animated.Value(0)).current;
  // Start fade-in animation when component mounts
  React.useEffect(() => {
    if (animated) {
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 400, // Slightly longer animation for more playfulness
        useNativeDriver: true,
      }).start();
    } else {
      // If not animated, set opacity to 1 immediately
      fadeAnim.setValue(1);
    }
  }, [animated, fadeAnim]);

  // Determine card styles based on variant
  const getCardStyle = () => {
    const baseStyle = [styles.card];

    if (borderColor) {
      baseStyle.push({ borderColor, borderWidth: 1 });
    }

    if (withShadow) {
      baseStyle.push(styles.shadow);
    }

    switch (variant) {
      case 'default':
        return baseStyle;
      case 'flat':
        return [...baseStyle, styles.flatCard];
      case 'elevated':
        return [...baseStyle, styles.elevatedCard];
      case 'warm':
        return [...baseStyle, styles.warmCard];
      case 'bubble':
        return [...baseStyle, styles.bubbleCard];
      case 'floating':
        return [...baseStyle, styles.floatingCard];
      default:
        return baseStyle;
    }
  };

  // Determine padding based on size
  const getPaddingStyle = () => {
    switch (padding) {
      case 'none':
        return { padding: 0 };
      case 'small':
        return { padding: 8 };
      case 'medium':
        return { padding: 12 }; // 12px inner padding (audit requirement)
      case 'large':
        return { padding: 24 };
      default:
        return { padding: 12 }; // 12px inner padding (audit requirement)
    }
  };

  // Combine all styles
  const cardStyles = [
    getCardStyle(),
    getPaddingStyle(),
    style,
  ];

  // Animation style
  const animStyle = {
    opacity: fadeAnim,
  };

  // Create the card content
  const renderCard = () => {
    // If onPress is provided, wrap in TouchableOpacity, otherwise use View
    if (onPress) {
      return (
        <TouchableOpacity
          style={cardStyles}
          onPress={onPress}
          activeOpacity={0.7}
          {...props}
        >
          {children}
        </TouchableOpacity>
      );
    }

    return (
      <View style={cardStyles} {...props}>
        {children}
      </View>
    );
  };

  // If animated, wrap in Animated.View, otherwise render directly
  return animated ? (
    <Animated.View style={animStyle}>
      {renderCard()}
    </Animated.View>
  ) : (
    renderCard()
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.cream, // Cream background from design specs
    borderRadius: 16, // 16px border radius (audit requirement)
    marginBottom: spacing.md, // 16px outer margin (audit requirement)
    // Flat, no shadows by default (audit requirement)
    shadowColor: 'transparent',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0,
    shadowRadius: 0,
    elevation: 0,
  },
  shadow: {
    // Shadow for cards that need to pop against colored backgrounds
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 4,
  },
  flatCard: {
    // No shadow for flat cards as per design specs
  },
  elevatedCard: {
    // Only use this variant for backward compatibility
  },
  warmCard: {
    backgroundColor: colors.warmSand, // Warm Sand background from design specs
  },
  bubbleCard: {
    borderRadius: 24, // More rounded corners for bubble-like appearance
    padding: spacing.md,
  },
  floatingCard: {
    borderRadius: 20,
    transform: [{ translateY: -4 }], // Slight lift effect
  },
});

export default Card;
