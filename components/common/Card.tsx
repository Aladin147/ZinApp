import React from 'react';
import {
  View,
  StyleSheet,
  ViewProps,
  ViewStyle,
  TouchableOpacity
} from 'react-native';
import { colors } from '@constants';

interface CardProps extends ViewProps {
  style?: ViewStyle;
  children: React.ReactNode;
  onPress?: () => void;
  variant?: 'default' | 'flat' | 'elevated';
  padding?: 'none' | 'small' | 'medium' | 'large';
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
  ...props
}) => {
  // Determine card styles based on variant
  const getCardStyle = () => {
    switch (variant) {
      case 'default':
        return [styles.card];
      case 'flat':
        return [styles.card, styles.flatCard];
      case 'elevated':
        return [styles.card, styles.elevatedCard];
      default:
        return [styles.card];
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

const styles = StyleSheet.create({
  card: {
    backgroundColor: 'white',
    borderRadius: 16, // 16px border-radius from design specs
    marginBottom: 16, // 16px outer margin from design specs
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
});

export default Card;
