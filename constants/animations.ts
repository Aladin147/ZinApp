// Animation constants based on ANIMATION_INTERACTION_SYSTEM.md
// Updated for Glovo-like playful animations

export const animations = {
  // Durations
  durations: {
    screenTransition: 300, // 300ms - Slide + Fade screen transitions with bounce
    buttonTap: 100,       // 100ms - Scale down to 0.92 with extra bounce
    confetti: 1200,       // 1200ms - Booking confirmation animation
    mapPulse: 1500,       // 1500ms - Pulsing animation for map avatars
    fadeIn: 400,          // 400ms - Appear transitions for cards
    slideUp: 500,         // 500ms - Bottom sheets, Bsse7a screen
    bounce: 800,          // 800ms - Playful bounce for attention elements
    wiggle: 600,          // 600ms - Subtle wiggle for interactive elements
  },

  // Timing functions
  easing: {
    easeFast: 'cubic-bezier(0.4, 0, 1, 1)',     // Quick tap actions
    easeMid: 'cubic-bezier(0.4, 0, 0.2, 1)',     // Standard screen transition
    easeSlow: 'cubic-bezier(0.2, 0.6, 0.4, 1)',  // Deliberate animations
    playful: 'cubic-bezier(0.34, 1.56, 0.64, 1)', // Playful, bouncy easing (Glovo-like)
    springBounce: '',                            // To be used with Reanimated spring config
  },

  // Scale values
  scale: {
    buttonPress: 0.92, // Button press-in animation (more pronounced for Glovo-like feel)
    cardPress: 0.96,   // Card press effect (more pronounced for Glovo-like feel)
    bounce: 1.05,      // Slight bounce up for attention elements
  },

  // Common animation presets
  presets: {
    fadeIn: {
      from: { opacity: 0 },
      to: { opacity: 1 },
      duration: 400, // Longer for more impact
    },
    slideUp: {
      from: { translateY: 50, opacity: 0 },
      to: { translateY: 0, opacity: 1 },
      duration: 500, // Longer for more impact
    },
    buttonPress: {
      from: { scale: 1 },
      to: { scale: 0.92 },
      duration: 100,
    },
    bounce: {
      from: { scale: 0.95, opacity: 0.8 },
      to: { scale: 1.05, opacity: 1 },
      duration: 300,
    },
    wiggle: {
      // For use with Moti or Reanimated
      // Implement with keyframes or interpolation
      duration: 600,
    },
    springConfig: {
      // For use with Reanimated spring - more bouncy for Glovo-like feel
      damping: 10, // Lower damping = more bounce
      mass: 1,
      stiffness: 180,
      overshootClamping: false,
    },
  },

  // Specific screen transitions
  screenTransitions: {
    // Key transitions from ANIMATION_INTERACTION_SYSTEM.md - updated for Glovo-like feel
    homeLanding: 'fade-in + bounce-scale',
    serviceSelect: 'slide-up + fade',
    stylistList: 'staggered-fade-in',
    barberProfile: 'slide-in-right + bounce',
    bookingConfirm: 'bounce-scale + confetti',
    liveTrack: 'move + path-draw + pulse',
    bsse7aScreen: 'confetti + fade'
  },

  // Micro-interactions for Glovo-like feel
  microInteractions: {
    cardTap: 'scale-down + shadow',
    buttonTap: 'scale-down + bounce-back',
    success: 'pulse + scale-up',
    error: 'shake + fade',
    loading: 'pulse + opacity',
    notification: 'bounce + fade',
  },
};

export default animations;
