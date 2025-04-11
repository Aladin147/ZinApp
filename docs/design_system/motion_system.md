# ZinApp Motion System

## Overview

The ZinApp Motion System defines a cohesive language of movement that enhances the user experience, reinforces brand identity, and creates a premium, sophisticated feel. This document outlines the principles, patterns, and implementation guidelines for motion across the application.

## Motion Principles

### 1. Confident & Precise
Animations should feel deliberate and polished, never random or chaotic. Every movement has purpose and precision, reflecting the professional nature of the ZinApp brand.

### 2. Responsive & Alive
Elements respond immediately to user interaction, creating a sense of liveliness and responsiveness. The interface feels dynamic and engaging, not static.

### 3. Subtle Sophistication
Animations enhance without overwhelming. Like a premium product, our animations "whisper" rather than "shout," using restraint to convey quality and refinement.

### 4. Cohesive System
All animations belong to the same family, creating a unified experience. Consistency in timing, easing, and behavior reinforces the design system.

### 5. Meaningful Movement
Every animation serves a purpose: guiding attention, providing feedback, establishing hierarchy, or creating continuity between states.

## Signature Motion Patterns

### ZinPulse
A subtle, rhythmic pulsing effect used for emphasis or to draw attention to important elements.

```dart
// Implementation
TweenSequence<double>(
  AppAnimations.getZinPulseSequence(),
).animate(_animationController);
```

### ZinRise
A smooth, confident upward motion that suggests progress, elevation, and positive action.

```dart
// Implementation
TweenSequence<double>(
  AppAnimations.getZinRiseSequence(),
).animate(_animationController);
```

### ZinPress
A premium-feeling press animation that provides tactile feedback for interactive elements.

```dart
// Implementation
TweenSequence<double>(
  AppAnimations.getZinPressSequence(),
).animate(_animationController);
```

## Standard Durations

| Type | Duration | Use Case |
|------|----------|----------|
| Extra Fast | 100ms | Micro-interactions, immediate feedback |
| Fast | 150ms | Button presses, hover states |
| Medium | 300ms | Page transitions, complex animations |
| Slow | 500ms | Emphasis animations, reveals |
| Extra Slow | 800ms | Onboarding, splash screen |

## Standard Curves

| Curve | Use Case |
|-------|----------|
| `Curves.easeInOut` | Default for most animations |
| `Curves.easeOut` | Entrances, appearing elements |
| `Curves.easeOutCubic` | Hover effects, smooth transitions |
| `Curves.fastOutSlowIn` | Screen transitions |
| `Curves.easeOutQuint` | Premium-feeling interactions |
| `Curves.elasticOut` | Playful, bouncy animations (use sparingly) |

## Component-Specific Guidelines

### Buttons

Buttons use a combination of scale and elevation changes to create a tactile, responsive feel:

1. **Hover State**:
   - Subtle elevation increase
   - Optional slight upward movement
   - Fast duration (100-150ms)
   - Easing: `Curves.easeOutCubic`

2. **Press State**:
   - Scale down to 97%
   - Quick press (150ms) with slightly longer release (200ms)
   - Easing: `Curves.easeOutQuint` for a premium feel

### Cards

Cards respond to interaction with subtle scale and elevation changes:

1. **Hover State**:
   - Scale up to 102%
   - Elevation increase
   - Medium duration (150-200ms)
   - Easing: `Curves.easeOutCubic`

2. **Press State**:
   - Scale down slightly from hovered state
   - Fast duration (150ms)
   - Easing: `Curves.easeOutQuint`

### Page Transitions

Page transitions maintain context and create a sense of spatial relationship:

1. **Forward Navigation**:
   - Current page fades out while sliding slightly left/down
   - New page fades in while sliding from right/up
   - Medium duration (300ms)
   - Easing: `Curves.fastOutSlowIn`

2. **Backward Navigation**:
   - Reverse of forward animation
   - Slightly faster duration (250ms)

## Implementation Guidelines

### 1. Use the Animation Constants

Always use the predefined animation constants from `AppAnimations` to maintain consistency:

```dart
duration: AppAnimations.buttonPressDuration,
curve: AppAnimations.buttonPressCurve,
```

### 2. Combine Simple Animations

Create complex animations by combining simple ones:

```dart
// Scale + Elevation + Movement
Transform.translate(
  offset: _moveAnimation.value,
  child: Transform.scale(
    scale: _scaleAnimation.value,
    child: DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0 + _elevationAnimation.value,
          ),
        ],
      ),
      child: child,
    ),
  ),
);
```

### 3. Use Staggered Animations for Complex Sequences

For complex sequences, use staggered animations with different intervals:

```dart
_fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Interval(0.0, 0.6, curve: Curves.easeOut),
  ),
);

_slideAnimation = Tween<Offset>(begin: Offset(0, 20), end: Offset.zero).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Interval(0.2, 0.7, curve: Curves.easeOutCubic),
  ),
);
```

### 4. Consider Performance

- Use `RepaintBoundary` for complex animations
- Avoid animating layout properties (prefer transform)
- Test on lower-end devices

### 5. Respect User Preferences

Honor system-level reduced motion settings:

```dart
final bool reducedMotion = MediaQuery.of(context).disableAnimations;
final Duration effectiveDuration = reducedMotion 
    ? Duration.zero 
    : AppAnimations.medium;
```

## Examples

### Animated Button

```dart
class AnimatedButton extends StatefulWidget {
  // ...
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.buttonPressDuration,
    );
    _scaleAnimation = TweenSequence<double>(
      AppAnimations.getZinPressSequence(),
    ).animate(_controller);
  }
  
  // ...
}
```

### Animated Card

```dart
class AnimatedCard extends StatefulWidget {
  // ...
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.cardHoverDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.cardHoverCurve,
      ),
    );
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.cardHoverCurve,
      ),
    );
  }
  
  // ...
}
```
