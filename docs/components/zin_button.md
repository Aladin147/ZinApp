# ZinButton Component

## Overview

ZinButton is a customizable button component that follows the ZinApp V2 design system. It provides consistent styling and behavior for all interactive buttons in the application.

## Visual Reference

[Include screenshot/reference to design mockup]

## Features

- Multiple variants: primary, secondary, text
- Consistent styling with the design system
- Loading state support
- Disabled state support
- Icon support (leading and trailing)
- Responsive sizing
- Accessibility compliance

## Usage

```dart
// Primary Button (Default)
ZinButton(
  label: 'Get Started',
  onPressed: () => navigateToOnboarding(),
);

// Secondary Button
ZinButton.secondary(
  label: 'Learn More',
  onPressed: () => showInfoDialog(),
);

// Text Button
ZinButton.text(
  label: 'Skip',
  onPressed: () => skipTutorial(),
);

// With Icon
ZinButton(
  label: 'Share',
  icon: Icons.share,
  onPressed: () => shareContent(),
);

// Loading State
ZinButton(
  label: 'Save',
  isLoading: isSaving,
  onPressed: isSaving ? null : () => saveChanges(),
);

// Disabled State
ZinButton(
  label: 'Submit',
  onPressed: isValid ? () => submitForm() : null,
);

// Full Width
ZinButton(
  label: 'Continue',
  isFullWidth: true,
  onPressed: () => continueToNextStep(),
);
```

## Props/Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | The text displayed on the button |
| `onPressed` | `VoidCallback?` | Required | Callback when button is pressed. Set to `null` to disable the button |
| `variant` | `ZinButtonVariant` | `ZinButtonVariant.primary` | Button style variant (primary, secondary, text) |
| `size` | `ZinButtonSize` | `ZinButtonSize.medium` | Button size (small, medium, large) |
| `icon` | `IconData?` | `null` | Optional icon to display alongside text |
| `iconPosition` | `IconPosition` | `IconPosition.leading` | Position of the icon (leading or trailing) |
| `isLoading` | `bool` | `false` | Whether to show a loading indicator |
| `isFullWidth` | `bool` | `false` | Whether the button should take full width |
| `borderRadius` | `BorderRadius?` | `null` | Custom border radius (defaults to theme value) |
| `padding` | `EdgeInsetsGeometry?` | `null` | Custom padding (defaults to theme value) |

## Variants

### Primary Button

The primary button is used for main call-to-action elements. It has high visual prominence and should be used sparingly.

- Background: `primaryHighlight` (#D2FF4D)
- Text: `textOnHighlight` (#232D30)
- Elevation: 2dp

### Secondary Button

The secondary button is used for secondary actions. It has medium visual prominence.

- Background: Transparent
- Border: `primaryHighlight` (#D2FF4D)
- Text: `primaryHighlight` (#D2FF4D)
- Elevation: 0dp

### Text Button

The text button is used for tertiary actions. It has low visual prominence.

- Background: Transparent
- Text: `primaryHighlight` (#D2FF4D)
- Elevation: 0dp

## Sizes

| Size | Height | Padding | Text Style | Use Case |
|------|--------|---------|------------|----------|
| Small | 36dp | 12dp horizontal, 8dp vertical | buttonSmall | Compact UIs, inline actions |
| Medium | 48dp | 16dp horizontal, 12dp vertical | buttonMedium | Standard actions |
| Large | 56dp | 24dp horizontal, 16dp vertical | buttonLarge | Primary CTAs, prominent actions |

## States

### Normal

Default appearance of the button.

### Pressed/Hover

Visual feedback when the user interacts with the button:
- Primary: Slight darkening of background color
- Secondary: Slight darkening of border and text color
- Text: Slight darkening of text color

### Loading

Shows a circular progress indicator:
- Text is replaced with a loading spinner
- Button remains at the same size
- Button is non-interactive while loading

### Disabled

Indicates that the button is not interactive:
- Reduced opacity (70%)
- No elevation
- Cursor changes to not-allowed

## Accessibility

- Minimum touch target size of 48x48dp
- Sufficient color contrast (WCAG AA compliant)
- Proper semantics for screen readers
- Keyboard focus indicators

## Implementation Details

The ZinButton component is implemented using Flutter's `ElevatedButton`, `OutlinedButton`, and `TextButton` widgets with custom styling applied through the theme system.

Key implementation features:
- Uses Material Design 3 button components as a foundation
- Applies custom styling through ButtonStyle
- Handles loading state with AnimatedSwitcher for smooth transitions
- Manages disabled state through the onPressed parameter
- Implements responsive sizing based on the variant and size props

## Edge Cases and Limitations

- Very long text labels may be truncated with ellipsis
- When using `isFullWidth: true`, be mindful of extremely wide screens
- Icons are sized proportionally to the button size
- Loading spinner replaces text but maintains button width to prevent layout shifts

## Usage Guidelines

### Do's

- Use primary buttons sparingly (typically one per screen)
- Use consistent button variants for similar actions
- Place primary actions on the right in button groups
- Use clear, concise action verbs for button labels
- Ensure sufficient spacing between adjacent buttons

### Don'ts

- Don't use too many primary buttons on a single screen
- Avoid using buttons for navigation when links would be more appropriate
- Don't use inconsistent capitalization in button labels
- Avoid excessive use of icons in buttons
- Don't place buttons too close to other interactive elements
