import React, { useEffect } from 'react';
import { View, StyleSheet, ViewStyle } from 'react-native';
import { Animated, Easing } from 'react-native';
import { colors } from '../../constants';
import Icon from 'react-native-vector-icons/FontAwesome';

interface RatingStarsProps {
  /**
   * The rating value (0-5)
   */
  rating: number;

  /**
   * Maximum number of stars
   */
  maxRating?: number;

  /**
   * Size of each star
   * Can be a predefined size ('small', 'medium', 'large') or a specific number
   */
  size?: 'small' | 'medium' | 'large' | number;

  /**
   * Whether to animate the stars when they appear
   */
  animated?: boolean;

  /**
   * Custom style for the container
   */
  style?: ViewStyle;

  /**
   * Color of the filled stars
   */
  activeColor?: string;

  /**
   * Color of the empty stars
   */
  inactiveColor?: string;
}

/**
 * RatingStars component for displaying ratings
 *
 * Based on the design specifications in the conceptboard:
 * - Gold/orange stars for active ratings
 * - Light gray stars for inactive ratings
 * - Supports different sizes
 * - Optional animation when appearing
 */
const RatingStars: React.FC<RatingStarsProps> = ({
  rating,
  maxRating = 5,
  size = 'medium',
  animated = true,
  style,
  activeColor = colors.primary,
  inactiveColor = colors.gray300,
}) => {
  // Animation values for each star
  const animatedValues = React.useRef(
    Array(maxRating).fill(0).map(() => new Animated.Value(0))
  ).current;

  // Get star size based on the size prop
  const getStarSize = () => {
    if (typeof size === 'number') {
      return size;
    }

    switch (size) {
      case 'small':
        return 16;
      case 'medium':
        return 20;
      case 'large':
        return 24;
      default:
        return 20;
    }
  };

  // Get spacing between stars based on the size prop
  const getStarSpacing = () => {
    if (typeof size === 'number') {
      // For numeric sizes, scale the spacing proportionally
      return Math.max(2, Math.floor(size / 5));
    }

    switch (size) {
      case 'small':
        return 2;
      case 'medium':
        return 4;
      case 'large':
        return 6;
      default:
        return 4;
    }
  };

  // Animate stars when component mounts
  useEffect(() => {
    if (animated) {
      const animations = animatedValues.map((value, index) => {
        return Animated.timing(value, {
          toValue: 1,
          duration: 300,
          delay: index * 100, // Stagger the animations
          easing: Easing.out(Easing.back(1.5)),
          useNativeDriver: true,
        });
      });

      Animated.stagger(50, animations).start();
    } else {
      // If not animated, set all values to 1 immediately
      animatedValues.forEach(value => value.setValue(1));
    }
  }, [animated, animatedValues]);

  // Render a single star
  const renderStar = (index: number) => {
    const isFilled = index < Math.floor(rating);
    const isHalfFilled = !isFilled && index < Math.ceil(rating) && rating % 1 !== 0;

    const starSize = getStarSize();

    // Animation styles
    const animatedStyle = {
      transform: [
        {
          scale: animatedValues[index].interpolate({
            inputRange: [0, 1],
            outputRange: [0, 1],
          })
        },
        {
          rotate: animatedValues[index].interpolate({
            inputRange: [0, 1],
            outputRange: ['0deg', '0deg'], // No rotation in this version
          })
        }
      ],
      opacity: animatedValues[index].interpolate({
        inputRange: [0, 1],
        outputRange: [0, 1],
      }),
    };

    // Determine which icon to use based on the rating
    const iconName = isFilled ? 'star' : (isHalfFilled ? 'star-half-o' : 'star-o');

    return (
      <Animated.View
        key={`star-${index}`}
        style={[styles.starContainer, animatedStyle]}
      >
        <Icon
          name={iconName}
          size={starSize}
          color={isFilled || isHalfFilled ? activeColor : inactiveColor}
          style={styles.starIcon}
        />
      </Animated.View>
    );
  };

  return (
    <View style={[
      styles.container,
      { gap: getStarSpacing() },
      style
    ]}>
      {Array(maxRating).fill(0).map((_, index) => renderStar(index))}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  starContainer: {
    position: 'relative',
    justifyContent: 'center',
    alignItems: 'center',
  },
  starIcon: {
    // Additional styling for the star icon if needed
  }
});

export default RatingStars;
