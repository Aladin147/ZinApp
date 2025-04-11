# ZinApp Page Transitions

## Overview

Page transitions in ZinApp are designed to create a premium, branded navigation experience that reinforces the app's identity. The transitions are smooth, consistent, and provide spatial context to help users understand the navigation flow.

## Transition Types

### Standard Page Transition

The standard page transition combines multiple animation effects:

1. **Fade**: Pages fade in/out for a smooth appearance
2. **Slide**: Pages slide horizontally to indicate navigation direction
3. **Scale**: A subtle scale effect adds depth and dimension
4. **Background Pattern**: Brand-reinforcing patterns appear during transitions

### Transition Direction

- **Forward Navigation**: New pages slide in from the right with a slight scale effect
- **Backward Navigation**: Pages slide out to the right with a reverse scale effect

## Implementation

### Using ZinNavigation Helper

The `ZinNavigation` class provides helper methods for navigating with ZinApp transitions:

```dart
// Navigate to a new screen
ZinNavigation.push(
  context,
  MyNewScreen(),
  backgroundPattern: ZinBackgroundPattern.minimal,
);

// Replace the current screen
ZinNavigation.replace(
  context,
  MyNewScreen(),
  backgroundPattern: ZinBackgroundPattern.featured,
);

// Pop all routes and push a new one
ZinNavigation.pushAndRemoveUntil(
  context,
  MyNewScreen(),
  backgroundPattern: ZinBackgroundPattern.subtle,
);
```

### Using GoRouter

For GoRouter integration, use the `createGoRouterPage` method:

```dart
GoRoute(
  path: '/my-path',
  name: 'my-route',
  pageBuilder: (context, state) {
    return ZinNavigation.createGoRouterPage(
      child: MyScreen(),
      name: 'my-route',
      backgroundPattern: ZinBackgroundPattern.minimal,
    );
  },
),
```

### Using ZinRoute Directly

For more control, you can use `ZinRoute` directly:

```dart
Navigator.of(context).push(
  ZinRoute(
    builder: (context) => MyNewScreen(),
    backgroundPattern: ZinBackgroundPattern.featured,
  ),
);
```

## Background Patterns

Different background patterns can be used to reinforce the brand identity during transitions:

- **Minimal**: Subtle pattern for general navigation
- **Subtle**: Slightly more visible pattern for secondary screens
- **Featured**: More prominent pattern for important screens
- **Special**: Distinctive pattern for celebratory or achievement screens

## Animation Parameters

- **Duration**: 300ms (standard), 250ms (back navigation)
- **Curve**: `Curves.fastOutSlowIn` for natural, premium feel
- **Fade Range**: 0.0 to 1.0
- **Slide Range**: 0.25 screen width
- **Scale Range**: 0.92 to 1.0

## Accessibility

- Transitions respect the user's reduced motion settings
- Duration is kept reasonable to avoid motion sickness
- Essential UI elements remain visible during transitions

## Examples

### Basic Navigation

```dart
// Navigate to details screen
void openDetails() {
  ZinNavigation.push(
    context,
    DetailsScreen(item: item),
    backgroundPattern: ZinBackgroundPattern.subtle,
  );
}

// Return to previous screen
void goBack() {
  Navigator.of(context).pop();
}
```

### Complex Navigation

```dart
// Complete a flow and navigate to a success screen
void completeBooking() {
  ZinNavigation.pushAndRemoveUntil(
    context,
    SuccessScreen(booking: booking),
    backgroundPattern: ZinBackgroundPattern.special,
    predicate: (route) => route.settings.name == 'home',
  );
}
```

## Best Practices

1. Use consistent transition patterns for similar navigation actions
2. Choose background patterns that match the importance of the destination
3. Keep transitions smooth and not overly flashy
4. Ensure transitions provide spatial context (where am I going/coming from)
5. Test transitions on different devices to ensure performance
