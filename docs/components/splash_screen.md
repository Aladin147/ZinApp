# Splash Screen Component

The `ZinSplashScreen` component provides a polished introduction to the ZinApp experience. It displays the app logo with smooth animations and optional call-to-action buttons.

## Usage

```dart
ZinSplashScreen(
  duration: const Duration(seconds: 2),
  onComplete: () => context.go('/home'),
  showGetStartedButton: true,
  onGetStarted: () => context.go('/onboarding'),
)
```

## Props

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `duration` | `Duration` | `Duration(seconds: 2)` | Time to show splash before auto-navigating |
| `onComplete` | `VoidCallback?` | `null` | Callback when splash animation completes |
| `showGetStartedButton` | `bool` | `false` | Whether to show a "Get Started" button |
| `onGetStarted` | `VoidCallback?` | `null` | Callback when "Get Started" button is pressed |

## Variants

### Standard Splash (Auto-Navigate)
Used during app startup to display branding while the app loads.

```dart
ZinSplashScreen(
  duration: const Duration(seconds: 2),
  onComplete: () => context.go('/home'),
)
```

### Landing Page with CTA
Used as a landing page with a call-to-action button.

```dart
ZinSplashScreen(
  showGetStartedButton: true,
  onGetStarted: () => context.go('/onboarding'),
)
```

## Animation Details

The splash screen uses a combination of animations for a polished experience:

1. **Fade-In Animation**
   - Fades in the logo and text from 0.0 to 1.0 opacity
   - Duration: 800ms
   - Curve: `Curves.easeOut`

2. **Scale Animation**
   - Scales the logo from 0.8 to 1.0
   - Duration: 800ms
   - Curve: `Curves.easeOut`

3. **Button Animation**
   - Fades in the button after the logo animation
   - Uses the same animation controller as the logo

## Implementation Notes

- The splash screen uses the `ZinLogo` component with the `animated` property set to true
- The animation controller is automatically disposed when the widget is removed from the tree
- For auto-navigation, the `onComplete` callback is called after the specified `duration`
- When `showGetStartedButton` is true, auto-navigation is disabled

## Accessibility Considerations

- The splash screen respects system-level animation settings
- All text meets contrast requirements for readability
- The "Get Started" button is fully accessible with proper semantics

## Future Enhancements

- Add support for background patterns or gradients
- Implement more complex logo animations
- Add support for custom taglines
- Implement a loading indicator for actual loading states
