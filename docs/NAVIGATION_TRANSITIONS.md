# Navigation Transitions Implementation

This document details the implementation of custom navigation transitions for ZinApp to create a more cohesive, engaging user experience.

## Overview

We've implemented custom screen transitions that enhance the user experience with playful, immersive animations between screens. Each screen has a unique transition that matches its purpose and content, creating a more engaging and cohesive user journey.

## Custom Transitions

### 1. Slide Up with Fade

Used for screens that feel like they're revealing content from below, such as the ServiceSelectScreen.

```typescript
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
```

### 2. Reveal from Center

Creates an effect where the new screen reveals itself from the center, used for the BarberProfileScreen.

```typescript
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
```

### 3. Slide from Right with Bounce

A playful variation of the standard horizontal slide, used as the default transition and for the StylistListScreen.

```typescript
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
```

### 4. Fade with Zoom

A subtle transition that fades the new screen in with a slight zoom effect, used for the LandingScreen.

```typescript
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
```

### 5. Celebration Transition

A special transition for celebratory screens like Bsse7a, with a scale and fade effect.

```typescript
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
```

### 6. Map-Focused Transition

A special transition for map-focused screens like LiveTrack, with a slide and scale effect.

```typescript
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
```

### 7. Booking Transition

A special transition for booking-related screens, with a slide and scale effect.

```typescript
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
```

## Navigation Configuration

We've configured the navigation stack to use our custom transitions for each screen:

```typescript
<Stack.Navigator
  initialRouteName="LandingScreen"
  screenOptions={{
    headerShown: false,
    // Use our custom slide animation as default
    cardStyleInterpolator: slideFromRightWithBounce,
    gestureEnabled: true,
    gestureDirection: 'horizontal',
    // Add shared transition options for all screens
    transitionSpec: {
      open: {
        animation: 'spring',
        config: {
          stiffness: 1000,
          damping: 500,
          mass: 3,
          overshootClamping: true,
          restDisplacementThreshold: 0.01,
          restSpeedThreshold: 0.01,
        },
      },
      close: {
        animation: 'spring',
        config: {
          stiffness: 1000,
          damping: 500,
          mass: 3,
          overshootClamping: true,
          restDisplacementThreshold: 0.01,
          restSpeedThreshold: 0.01,
        },
      },
    },
  }}
>
  <Stack.Screen
    name="LandingScreen"
    component={LandingScreen}
    options={{
      cardStyleInterpolator: fadeWithZoom,
    }}
  />
  <Stack.Screen
    name="ServiceSelectScreen"
    component={ServiceSelectScreen}
    options={{
      cardStyleInterpolator: slideUpWithFade,
    }}
  />
  <Stack.Screen
    name="StylistListScreen"
    component={StylistListScreen}
    options={{
      cardStyleInterpolator: slideFromRightWithBounce,
    }}
  />
  <Stack.Screen
    name="BarberProfileScreen"
    component={BarberProfileScreen}
    options={{
      cardStyleInterpolator: revealFromCenter,
    }}
  />
  <Stack.Screen
    name="BookingScreen"
    component={BookingScreen}
    options={{
      cardStyleInterpolator: bookingTransition,
    }}
  />
  <Stack.Screen
    name="LiveTrackScreen"
    component={LiveTrackScreen}
    options={{
      cardStyleInterpolator: mapFocusedTransition,
    }}
  />
  <Stack.Screen
    name="Bsse7aScreen"
    component={Bsse7aScreen}
    options={{
      cardStyleInterpolator: celebrationTransition,
    }}
  />
</Stack.Navigator>
```

## Screen-Specific Transitions

Each screen has a custom transition that matches its purpose and content:

1. **LandingScreen**: Fade with zoom for a subtle, welcoming entrance
2. **ServiceSelectScreen**: Slide up with fade for a revealing effect
3. **StylistListScreen**: Slide from right with bounce for a playful transition
4. **BarberProfileScreen**: Reveal from center to focus attention on the stylist
5. **BookingScreen**: Booking transition with slide and scale for a smooth flow
6. **LiveTrackScreen**: Map-focused transition with slide and scale for a map-centric view
7. **Bsse7aScreen**: Celebration transition with scale and fade for a celebratory feel

## Implementation Notes

- We've used React Navigation's `cardStyleInterpolator` to create custom transitions
- Each transition is implemented as a function that returns a `StackCardInterpolatedStyle` object
- We've used Animated.interpolate to create smooth animations between states
- We've used spring animations for a more natural, playful feel
- We've customized the spring configuration for optimal performance and feel
- We've made the transitions gesture-enabled for better user interaction
- We've used opacity, scale, and translation transforms for a variety of effects
