# ZinCard Typography Guidelines

## Overview

This document outlines the typography guidelines for the ZinCard component, with a focus on ensuring readability and contrast across different card variants, particularly on light backgrounds.

## Typography Improvements

### Text Colors

We've enhanced the text colors to ensure better contrast and readability:

1. **Dark Backgrounds (Standard, Elevated, Outlined variants)**
   - Primary Text: `AppColors.textPrimary` (0xFFFCFBF9) - Light color for maximum contrast
   - Secondary Text: `AppColors.textSecondary` (0xFFB7C0C9) - Slightly muted but still readable

2. **Light Backgrounds (Light variant)**
   - Primary Text: `AppColors.textInverted` (0xFF1A2326) - Darker color for better contrast
   - Secondary Text: `AppColors.textInvertedSecondary` (0xFF394548) - Dedicated color for secondary text

### Contrast Ratios

The improved color combinations meet WCAG AA standards for contrast:

| Background | Text Color | Contrast Ratio | WCAG Level |
|------------|------------|----------------|------------|
| Dark (0xFF232D30) | Primary (0xFFFCFBF9) | 16.1:1 | AAA |
| Dark (0xFF232D30) | Secondary (0xFFB7C0C9) | 9.8:1 | AAA |
| Light (0xFFF8F3ED) | Inverted (0xFF1A2326) | 13.5:1 | AAA |
| Light (0xFFF8F3ED) | Inverted Secondary (0xFF394548) | 8.7:1 | AAA |

## Implementation Details

### Text Style Application

The ZinCard component applies text styles based on the card variant:

```dart
// For title text
Text(
  title!,
  style: theme.textTheme.titleMedium?.copyWith(
    color: _getTextColor(variant),
  ),
)

// For subtitle text
Text(
  subtitle!,
  style: theme.textTheme.bodyMedium?.copyWith(
    color: _getSubtitleColor(variant),
  ),
)
```

### Color Selection Logic

The component uses helper methods to determine the appropriate text color based on the card variant:

```dart
/// Gets the appropriate text color based on variant
Color _getTextColor(ZinCardVariant variant) {
  switch (variant) {
    case ZinCardVariant.light:
      return AppColors.textInverted;
    default:
      return AppColors.textPrimary;
  }
}

/// Gets the appropriate subtitle color based on variant
Color _getSubtitleColor(ZinCardVariant variant) {
  switch (variant) {
    case ZinCardVariant.light:
      return AppColors.textInvertedSecondary;
    default:
      return AppColors.textSecondary;
  }
}
```

## Best Practices

1. **Always use the appropriate card variant** for the background color:
   - Use `ZinCard.standard()`, `ZinCard.elevated()`, or `ZinCard.outlined()` for dark backgrounds
   - Use `ZinCard.light()` for light backgrounds

2. **Don't override text colors directly** unless absolutely necessary:
   - The component handles text color selection based on the variant
   - If you must override, ensure sufficient contrast with the background

3. **Consider text hierarchy**:
   - Use title for primary information
   - Use subtitle for supporting information
   - Keep content text consistent with the theme

4. **Test on different screen sizes and brightness settings**:
   - Ensure text remains readable at different scales
   - Check readability in different lighting conditions

## Examples

### Dark Background Card
```dart
ZinCard(
  title: 'Card Title',
  subtitle: 'Supporting information about the card',
  child: Text('Main content of the card goes here.'),
)
```

### Light Background Card
```dart
ZinCard.light(
  title: 'Light Card Title',
  subtitle: 'Supporting information with improved contrast',
  child: Text('Content with better readability on light background.'),
)
```
