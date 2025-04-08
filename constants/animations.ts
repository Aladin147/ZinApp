// Animation constants based on ANIMATION_INTERACTION_SYSTEM.md

export const animations = {
  // Durations
  durations: {
    fast: 200,   // 200ms - Quick tap actions
    mid: 400,    // 400ms - Standard screen transition
    slow: 600,   // 600ms - Deliberate, trust-building animations
    fadeIn: 300, // 300ms - Cards, profile blocks
    slideUp: 350, // 350ms - Bottom sheets, Bsse7a screen
  },
  
  // Timing functions
  easing: {
    easeFast: 'cubic-bezier(0.4, 0, 1, 1)', // Quick tap actions
    easeMid: 'cubic-bezier(0.4, 0, 0.2, 1)', // Standard screen transition
    easeSlow: 'cubic-bezier(0.2, 0.6, 0.4, 1)', // Deliberate animations
    springBounce: '', // To be used with Reanimated spring config
  },
  
  // Scale values
  scale: {
    buttonPress: 0.95, // Button press-in animation
    cardPress: 0.98,   // Card press effect
  },
  
  // Common animation presets
  presets: {
    fadeIn: {
      from: { opacity: 0 },
      to: { opacity: 1 },
      duration: 300,
    },
    slideUp: {
      from: { translateY: 50, opacity: 0 },
      to: { translateY: 0, opacity: 1 },
      duration: 350,
    },
    buttonPress: {
      from: { scale: 1 },
      to: { scale: 0.95 },
      duration: 100,
    },
    springConfig: {
      // For use with Reanimated spring
      damping: 15,
      mass: 1,
      stiffness: 200,
      overshootClamping: false,
    },
  },
  
  // Specific screen transitions
  screenTransitions: {
    // Key transitions from ANIMATION_INTERACTION_SYSTEM.md
    homeLanding: 'fade-in + scale',
    serviceSelect: 'slide-up',
    stylistList: 'fade-in',
    barberProfile: 'slide-in-right',
    bookingConfirm: 'bounce-scale',
    liveTrack: 'move + path-draw',
    bsse7aScreen: 'confetti + fade'
  },
};

export default animations;
