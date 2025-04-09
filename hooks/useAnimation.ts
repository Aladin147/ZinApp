import { useRef, useEffect } from 'react';
import { Animated, Easing } from 'react-native';
import { animations } from '../constants';

/**
 * Custom hook for creating and managing animations in a Glovo-like style
 * 
 * @param initialValue - Initial value for the animation
 * @param type - Type of animation (fadeIn, slideUp, etc.)
 * @returns Animation value and control functions
 */
export const useAnimation = (initialValue = 0, type = 'fadeIn') => {
  // Create animation value
  const animatedValue = useRef(new Animated.Value(initialValue)).current;
  
  // Get animation preset based on type
  const getPreset = () => {
    switch (type) {
      case 'fadeIn':
        return {
          toValue: 1,
          duration: animations.durations.fadeIn,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        };
      case 'slideUp':
        return {
          toValue: 1,
          duration: animations.durations.slideUp,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        };
      case 'bounce':
        return {
          toValue: 1,
          duration: animations.durations.bounce,
          easing: Easing.bezier(0.34, 1.56, 0.64, 1), // Playful bounce
          useNativeDriver: true,
        };
      case 'buttonTap':
        return {
          toValue: 1,
          duration: animations.durations.buttonTap,
          easing: Easing.bezier(0.4, 0, 1, 1),
          useNativeDriver: true,
        };
      default:
        return {
          toValue: 1,
          duration: animations.durations.mid,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        };
    }
  };
  
  // Start animation
  const startAnimation = (customConfig = {}) => {
    const preset = getPreset();
    Animated.timing(animatedValue, {
      ...preset,
      ...customConfig,
    }).start();
  };
  
  // Reset animation
  const resetAnimation = (customConfig = {}) => {
    Animated.timing(animatedValue, {
      toValue: initialValue,
      duration: 100,
      useNativeDriver: true,
      ...customConfig,
    }).start();
  };
  
  // Sequence of animations
  const sequence = (animations: Animated.CompositeAnimation[]) => {
    Animated.sequence(animations).start();
  };
  
  // Staggered animations
  const stagger = (animations: Animated.CompositeAnimation[], staggerDelay = 100) => {
    Animated.stagger(staggerDelay, animations).start();
  };
  
  // Spring animation
  const spring = (customConfig = {}) => {
    Animated.spring(animatedValue, {
      toValue: 1,
      damping: animations.presets.springConfig.damping,
      mass: animations.presets.springConfig.mass,
      stiffness: animations.presets.springConfig.stiffness,
      overshootClamping: animations.presets.springConfig.overshootClamping,
      useNativeDriver: true,
      ...customConfig,
    }).start();
  };
  
  // Loop animation
  const loop = (iterations = -1) => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(animatedValue, {
          toValue: 1,
          duration: 800,
          useNativeDriver: true,
        }),
        Animated.timing(animatedValue, {
          toValue: initialValue,
          duration: 800,
          useNativeDriver: true,
        }),
      ]),
      { iterations }
    ).start();
  };
  
  // Pulse animation (for map avatars and attention elements)
  const pulse = (iterations = -1) => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(animatedValue, {
          toValue: 1.05,
          duration: animations.durations.mapPulse / 2,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
        Animated.timing(animatedValue, {
          toValue: 1,
          duration: animations.durations.mapPulse / 2,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
      ]),
      { iterations }
    ).start();
  };
  
  // Wiggle animation (for interactive elements)
  const wiggle = (iterations = 1) => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(animatedValue, {
          toValue: -1,
          duration: animations.durations.wiggle / 4,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
        Animated.timing(animatedValue, {
          toValue: 1,
          duration: animations.durations.wiggle / 4,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
        Animated.timing(animatedValue, {
          toValue: -0.5,
          duration: animations.durations.wiggle / 4,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
        Animated.timing(animatedValue, {
          toValue: 0,
          duration: animations.durations.wiggle / 4,
          easing: Easing.bezier(0.4, 0, 0.2, 1),
          useNativeDriver: true,
        }),
      ]),
      { iterations }
    ).start();
  };
  
  return {
    animatedValue,
    startAnimation,
    resetAnimation,
    sequence,
    stagger,
    spring,
    loop,
    pulse,
    wiggle,
  };
};

export default useAnimation;
