# ZinApp V2 Style Token Implementation

This document explains the structure, ranges, categories, usage hierarchy, and mapping of design tokens in ZinApp V2 to help your UI/UX coder apply them intelligently.

## Token System Overview

ZinApp V2 uses a comprehensive token system to ensure consistent styling across the application. Tokens are organized into a hierarchical structure that promotes reusability, maintainability, and scalability.

## Token Categories

### 1. Color Tokens

#### Base Colors
These are the raw color values that serve as the foundation of our color system.

```typescript
export const baseColors = {
  // Primary brand colors
  lime: {
    50: '#F7FFDE',
    100: '#EEFFBD',
    200: '#E2FF9B',
    300: '#D2FF4D', // Primary highlight
    400: '#C1F01F',
    500: '#A3D00F',
    600: '#82A80C',
  },
  
  // Dark neutrals
  slate: {
    50: '#E9ECEE',
    100: '#D3D9DD',
    200: '#B7C0C9',
    300: '#9AA6B3',
    400: '#7A848C',
    500: '#5A646C',
    600: '#3A444C',
    700: '#232D30', // Official background
    800: '#1A2226',
    900: '#111618',
  },
  
  // Light neutrals
  sand: {
    50: '#FCFBF9',
    100: '#F8F3ED',
    200: '#F2EAE0',
    300: '#E8DFD2',
    400: '#D9CFC0',
    500: '#C5B9A8',
    600: '#B0A390',
  },
  
  // Accent colors
  coral: {
    300: '#F4805D',
    400: '#E56A45',
    500: '#D25430',
  },
  
  coolBlue: {
    300: '#8CBACD',
    400: '#6AA3BA',
    500: '#4A8CA6',
  },
  
  jade: {
    200: '#C3FFC2',
    300: '#9EEEA0',
    400: '#7AD97F',
  },
  
  // Semantic colors
  success: '#4CAF50',
  warning: '#FFC107',
  error: '#F44336',
  info: '#2196F3',
}
```

#### Semantic Color Tokens
These tokens map the base colors to specific use cases in the application.

```typescript
export const colors = {
  // Brand colors
  primary: baseColors.lime[300], // #D2FF4D
  background: baseColors.slate[700], // #232D30
  
  // Neutral canvas colors
  neutral: {
    canvasLight: baseColors.sand[100], // #F8F3ED
    canvasDark: baseColors.slate[700], // #232D30
  },
  
  // Accent colors
  accent: {
    coolBlue: baseColors.coolBlue[300], // #8CBACD
    coral: baseColors.coral[300], // #F4805D
    jadeLight: baseColors.jade[200], // #C3FFC2
  },
  
  // Text colors
  text: {
    primary: baseColors.sand[50], // #FCFBF9
    secondary: baseColors.slate[200], // #B7C0C9
    inverted: baseColors.slate[700], // #232D30
    onHighlight: baseColors.slate[700], // #232D30
    disabled: baseColors.slate[400], // #7A848C
    link: baseColors.coolBlue[300], // #8CBACD
    token: baseColors.lime[300], // #D2FF4D
  },
  
  // Status colors
  status: {
    success: baseColors.success,
    warning: baseColors.warning,
    error: baseColors.error,
    info: baseColors.info,
  },
  
  // Gradient colors
  gradient: {
    primaryStart: baseColors.lime[200], // #E2FF9B
    primaryEnd: baseColors.lime[300], // #D2FF4D
    darkStart: baseColors.slate[600], // #3A444C
    darkEnd: baseColors.slate[700], // #232D30
  },
}
```

### 2. Spacing Tokens

Spacing tokens define the whitespace system used throughout the application.

```typescript
export const spacing = {
  // Base spacing unit: 4px
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
  xxxl: 64,
  
  // Component-specific spacing
  buttonPadding: {
    small: {
      vertical: 8,
      horizontal: 12,
    },
    medium: {
      vertical: 12,
      horizontal: 16,
    },
    large: {
      vertical: 16,
      horizontal: 24,
    },
  },
  
  cardPadding: 16,
  inputPadding: 12,
  listItemPadding: 16,
  sectionSpacing: 24,
  screenPadding: {
    horizontal: 16,
    vertical: 24,
  },
}
```

### 3. Typography Tokens

Typography tokens define the text styles used throughout the application.

