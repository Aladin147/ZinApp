# ZinApp Accessibility Guidelines

## Overview

Accessibility is a core principle of the ZinApp design system. These guidelines ensure that all users, regardless of abilities, can effectively use and enjoy our application. By following these guidelines, we maintain both our distinctive brand identity and proper accessibility.

## Color Contrast Requirements

### WCAG Standards

ZinApp follows the Web Content Accessibility Guidelines (WCAG) 2.1 AA standards:

- **Normal Text**: Contrast ratio of at least 4.5:1
- **Large Text** (18pt+ or 14pt+ bold): Contrast ratio of at least 3:1
- **UI Components and Graphics**: Contrast ratio of at least 3:1

### Color Zone System

To maintain both our brand identity and accessibility, we've implemented a Color Zone System:

1. **Interactive Zone**: Dark backgrounds with neon accents
   - Dark backgrounds ensure high contrast with light text
   - Neon green is only used for interactive elements, not for text

2. **Content Zone**: Cream backgrounds with dark text
   - Cream backgrounds are paired with dark text for high readability
   - NO neon green elements directly on cream backgrounds
   - Use darker green variants (primaryHighlightDarker) when needed

3. **Accent Zone**: Colored backgrounds for special sections
   - Use darker variants of accent colors for text and interactive elements
   - Ensure proper contrast with background

4. **Brand Zone**: High-impact brand presence
   - Can combine neon and cream with proper separation
   - Maintain clear visual boundaries between color zones

## Implementation Tools

### AccessibilityUtils

The `AccessibilityUtils` class provides methods to enforce accessibility rules:

```dart
// Get appropriate text color for a background
final textColor = AccessibilityUtils.getTextColorForBackground(backgroundColor);

// Get appropriate action color for a background
final actionColor = AccessibilityUtils.getActionColorForBackground(backgroundColor);

// Ensure a color has proper contrast with a background
final accessibleColor = AccessibilityUtils.ensureContrastWithBackground(
  color, 
  backgroundColor,
  isLargeText: false,
);

// Check if a color combination meets contrast requirements
final isAccessible = AccessibilityUtils.hasAdequateContrastForNormalText(
  foreground, 
  background,
);
```

### Accessibility-Aware Components

Use these components to automatically ensure proper contrast:

```dart
// Text with guaranteed contrast
AccessibilityAwareText(
  text: 'This text will have proper contrast',
  backgroundColor: backgroundColor,
  isSecondaryText: false,
)

// Button with appropriate colors for the background
AccessibilityAwareButton(
  label: 'Accessible Button',
  backgroundColor: backgroundColor,
  onPressed: () {},
  variant: ButtonVariant.primary,
)

// Card that enforces proper contrast for content
AccessibilityAwareCard(
  backgroundColor: cardColor,
  child: yourContent,
)
```

## Cream Background Guidelines

The cream background (`#F8F3ED`) is a distinctive part of our brand identity but requires special attention for accessibility:

### DO:
- Use dark text colors on cream backgrounds
- Use darker variants of our brand colors (primaryHighlightDarker, coolBlueDark)
- Maintain clear separation between cream backgrounds and neon elements
- Use the Content Zone color palette for cream backgrounds

### DON'T:
- Place neon green (`#D2FF4D`) directly on cream backgrounds
- Use light text colors on cream backgrounds
- Mix color zone rules within a single component

## Testing Accessibility

### Automated Testing

Use the `AccessibilityUtils` class to check contrast programmatically:

```dart
// Check if text meets contrast requirements
if (!AccessibilityUtils.hasAdequateContrastForNormalText(textColor, backgroundColor)) {
  print('Warning: Text does not meet contrast requirements');
}
```

### Manual Testing

1. **Grayscale Test**: View the app in grayscale to check for reliance on color
2. **Squint Test**: Squint while looking at the interface to check for readability
3. **Zoom Test**: Test the app at different zoom levels
4. **Screen Reader Test**: Test with screen readers to ensure proper navigation

## Examples

### Proper Use of Cream Backgrounds

```dart
// Content Zone (Cream Background)
Container(
  color: ColorZones.contentZone.background,
  child: Column(
    children: [
      // Use dark text for high contrast
      Text(
        'Article Title',
        style: TextStyle(color: ColorZones.contentZone.textPrimary),
      ),
      // Use darker green variant for actions
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorZones.contentZone.action, // primaryHighlightDarker
        ),
        onPressed: () {},
        child: Text('Read More'),
      ),
    ],
  ),
)
```

### Proper Separation of Neon and Cream

```dart
Scaffold(
  // Interactive Zone (Dark Background)
  appBar: AppBar(
    backgroundColor: ColorZones.interactiveZone.background,
    title: Text('ZinApp'),
    actions: [
      // Neon is fine on dark backgrounds
      IconButton(
        icon: Icon(Icons.add, color: ColorZones.interactiveZone.action),
        onPressed: () {},
      ),
    ],
  ),
  // Content Zone (Cream Background)
  body: Container(
    color: ColorZones.contentZone.background,
    child: ListView(
      children: [
        // Dark text on cream background
        Text(
          'Content Title',
          style: TextStyle(color: ColorZones.contentZone.textPrimary),
        ),
        // Dark green variant on cream background
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorZones.contentZone.action,
          ),
          onPressed: () {},
          child: Text('Action'),
        ),
      ],
    ),
  ),
)
```

## Conclusion

By following these guidelines and using the provided tools, we can maintain ZinApp's distinctive visual identity while ensuring accessibility for all users. The Color Zone System allows us to use our brand colors effectively while meeting contrast requirements.

Remember: Accessibility is not a feature; it's a quality requirement. Every component and screen should be accessible to all users.
