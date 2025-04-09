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
  variant?: 'default' | 'flat' | 'elevated' | 'warm';
  padding?: 'none' | 'small' | 'medium' | 'large';
  animated?: boolean;
  borderColor?: string;
}

/**
 * Card component following ZinApp design system
 *
 * Based on the specifications in the design documentation:
 * - 16px border-radius on containers
 * - 8px inner padding, 16px outer margin
 * - Elevation-free (no shadows) to mimic flat material
 */
const Card: React.FC<CardProps> = ({
  style,
  children,
  onPress,
  variant = 'default',
  padding = 'medium',
  animated = false,
  borderColor,
  ...props
}) => {
  // Animation value for fade-in effect
  const fadeAnim = React.useRef(new Animated.Value(0)).current;
  // Start fade-in animation when component mounts
  React.useEffect(() => {
    if (animated) {
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 300, // Match the fade-in animation token from design
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

    switch (variant) {
      case 'default':
        return baseStyle;
      case 'flat':
        return [...baseStyle, styles.flatCard];
      case 'elevated':
        return [...baseStyle, styles.elevatedCard];
      case 'warm':
        return [...baseStyle, styles.warmCard];
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
        return { padding: 8 }; // 8px inner padding from design specs
      case 'medium':
        return { padding: 16 };
      case 'large':
        return { padding: 24 };
      default:
        return { padding: 16 };
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
    backgroundColor: colors.bgLight,
    borderRadius: 16, // 16px border-radius from design specs
    marginBottom: spacing.md, // 16px outer margin from design specs
  },
  flatCard: {
    // No shadow for flat cards as per design specs
  },
  elevatedCard: {
    // Light shadow for elevated cards
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  warmCard: {
    backgroundColor: colors.warmSand, // Warm Sand background from design specs
  },
});

export default Card;