```typescript
export const typography = {
  // Font family
  fontFamily: 'Urbanist', // Alternatives: 'Nunito', 'Inter'
  
  // Font weights
  fontWeights: {
    regular: '400',
    medium: '500',
    bold: '700',
  },
  
  // Font sizes
  sizes: {
    headingLarge: 28,
    headingMedium: 24,
    headingSmall: 20,
    bodyLarge: 18,
    body: 16,
    bodySmall: 14,
    caption: 13,
  },
  
  // Line heights
  lineHeights: {
    heading: 1.3,
    body: 1.5,
    button: 1.2,
  },
  
  // Letter spacing
  letterSpacing: {
    tight: -0.5,
    normal: 0,
    wide: 0.5,
  },
}
```

### 4. Border Radius Tokens

Border radius tokens define the corner rounding used throughout the application.

```typescript
export const borderRadius = {
  small: 8,
  medium: 12,
  large: 16,
  extraLarge: 24,
  round: 9999,
  
  // Component-specific border radius
  button: 12,
  card: 16,
  input: 12,
  chip: 8,
  avatar: 9999,
}
```

### 5. Elevation Tokens

Elevation tokens define the shadow styles used to create depth in the application.

```typescript
export const elevation = {
  level0: {
    shadowColor: 'transparent',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0,
    shadowRadius: 0,
    elevation: 0,
  },
  level1: {
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 1,
    shadowRadius: 4,
    elevation: 2,
  },
  level2: {
    shadowColor: 'rgba(0,0,0,0.15)',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 1,
    shadowRadius: 8,
    elevation: 4,
  },
  level3: {
    shadowColor: 'rgba(0,0,0,0.2)',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 1,
    shadowRadius: 16,
    elevation: 8,
  },
  level4: {
    shadowColor: 'rgba(0,0,0,0.25)',
    shadowOffset: { width: 0, height: 12 },
    shadowOpacity: 1,
    shadowRadius: 24,
    elevation: 12,
  },
}
```

### 6. Animation Tokens

Animation tokens define the timing and easing functions used for animations.

```typescript
export const animation = {
  duration: {
    micro: 100,
    small: 200,
    medium: 300,
    large: 500,
    extraLarge: 800,
  },
  
  easing: {
    standard: 'cubic-bezier(0.4, 0.0, 0.2, 1)',
    accelerate: 'cubic-bezier(0.4, 0.0, 1, 1)',
    decelerate: 'cubic-bezier(0.0, 0.0, 0.2, 1)',
    sharp: 'cubic-bezier(0.4, 0.0, 0.6, 1)',
  },
  
  // Spring animation configurations
  spring: {
    gentle: {
      tension: 120,
      friction: 14,
    },
    default: {
      tension: 170,
      friction: 20,
    },
    bouncy: {
      tension: 180,
      friction: 12,
    },
  },
}
```

### 7. Z-Index Tokens

Z-index tokens define the stacking order of elements.

```typescript
export const zIndex = {
  background: -1,
  default: 0,
  content: 1,
  overlay: 10,
  modal: 20,
  toast: 30,
  tooltip: 40,
  header: 50,
  dropdown: 60,
  loader: 70,
}
```

## Token Usage Hierarchy

The token system follows a hierarchical structure to promote consistency and maintainability:

1. **Base Tokens**: Raw values (colors, sizes, etc.)
2. **Semantic Tokens**: Tokens mapped to specific use cases
3. **Component Tokens**: Tokens specific to components
4. **Variant Tokens**: Tokens specific to component variants

### Example: Button Component

```typescript
// Component-specific tokens
export const buttonTokens = {
  // Base button styles
  background: {
    primary: colors.primary,
    secondary: colors.accent.coolBlue,
    outline: 'transparent',
  },
  
  text: {
    primary: colors.text.onHighlight,
    secondary: colors.text.primary,
    outline: colors.primary,
  },
  
  border: {
    primary: 'none',
    secondary: 'none',
    outline: `2px solid ${colors.primary}`,
  },
  
  // Size variants
  padding: {
    small: spacing.buttonPadding.small,
    medium: spacing.buttonPadding.medium,
    large: spacing.buttonPadding.large,
  },
  
  fontSize: {
    small: typography.sizes.bodySmall,
    medium: typography.sizes.body,
    large: typography.sizes.bodyLarge,
  },
  
  // State variants
  hover: {
    primary: {
      background: baseColors.lime[400],
    },
    secondary: {
      background: baseColors.coolBlue[400],
    },
    outline: {
      background: `rgba(210, 255, 77, 0.1)`,
    },
  },
  
  disabled: {
    background: baseColors.slate[500],
    text: colors.text.disabled,
    border: 'none',
  },
}
```

