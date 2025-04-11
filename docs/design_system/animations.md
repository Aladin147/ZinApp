# Animation Guidelines for ZinApp V2

## Animation Principles

### 1. Purposeful
- Animations should serve a purpose (guide attention, provide feedback, etc.)
- Avoid animations that distract from the core experience

### 2. Subtle
- Animations should be subtle and not overwhelming
- Use minimal movement to achieve the desired effect

### 3. Consistent
- Maintain consistent timing and easing across similar animations
- Use the same animation patterns for similar interactions

### 4. Performant
- Optimize animations for performance
- Avoid complex animations on low-end devices

## Standard Durations

| Type | Duration | Use Case |
|------|----------|----------|
| Extra Fast | 100-150ms | Micro-interactions, button presses |
| Fast | 200-300ms | Page transitions, simple animations |
| Medium | 300-500ms | Complex transitions, emphasis animations |
| Slow | 500-800ms | Onboarding, splash screen, attention-grabbing |

## Standard Curves

| Curve | Use Case |
|-------|----------|
| `Curves.easeInOut` | Default for most animations |
| `Curves.easeOut` | Entrances, appearing elements |
| `Curves.easeIn` | Exits, disappearing elements |
| `Curves.fastOutSlowIn` | Emphasis animations |
| `Curves.elasticOut` | Playful, bouncy animations (use sparingly) |

## Animation Types

### 1. Fade Animations
- Use for appearing/disappearing elements
- Standard duration: Fast (200-300ms)
- Standard curve: `Curves.easeInOut`

```dart
// Example implementation
FadeTransition(
  opacity: _fadeAnimation, // Tween<double>(begin: 0.0, end: 1.0)
  child: myWidget,
)
```

### 2. Scale Animations
- Use for emphasis or to draw attention
- Standard duration: Fast (200-300ms)
- Standard curve: `Curves.easeOut`

```dart
// Example implementation
ScaleTransition(
  scale: _scaleAnimation, // Tween<double>(begin: 0.8, end: 1.0)
  child: myWidget,
)
```

### 3. Slide Animations
- Use for page transitions or list items
- Standard duration: Medium (300-500ms)
- Standard curve: `Curves.fastOutSlowIn`

```dart
// Example implementation
SlideTransition(
  position: _slideAnimation, // Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
  child: myWidget,
)
```

### 4. Combined Animations
- Use for more complex or attention-grabbing animations
- Standard duration: Medium to Slow (300-800ms)
- Combine multiple animations with staggered timing

```dart
// Example implementation
FadeTransition(
  opacity: _fadeAnimation,
  child: SlideTransition(
    position: _slideAnimation,
    child: myWidget,
  ),
)
```

## Splash Screen Animation Guidelines

### Purpose
- Create a welcoming and engaging first impression
- Establish brand identity
- Provide visual feedback during app loading

### Implementation
- Use a combination of fade and scale animations
- Start with a slightly smaller scale (0.8-0.9) and animate to full size
- Use a slow fade-in for a smooth appearance
- Consider a subtle pulse or bounce at the end for added polish

### Timing
- Initial animation: 800-1200ms
- Optional pulse/bounce: 300-500ms
- Total duration should align with actual loading time when possible

## Interactive Element Animation Guidelines

### Buttons
- Use scale down (0.95-0.98) on press
- Add subtle elevation change
- Duration: Extra Fast (100-150ms)

### Cards
- Use slight scale up (1.01-1.03) on hover/focus
- Add subtle elevation increase
- Duration: Fast (200-300ms)

### Lists
- Use staggered animations for list items
- Delay each item by 20-50ms
- Duration per item: Fast (200-300ms)

## Performance Considerations

1. **Avoid Animating Layout Properties**
   - Prefer animating opacity, transform, and decoration
   - Avoid animating width, height, or padding

2. **Use RepaintBoundary**
   - Wrap complex animated widgets in RepaintBoundary
   - Helps isolate repainting to specific areas

3. **Test on Low-End Devices**
   - Ensure animations run smoothly on target devices
   - Scale back complexity if performance issues arise

4. **Use Hero Animations Sparingly**
   - Reserve for key transitions between screens
   - Avoid using for many elements simultaneously

## Accessibility Considerations

1. **Respect User Preferences**
   - Honor system-level reduced motion settings
   - Provide simplified animations for users who prefer reduced motion

2. **Avoid Rapid Flashing**
   - Ensure animations don't flash more than 3 times per second
   - Avoid stark contrast changes in rapid succession

3. **Provide Sufficient Duration**
   - Ensure important animations last long enough to be perceived
   - Critical information should not be conveyed only through animation
