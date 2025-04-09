# ZinApp Spacing System

## 📏 Purpose

This document outlines the spacing system used in ZinApp to ensure consistent spacing across the application. The spacing system is based on a 4pt grid, which means all spacing values are multiples of 4.

## 🧮 Base Unit

The base unit for our spacing system is 4 pixels (4pt). All spacing values in the application should be multiples of this base unit to maintain visual consistency.

```typescript
const BASE_UNIT = 4;
```

## 📊 Spacing Scale

The spacing scale provides a set of predefined spacing values that should be used throughout the application:

| Token    | Value       | Use Case                       |
|----------|-------------|--------------------------------|
| `xxs`    | `4px`       | Minimum spacing, tight layouts |
| `xs`     | `8px`       | Compact spacing               |
| `sm`     | `12px`      | Small spacing                 |
| `md`     | `16px`      | Standard spacing              |
| `lg`     | `24px`      | Large spacing                 |
| `xl`     | `32px`      | Extra large spacing           |
| `xxl`    | `48px`      | Maximum spacing               |

## 🧩 Component-Specific Spacing

### Cards
- **Outer Margin**: 16px (md)
- **Inner Padding**: 8px (xs) to 16px (md)

### Buttons
- **Horizontal Padding**: 16px (md)
- **Vertical Padding**: 12px (sm)
- **Gap Between Buttons**: 8px (xs)

### Typography
- **Paragraph Margin**: 16px (md) bottom
- **Heading Margin**: 24px (lg) bottom, 8px (xs) top
- **List Item Spacing**: 8px (xs)

### Screens
- **Screen Padding**: 16px (md) horizontal
- **Section Spacing**: 24px (lg)
- **Content Block Spacing**: 16px (md)

## 🛠️ Spacing Utilities

ZinApp provides utility functions to help apply consistent spacing throughout the application:

```typescript
// Get spacing value
getSpacing('md'); // Returns 16

// Get spacing with multiplier
getSpacing('md', 2); // Returns 32

// Get spacing object for all directions
getSpacingObject(16); // Returns { top: 16, right: 16, bottom: 16, left: 16 }

// Get spacing object for horizontal and vertical
getSpacingObjectHV(16, 8); // Returns { top: 8, right: 16, bottom: 8, left: 16 }

// Get spacing object for individual directions
getSpacingObjectTRBL(8, 16, 24, 16); // Returns { top: 8, right: 16, bottom: 24, left: 16 }
```

## 🎯 Best Practices

1. **Always use the spacing scale** - Avoid using arbitrary values that don't align with the spacing scale.
2. **Use the spacing utilities** - Use the provided utility functions to apply spacing consistently.
3. **Maintain vertical rhythm** - Use consistent spacing between elements to create a visual rhythm.
4. **Consider content density** - Use smaller spacing for dense content and larger spacing for sparse content.
5. **Be consistent** - Use the same spacing values for similar components and layouts.

## 📱 Responsive Spacing

For responsive layouts, consider using different spacing values based on screen size:

- **Small screens**: Use smaller spacing values (xxs, xs, sm)
- **Medium screens**: Use standard spacing values (md, lg)
- **Large screens**: Use larger spacing values (lg, xl, xxl)

## 🔄 Implementation

The spacing system is implemented in the following files:

- `constants/spacing.ts` - Defines the spacing scale
- `utils/spacing.ts` - Provides utility functions for applying spacing
- `theme/index.ts` - Exports the spacing scale for use in the application

Always import spacing from these files rather than hardcoding values in your components.