## Token Mapping

### Component to Token Mapping

This table shows how tokens map to specific components and their properties:

| Component | Property | Token |
|-----------|----------|-------|
| Button | Background | `colors.primary` |
| Button | Text Color | `colors.text.onHighlight` |
| Button | Padding | `spacing.buttonPadding.medium` |
| Button | Border Radius | `borderRadius.button` |
| Card | Background | `colors.neutral.canvasLight` |
| Card | Padding | `spacing.cardPadding` |
| Card | Border Radius | `borderRadius.card` |
| Card | Shadow | `elevation.level2` |
| Typography (Heading) | Font Size | `typography.sizes.headingLarge` |
| Typography (Heading) | Font Weight | `typography.fontWeights.bold` |
| Typography (Body) | Font Size | `typography.sizes.body` |
| Typography (Body) | Line Height | `typography.lineHeights.body` |
| Input | Border Color | `colors.text.secondary` |
| Input | Focus Border | `colors.primary` |
| Input | Padding | `spacing.inputPadding` |
| Input | Border Radius | `borderRadius.input` |

### Context-Based Token Usage

Tokens should be applied differently based on context:

#### Dark Background Context
When a component is on a dark background (`colors.background`):
- Use `colors.text.primary` for text
- Use higher elevation for better visibility
- Use `colors.primary` for accents and highlights

#### Light Background Context
When a component is on a light background (`colors.neutral.canvasLight`):
- Use `colors.text.inverted` for text
- Use lower elevation for subtle depth
- Use `colors.primary` for accents and highlights

#### Interactive Element Context
For interactive elements like buttons and links:
- Use `animation.duration.small` for hover/press animations
- Use `elevation` changes to indicate state changes
- Apply `colors.primary` for focus states

## Implementation Guidelines

### 1. Using Tokens in Components

```typescript
import { colors, spacing, typography, borderRadius, elevation } from '../constants/design-tokens';

const Button = ({ variant = 'primary', size = 'medium', disabled = false, children }) => {
  return (
    <TouchableOpacity
      style={{
        backgroundColor: disabled ? colors.text.disabled : colors[variant],
        paddingVertical: spacing.buttonPadding[size].vertical,
        paddingHorizontal: spacing.buttonPadding[size].horizontal,
        borderRadius: borderRadius.button,
        ...elevation.level1,
      }}
      disabled={disabled}
    >
      <Text
        style={{
          color: disabled ? colors.text.disabled : variant === 'primary' ? colors.text.onHighlight : colors.text.primary,
          fontSize: typography.sizes[size === 'small' ? 'bodySmall' : size === 'large' ? 'bodyLarge' : 'body'],
          fontWeight: typography.fontWeights.medium,
          textAlign: 'center',
        }}
      >
        {children}
      </Text>
    </TouchableOpacity>
  );
};
```

### 2. Creating Theme Context

```typescript
import React, { createContext, useContext, ReactNode } from 'react';
import { colors, spacing, typography, borderRadius, elevation, animation, zIndex } from '../constants/design-tokens';

// Theme context type
type ThemeContextType = {
  colors: typeof colors;
  spacing: typeof spacing;
  typography: typeof typography;
  borderRadius: typeof borderRadius;
  elevation: typeof elevation;
  animation: typeof animation;
  zIndex: typeof zIndex;
  isDark: boolean;
};

// Create context with default values
const ThemeContext = createContext<ThemeContextType>({
  colors,
  spacing,
  typography,
  borderRadius,
  elevation,
  animation,
  zIndex,
  isDark: true,
});

// Theme provider component
export const ThemeProvider: React.FC<{ children: ReactNode; isDark?: boolean }> = ({ 
  children, 
  isDark = true 
}) => {
  // Could modify tokens based on isDark or other theme variants
  const themeValue = {
    colors,
    spacing,
    typography,
    borderRadius,
    elevation,
    animation,
    zIndex,
    isDark,
  };
  
  return (
    <ThemeContext.Provider value={themeValue}>
      {children}
    </ThemeContext.Provider>
  );
};

// Hook for using the theme
export const useTheme = () => useContext(ThemeContext);
```

