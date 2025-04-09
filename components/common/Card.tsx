import React from 'react';
import { 
  View, 
  StyleSheet, 
  ViewProps, 
  ViewStyle,
  TouchableOpacity
} from 'react-native';
import { colors } from '@constants';
import tw from 'twrnc';

interface CardProps extends ViewProps {
  style?: ViewStyle;
  children: React.ReactNode;
  onPress?: () => void;
  variant?: 'default' | 'flat' | 'elevated';
  padding?: 'none' | 'small' | 'medium' | 'large';
}

/**
 * Card component following ZinApp design system
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
        return [tw`bg-white rounded-2xl`, styles.shadow];
      case 'flat':
        return tw`bg-white rounded-2xl`;
      case 'elevated':
        return [tw`bg-white rounded-2xl`, styles.elevatedShadow];
      default:
        return [tw`bg-white rounded-2xl`, styles.shadow];
    }
  };

  // Determine padding based on size
  const getPaddingStyle = () => {
    switch (padding) {
      case 'none':
        return tw`p-0`;
      case 'small':
        return tw`p-2`;
      case 'medium':
        return tw`p-4`;
      case 'large':
        return tw`p-6`;
      default:
        return tw`p-4`;
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
  shadow: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  elevatedShadow: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 4,
  },
});

export default Card;
