import { Animated } from 'react-native';
import { 
  StackCardInterpolationProps, 
  StackCardInterpolatedStyle 
} from '@react-navigation/stack';

/**
 * Custom screen transitions for ZinApp
 * These transitions enhance the user experience with playful, immersive animations
 * between screens.
 */

/**
 * Slide up transition with fade
 * Used for screens that feel like they're revealing content from below
 */
export const slideUpWithFade = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const translateY = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 1],
      outputRange: [screen.height, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [0, 0.5, 1],
  });

  const scale = current.progress.interpolate({
    inputRange: [0, 1],
    outputRange: [0.95, 1],
    extrapolate: 'clamp',
  });

  return {
    cardStyle: {
      transform: [
        { translateY },
        { scale }
      ],
      opacity,
    },
  };
};

/**
 * Reveal transition
 * Creates an effect where the new screen reveals itself from the center
 */
export const revealFromCenter = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const scale = current.progress.interpolate({
    inputRange: [0, 1],
    outputRange: [0.8, 1],
    extrapolate: 'clamp',
  });

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [0, 0.7, 1],
  });

  const borderRadius = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [20, 10, 0],
    extrapolate: 'clamp',
  });

  return {
    cardStyle: {
      transform: [{ scale }],
      opacity,
      borderRadius,
    },
  };
};

/**
 * Slide from right with bounce
 * A playful variation of the standard horizontal slide
 */
export const slideFromRightWithBounce = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const translateX = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 0.7, 0.9, 1],
      outputRange: [screen.width, 0, -10, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [0, 0.7, 1],
  });

  return {
    cardStyle: {
      transform: [{ translateX }],
      opacity,
    },
  };
};

/**
 * Fade with slight zoom
 * A subtle transition that fades the new screen in with a slight zoom effect
 */
export const fadeWithZoom = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const opacity = current.progress.interpolate({
    inputRange: [0, 1],
    outputRange: [0, 1],
  });

  const scale = current.progress.interpolate({
    inputRange: [0, 1],
    outputRange: [1.05, 1],
    extrapolate: 'clamp',
  });

  return {
    cardStyle: {
      opacity,
      transform: [{ scale }],
    },
  };
};

/**
 * Flip transition
 * Creates a 3D flip effect between screens
 */
export const flipTransition = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const rotateY = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 1],
      outputRange: [90, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [0, 0.5, 1],
  });

  return {
    cardStyle: {
      opacity,
      transform: [{ perspective: 1000 }, { rotateY: `${rotateY}deg` }],
    },
  };
};

/**
 * Celebration transition
 * A special transition for celebratory screens like Bsse7a
 */
export const celebrationTransition = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const scale = current.progress.interpolate({
    inputRange: [0, 0.5, 0.8, 1],
    outputRange: [0.5, 0.9, 1.05, 1],
    extrapolate: 'clamp',
  });

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.3, 1],
    outputRange: [0, 0.8, 1],
  });

  const translateY = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 1],
      outputRange: [50, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  return {
    cardStyle: {
      opacity,
      transform: [
        { scale },
        { translateY }
      ],
    },
  };
};

/**
 * Map-focused transition
 * A special transition for map-focused screens like LiveTrack
 */
export const mapFocusedTransition = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const translateY = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 1],
      outputRange: [screen.height * 0.3, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.6, 1],
    outputRange: [0, 0.8, 1],
  });

  const scale = current.progress.interpolate({
    inputRange: [0, 1],
    outputRange: [1.1, 1],
    extrapolate: 'clamp',
  });

  return {
    cardStyle: {
      opacity,
      transform: [
        { translateY },
        { scale }
      ],
    },
  };
};

/**
 * Booking transition
 * A special transition for booking-related screens
 */
export const bookingTransition = ({ 
  current, 
  next, 
  inverted, 
  layouts: { screen } 
}: StackCardInterpolationProps): StackCardInterpolatedStyle => {
  const translateX = Animated.multiply(
    current.progress.interpolate({
      inputRange: [0, 1],
      outputRange: [screen.width, 0],
      extrapolate: 'clamp',
    }),
    inverted
  );

  const opacity = current.progress.interpolate({
    inputRange: [0, 0.7, 1],
    outputRange: [0, 0.7, 1],
  });

  const scale = current.progress.interpolate({
    inputRange: [0, 0.5, 1],
    outputRange: [0.95, 0.98, 1],
    extrapolate: 'clamp',
  });

  return {
    cardStyle: {
      opacity,
      transform: [
        { translateX },
        { scale }
      ],
    },
  };
};