### 3. Using Theme in Components

```typescript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useTheme } from '../context/ThemeContext';

const Card = ({ title, children }) => {
  const theme = useTheme();
  
  const styles = StyleSheet.create({
    container: {
      backgroundColor: theme.isDark ? theme.colors.neutral.canvasDark : theme.colors.neutral.canvasLight,
      borderRadius: theme.borderRadius.card,
      padding: theme.spacing.cardPadding,
      ...theme.elevation.level2,
    },
    title: {
      color: theme.isDark ? theme.colors.text.primary : theme.colors.text.inverted,
      fontSize: theme.typography.sizes.headingSmall,
      fontWeight: theme.typography.fontWeights.bold,
      marginBottom: theme.spacing.sm,
    },
    content: {
      color: theme.isDark ? theme.colors.text.secondary : theme.colors.text.inverted,
      fontSize: theme.typography.sizes.body,
      lineHeight: theme.typography.sizes.body * theme.typography.lineHeights.body,
    },
  });
  
  return (
    <View style={styles.container}>
      {title && <Text style={styles.title}>{title}</Text>}
      <Text style={styles.content}>{children}</Text>
    </View>
  );
};

export default Card;
```

## Token Customization

### Extending Tokens for Specific Features

For feature-specific styling, extend the base tokens:

```typescript
// Gamification-specific tokens
export const gamificationTokens = {
  xp: {
    background: colors.primary,
    text: colors.text.onHighlight,
    icon: baseColors.lime[400],
  },
  level: {
    bronze: {
      background: '#CD7F32',
      text: colors.text.primary,
    },
    silver: {
      background: '#C0C0C0',
      text: colors.text.inverted,
    },
    gold: {
      background: '#FFD700',
      text: colors.text.inverted,
    },
    prime: {
      background: baseColors.coolBlue[300],
      text: colors.text.primary,
    },
    legend: {
      background: baseColors.coral[300],
      text: colors.text.primary,
    },
  },
  token: {
    background: colors.primary,
    text: colors.text.onHighlight,
    glow: `0 0 10px ${colors.primary}`,
  },
}
```

### Creating Screen-Specific Tokens

For screens with unique styling needs:

```typescript
// Bsse7a (Completion) screen tokens
export const bsse7aScreenTokens = {
  background: colors.status.success,
  confetti: [colors.primary, colors.accent.coolBlue, colors.accent.coral, '#FFFFFF'],
  card: {
    background: colors.neutral.canvasLight,
    border: `2px solid ${baseColors.jade[300]}`,
  },
  thankYou: {
    text: colors.text.primary,
    highlight: colors.accent.coral,
  },
}
```

## Best Practices

1. **Always use tokens instead of hard-coded values**
   - Incorrect: `color: '#D2FF4D'`
   - Correct: `color: colors.primary`

2. **Use semantic tokens over base tokens**
   - Incorrect: `color: baseColors.lime[300]`
   - Correct: `color: colors.primary`

3. **Use component tokens when available**
   - Incorrect: `padding: spacing.md`
   - Correct: `padding: spacing.buttonPadding.medium`

4. **Respect the token hierarchy**
   - Start with component-specific tokens
   - Fall back to semantic tokens
   - Use base tokens only when necessary

5. **Consider context when applying tokens**
   - Use different text colors based on background
   - Adjust elevation based on stacking context
   - Modify animation duration based on interaction importance

6. **Maintain token documentation**
   - Document new tokens when created
   - Explain the purpose and usage of tokens
   - Provide examples of correct token usage

## Token Validation

To ensure tokens are used correctly, implement token validation:

```typescript
// Token validation utility
export const validateTokenUsage = (component, property, token) => {
  // Check if token exists
  if (!token) {
    console.warn(`Missing token for ${component}.${property}`);
    return false;
  }
  
  // Check if token is appropriate for property
  const propertyTokenMap = {
    color: ['colors', 'text'],
    backgroundColor: ['colors', 'background'],
    padding: ['spacing'],
    margin: ['spacing'],
    fontSize: ['typography.sizes'],
    fontWeight: ['typography.fontWeights'],
    borderRadius: ['borderRadius'],
    // Add more property-token mappings
  };
  
  const validTokenTypes = propertyTokenMap[property] || [];
  const tokenType = Object.keys(token).join('.');
  
  if (!validTokenTypes.some(type => tokenType.includes(type))) {
    console.warn(`Invalid token type for ${component}.${property}. Expected one of ${validTokenTypes.join(', ')}, got ${tokenType}`);
    return false;
  }
  
  return true;
};
```

## Mobile Scaling

Tokens should adapt to different screen sizes:

```typescript
import { Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');
const isSmallDevice = width < 375;

// Scale factor based on screen size
const scaleFactor = isSmallDevice ? 0.9 : 1;

// Scale typography tokens
export const scaledTypography = Object.entries(typography.sizes).reduce((acc, [key, value]) => {
  acc[key] = Math.round(value * scaleFactor);
  return acc;
}, {});

// Scale spacing tokens
export const scaledSpacing = Object.entries(spacing).reduce((acc, [key, value]) => {
  if (typeof value === 'number') {
    acc[key] = Math.round(value * scaleFactor);
  } else {
    acc[key] = value; // Handle nested objects separately
  }
  return acc;
}, {});
```

## Token Usage Examples

### Button Component

```typescript
const ButtonStyles = StyleSheet.create({
  base: {
    borderRadius: borderRadius.button,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
  },
  
  // Variant styles
  primary: {
    backgroundColor: colors.primary,
  },
  secondary: {
    backgroundColor: colors.accent.coolBlue,
  },
  outline: {
    backgroundColor: 'transparent',
    borderWidth: 2,
    borderColor: colors.primary,
  },
  
  // Size styles
  small: {
    paddingVertical: spacing.buttonPadding.small.vertical,
    paddingHorizontal: spacing.buttonPadding.small.horizontal,
  },
  medium: {
    paddingVertical: spacing.buttonPadding.medium.vertical,
    paddingHorizontal: spacing.buttonPadding.medium.horizontal,
  },
  large: {
    paddingVertical: spacing.buttonPadding.large.vertical,
    paddingHorizontal: spacing.buttonPadding.large.horizontal,
  },
  
  // Text styles
  primaryText: {
    color: colors.text.onHighlight,
    fontWeight: typography.fontWeights.medium,
  },
  secondaryText: {
    color: colors.text.primary,
    fontWeight: typography.fontWeights.medium,
  },
  outlineText: {
    color: colors.primary,
    fontWeight: typography.fontWeights.medium,
  },
  
  // Size-specific text styles
  smallText: {
    fontSize: typography.sizes.bodySmall,
  },
  mediumText: {
    fontSize: typography.sizes.body,
  },
  largeText: {
    fontSize: typography.sizes.bodyLarge,
  },
  
  // State styles
  disabled: {
    backgroundColor: colors.text.disabled,
    borderColor: colors.text.disabled,
  },
  disabledText: {
    color: colors.text.primary,
  },
  
  // Icon styles
  icon: {
    marginRight: spacing.xs,
  },
});
```

### Card Component

```typescript
const CardStyles = StyleSheet.create({
  base: {
    borderRadius: borderRadius.card,
    padding: spacing.cardPadding,
    backgroundColor: colors.neutral.canvasLight,
    ...elevation.level2,
  },
  
  // Variant styles
  elevated: {
    ...elevation.level3,
  },
  bubble: {
    borderRadius: borderRadius.extraLarge,
    ...elevation.level2,
  },
  
  // State styles
  selected: {
    borderWidth: 2,
    borderColor: colors.primary,
  },
  
  // Content styles
  title: {
    fontSize: typography.sizes.headingSmall,
    fontWeight: typography.fontWeights.bold,
    color: colors.text.inverted,
    marginBottom: spacing.xs,
  },
  subtitle: {
    fontSize: typography.sizes.body,
    color: colors.text.secondary,
    marginBottom: spacing.sm,
  },
  content: {
    fontSize: typography.sizes.body,
    color: colors.text.inverted,
    lineHeight: typography.sizes.body * typography.lineHeights.body,
  },
});
```

## Conclusion

This token system provides a comprehensive framework for styling ZinApp V2. By following these guidelines and using tokens consistently, we can ensure a cohesive, maintainable, and visually appealing application that aligns with our brand identity.
