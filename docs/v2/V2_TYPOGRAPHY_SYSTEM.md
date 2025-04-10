# ZinApp V2 Typography System

This document details the typography system for ZinApp V2, including text styles, usage contexts, sizes, mobile scaling logic, and fallback behavior.

## Typography Philosophy

Typography in ZinApp V2 serves several key purposes:

1. **Create Clear Hierarchy**: Guide users through content with distinct heading and body styles
2. **Enhance Readability**: Ensure text is legible across all screen sizes and contexts
3. **Express Brand Personality**: Convey the playful, energetic nature of the ZinApp brand
4. **Maintain Consistency**: Provide a unified typographic experience throughout the app
5. **Support Accessibility**: Ensure text is accessible to all users, including those with visual impairments

## Font Family

ZinApp V2 uses a modern sans-serif font as its primary typeface:

### Primary Font: Urbanist

Urbanist is the primary typeface, chosen for its clean, geometric sans-serif style with friendly, open letterforms that align with ZinApp's playful-premium brand identity. It is open-source.

```typescript
fontFamily: 'Urbanist'
```

### Fallback Fonts

If Urbanist is unavailable or specific weights are missing, the following fallbacks should be used in order of preference:

1.  **Nunito**: A well-rounded sans-serif with a similar friendly character, good accessibility.
2.  **Inter**: A highly legible sans-serif designed specifically for UI screens.
3.  **System Default**: Platform's default sans-serif font.

*(Note: Uber Move may be used in specific marketing assets for brand alignment, but not within the app UI).*

### Font Loading Strategy

```typescript
// Font loading in App.tsx
import * as Font from 'expo-font';
import { useState, useEffect } from 'react';

export default function App() {
  const [fontsLoaded, setFontsLoaded] = useState(false);

  useEffect(() => {
    async function loadFonts() {
      await Font.loadAsync({
        'Urbanist-Regular': require('../assets/fonts/Urbanist-Regular.ttf'),
        'Urbanist-SemiBold': require('../assets/fonts/Urbanist-SemiBold.ttf'), // Assuming 600 weight file exists
        'Urbanist-Bold': require('../assets/fonts/Urbanist-ExtraBold.ttf'), // Assuming 800 weight file exists
        // Fallback fonts
        'Nunito-Regular': require('../assets/fonts/Nunito-Regular.ttf'),
        'Nunito-SemiBold': require('../assets/fonts/Nunito-SemiBold.ttf'), // Assuming 600 weight file exists
        'Nunito-ExtraBold': require('../assets/fonts/Nunito-ExtraBold.ttf'), // Assuming 800 weight file exists
      });
      setFontsLoaded(true);
    }

    loadFonts();
  }, []);

  if (!fontsLoaded) {
    return <AppLoading />;
  }

  // Rest of the app
}
```

## Type Scale

ZinApp V2 uses a consistent type scale to create visual hierarchy:

### Headings

| Style | Size | Weight | Line Height | Letter Spacing | Use Case |
|-------|------|--------|-------------|----------------|----------|
| Heading Large | 28px | Bold (800) | 1.3 | -0.5px | Screen titles, major section headers |
| Heading Medium | 24px | Bold (800) | 1.3 | -0.5px | Section headers, card titles |
| Heading Small | 20px | Bold (800) | 1.3 | -0.25px | Subsection headers, modal titles |

### Body Text

| Style | Size | Weight | Line Height | Letter Spacing | Use Case |
|-------|------|--------|-------------|----------------|----------|
| Body Large | 18px | Regular (400) | 1.5 | 0px | Featured content, important information |
| Body | 16px | Regular (400) | 1.5 | 0px | Primary content text |
| Body Small | 14px | Regular (400) | 1.5 | 0px | Secondary content, metadata |
| Caption | 13px | Regular (400) | 1.5 | 0.25px | Labels, timestamps, auxiliary information |

### Interactive Text

| Style | Size | Weight | Line Height | Letter Spacing | Use Case |
|-------|------|--------|-------------|----------------|----------|
| Button Large | 18px | SemiBold (600) | 1.2 | 0.5px | Primary CTAs |
| Button Medium | 16px | SemiBold (600) | 1.2 | 0.5px | Standard buttons |
| Button Small | 14px | SemiBold (600) | 1.2 | 0.5px | Secondary buttons, compact actions |
| Link | 16px | SemiBold (600) | 1.5 | 0px | Hyperlinks, interactive text |

## Font Weights

ZinApp V2 uses three primary font weights to create hierarchy and emphasis:

1.  **Regular (400)**: Used for body text and general content.
2.  **SemiBold (600)**: Used for interactive elements (buttons, links), emphasis, and some subheadings.
3.  **Bold (800)**: Used for headings and strong emphasis. *(Note: This corresponds to ExtraBold in some font families)*.

```typescript
// Example token definition
fontWeights: {
  regular: '400',
  semiBold: '600',
  bold: '800', // Or 'bold' if the font maps 800 to 'bold'
}
```

## Implementation

### Typography Component

```typescript
import React from 'react';
import { Text, StyleSheet, TextStyle, TextProps } from 'react-native';
import { typography, colors } from '../constants/design-tokens';

type TypographyVariant = 
  | 'headingLarge' 
  | 'headingMedium' 
  | 'headingSmall' 
  | 'bodyLarge' 
  | 'body' 
  | 'bodySmall' 
  | 'caption' 
  | 'buttonLarge' 
  | 'buttonMedium' 
  | 'buttonSmall' 
  | 'link';

interface TypographyProps extends TextProps {
  variant: TypographyVariant;
  color?: string;
  align?: 'auto' | 'left' | 'right' | 'center' | 'justify';
  weight?: 'regular' | 'semiBold' | 'bold';
  style?: TextStyle;
  children: React.ReactNode;
}

const Typography: React.FC<TypographyProps> = ({
  variant,
  color,
  align = 'left',
  weight,
  style,
  children,
  ...props
}) => {
  return (
    <Text
      style={[
        styles.base,
        styles[variant],
        weight && styles[weight],
        { color: color || styles[variant].color, textAlign: align },
        style,
      ]}
      {...props}
    >
      {children}
    </Text>
  );
};

const styles = StyleSheet.create({
  base: {
    fontFamily: typography.fontFamily,
  },
  
  // Heading styles
  headingLarge: {
    fontSize: typography.sizes.headingLarge,
    fontWeight: typography.fontWeights.bold, // 800
    lineHeight: typography.sizes.headingLarge * typography.lineHeights.heading,
    letterSpacing: typography.letterSpacing.tight,
    color: colors.text.primary,
  },
  headingMedium: {
    fontSize: typography.sizes.headingMedium,
    fontWeight: typography.fontWeights.bold, // 800
    lineHeight: typography.sizes.headingMedium * typography.lineHeights.heading,
    letterSpacing: typography.letterSpacing.tight,
    color: colors.text.primary,
  },
  headingSmall: {
    fontSize: typography.sizes.headingSmall,
    fontWeight: typography.fontWeights.bold, // 800
    lineHeight: typography.sizes.headingSmall * typography.lineHeights.heading,
    letterSpacing: typography.letterSpacing.tight,
    color: colors.text.primary,
  },
  
  // Body styles
  bodyLarge: {
    fontSize: typography.sizes.bodyLarge,
    fontWeight: typography.fontWeights.regular,
    lineHeight: typography.sizes.bodyLarge * typography.lineHeights.body,
    letterSpacing: typography.letterSpacing.normal,
    color: colors.text.primary,
  },
  body: {
    fontSize: typography.sizes.body,
    fontWeight: typography.fontWeights.regular,
    lineHeight: typography.sizes.body * typography.lineHeights.body,
    letterSpacing: typography.letterSpacing.normal,
    color: colors.text.primary,
  },
  bodySmall: {
    fontSize: typography.sizes.bodySmall,
    fontWeight: typography.fontWeights.regular,
    lineHeight: typography.sizes.bodySmall * typography.lineHeights.body,
    letterSpacing: typography.letterSpacing.normal,
    color: colors.text.secondary,
  },
  caption: {
    fontSize: typography.sizes.caption,
    fontWeight: typography.fontWeights.regular,
    lineHeight: typography.sizes.caption * typography.lineHeights.body,
    letterSpacing: typography.letterSpacing.wide,
    color: colors.text.secondary,
  },
  
  // Interactive styles
  buttonLarge: {
    fontSize: typography.sizes.bodyLarge,
    fontWeight: typography.fontWeights.semiBold, // 600
    lineHeight: typography.sizes.bodyLarge * typography.lineHeights.button,
    letterSpacing: typography.letterSpacing.wide,
    color: colors.text.primary,
  },
  buttonMedium: {
    fontSize: typography.sizes.body,
    fontWeight: typography.fontWeights.semiBold, // 600
    lineHeight: typography.sizes.body * typography.lineHeights.button,
    letterSpacing: typography.letterSpacing.wide,
    color: colors.text.primary,
  },
  buttonSmall: {
    fontSize: typography.sizes.bodySmall,
    fontWeight: typography.fontWeights.semiBold, // 600
    lineHeight: typography.sizes.bodySmall * typography.lineHeights.button,
    letterSpacing: typography.letterSpacing.wide,
    color: colors.text.primary,
  },
  link: {
    fontSize: typography.sizes.body,
    fontWeight: typography.fontWeights.semiBold, // 600
    lineHeight: typography.sizes.body * typography.lineHeights.body,
    letterSpacing: typography.letterSpacing.normal,
    color: colors.text.link,
    textDecorationLine: 'underline',
  },
  
  // Weight styles
  regular: {
    fontWeight: typography.fontWeights.regular,
  },
  semiBold: {
    fontWeight: typography.fontWeights.semiBold, // 600
  },
  bold: {
    fontWeight: typography.fontWeights.bold, // 800
  },
});

export default Typography;
```

### Usage Examples

```typescript
// Basic usage
<Typography variant="headingLarge">Welcome to ZinApp</Typography>
<Typography variant="body">Find the perfect stylist for your next haircut.</Typography>

// With custom color
<Typography variant="headingMedium" color={colors.primary}>Special Offer</Typography>

// With custom alignment
<Typography variant="body" align="center">Centered text content</Typography>

// With custom weight
<Typography variant="body" weight="medium">Medium weight text for emphasis</Typography>

// Link text
<Typography variant="link" onPress={() => handlePress()}>Learn more</Typography>

// Button text
<Button>
  <Typography variant="buttonMedium" color={colors.text.onHighlight}>Get Started</Typography>
</Button>
```

## Responsive Scaling (Optional)

While the primary approach is to use the fixed token tiers defined above, optional responsive scaling can be applied selectively if needed to maintain optimal readability or visual balance on significantly different screen sizes (e.g., small phones vs. large tablets).

**Strategy:** Use predefined token tiers as the base. Apply a scaling factor based on screen width *only* for specific text elements where fixed sizes feel inappropriate across the device range. Avoid scaling all text universally, as it can lead to unpredictable layouts.

**Example Implementation (React Native):**
The following function calculates a scale factor based on a baseline screen width (e.g., iPhone 8/SE width) and applies it to a base font size, with constraints to prevent text from becoming too small or too large.

```typescript
import { Dimensions, PixelRatio } from 'react-native';

const { width, height } = Dimensions.get('window');
const screenWidth = Math.min(width, height);

// Base scale for typography
const scale = screenWidth / 375; // 375 is the base width

// Function to scale font size based on screen width
export const scaleFontSize = (size: number) => {
  const newSize = size * scale;
  
  // Ensure font size doesn't get too small or too large
  if (screenWidth >= 768) { // Tablet or larger
    return Math.round(Math.min(newSize, size * 1.2));
  }
  
  return Math.round(Math.max(size * 0.9, Math.min(newSize, size * 1.1)));
};

// Example function to get scaled sizes (use cautiously)
export const getScaledTypography = (enableScaling: boolean = false) => {
  if (!enableScaling) return typography; // Return base tokens if scaling is off

  return {
  return {
    ...typography,
    sizes: {
      headingLarge: scaleFontSize(typography.sizes.headingLarge),
      headingMedium: scaleFontSize(typography.sizes.headingMedium),
      headingSmall: scaleFontSize(typography.sizes.headingSmall),
      bodyLarge: scaleFontSize(typography.sizes.bodyLarge),
      body: scaleFontSize(typography.sizes.body),
      bodySmall: scaleFontSize(typography.sizes.bodySmall),
      caption: scaleFontSize(typography.sizes.caption),
    },
  };
};

// Example Usage (Conditional Scaling):
// Decide whether to use scaled sizes based on context or component props
const useScaledSizes = shouldScaleTypographyForThisContext();
const currentTypography = getScaledTypography(useScaledSizes);

const styles = StyleSheet.create({
  headingLarge: {
    fontSize: currentTypography.sizes.headingLarge,
    // Other styles
  },
  // Other styles using currentTypography.sizes...
});

**Note:** Implementing responsive scaling adds complexity. Prioritize using the fixed token tiers effectively first. Scaling should be a deliberate enhancement, not the default.
```

## Text Truncation

For handling text overflow:

```typescript
// Truncation component
interface TruncateTextProps extends TypographyProps {
  numberOfLines: number;
  ellipsizeMode?: 'head' | 'middle' | 'tail' | 'clip';
}

const TruncateText: React.FC<TruncateTextProps> = ({
  numberOfLines,
  ellipsizeMode = 'tail',
  ...props
}) => {
  return (
    <Typography
      numberOfLines={numberOfLines}
      ellipsizeMode={ellipsizeMode}
      {...props}
    />
  );
};

// Usage
<TruncateText variant="body" numberOfLines={2}>
  This is a long text that will be truncated after two lines with an ellipsis at the end.
</TruncateText>
```

## Text Styles by Context

### Dark Background Context

When text appears on the dark background (`#232D30`):

```typescript
// Text on dark background
<View style={{ backgroundColor: colors.background }}>
  <Typography variant="headingLarge">
    Heading on Dark
  </Typography>
  <Typography variant="body">
    Body text on dark background uses light text colors for contrast.
  </Typography>
</View>

// Styles for dark background
darkBackground: {
  headingLarge: {
    color: colors.text.primary, // #FCFBF9
  },
  body: {
    color: colors.text.primary, // #FCFBF9
  },
  bodySmall: {
    color: colors.text.secondary, // #B7C0C9
  },
}
```

### Light Background Context

When text appears on light backgrounds (`#F8F3ED` to `#FCFBF9`):

```typescript
// Text on light background
<View style={{ backgroundColor: colors.neutral.canvasLight }}>
  <Typography variant="headingLarge" color={colors.text.inverted}>
    Heading on Light
  </Typography>
  <Typography variant="body" color={colors.text.inverted}>
    Body text on light background uses dark text colors for contrast.
  </Typography>
</View>

// Styles for light background
lightBackground: {
  headingLarge: {
    color: colors.text.inverted, // #232D30
  },
  body: {
    color: colors.text.inverted, // #232D30
  },
  bodySmall: {
    color: colors.text.inverted, // #232D30 (possibly with opacity)
  },
}
```

### Highlight Context

When text appears on the primary highlight color (`#D2FF4D`):

```typescript
// Text on highlight background
<View style={{ backgroundColor: colors.primary }}>
  <Typography variant="headingLarge" color={colors.text.onHighlight}>
    Heading on Highlight
  </Typography>
  <Typography variant="body" color={colors.text.onHighlight}>
    Body text on highlight background uses dark text for contrast.
  </Typography>
</View>

// Styles for highlight background
highlightBackground: {
  headingLarge: {
    color: colors.text.onHighlight, // #232D30
  },
  body: {
    color: colors.text.onHighlight, // #232D30
  },
  bodySmall: {
    color: colors.text.onHighlight, // #232D30
  },
}
```

## Special Text Treatments

### Price and Token Display

For displaying prices and token values:

```typescript
// Price component
interface PriceProps {
  amount: number;
  currency?: string;
  size?: 'small' | 'medium' | 'large';
}

const Price: React.FC<PriceProps> = ({
  amount,
  currency = '$',
  size = 'medium',
}) => {
  const sizeMap = {
    small: 'bodySmall',
    medium: 'body',
    large: 'bodyLarge',
  };
  
  return (
    <View style={{ flexDirection: 'row', alignItems: 'flex-start' }}>
      <Typography variant={sizeMap[size]} weight="bold">
        {currency}
      </Typography>
      <Typography variant={sizeMap[size]} weight="bold">
        {amount.toFixed(2)}
      </Typography>
    </View>
  );
};

// Token display component
interface TokenDisplayProps {
  amount: number;
  showIcon?: boolean;
  size?: 'small' | 'medium' | 'large';
}

const TokenDisplay: React.FC<TokenDisplayProps> = ({
  amount,
  showIcon = true,
  size = 'medium',
}) => {
  const sizeMap = {
    small: 'bodySmall',
    medium: 'body',
    large: 'bodyLarge',
  };
  
  return (
    <View style={{ flexDirection: 'row', alignItems: 'center' }}>
      {showIcon && (
        <Image 
          source={require('../assets/icons/token.png')} 
          style={{ 
            width: size === 'small' ? 16 : size === 'large' ? 24 : 20, 
            height: size === 'small' ? 16 : size === 'large' ? 24 : 20,
            marginRight: 4,
          }} 
        />
      )}
      <Typography 
        variant={sizeMap[size]} 
        weight="bold" 
        color={colors.text.token}
      >
        {amount}
      </Typography>
    </View>
  );
};
```

### Highlighted Text

For emphasizing parts of text:

```typescript
// Highlighted text component
interface HighlightTextProps {
  text: string;
  highlight: string | string[];
  variant?: TypographyVariant;
  highlightColor?: string;
}

const HighlightText: React.FC<HighlightTextProps> = ({
  text,
  highlight,
  variant = 'body',
  highlightColor = colors.primary,
}) => {
  if (!highlight || !text) return <Typography variant={variant}>{text}</Typography>;
  
  const highlights = Array.isArray(highlight) ? highlight : [highlight];
  let parts = [text];
  
  highlights.forEach(highlightText => {
    const newParts: string[] = [];
    
    parts.forEach(part => {
      const splitPart = part.split(new RegExp(`(${highlightText})`, 'gi'));
      newParts.push(...splitPart);
    });
    
    parts = newParts;
  });
  
  return (
    <Typography variant={variant}>
      {parts.map((part, i) => {
        const isHighlighted = highlights.some(h => 
          part.toLowerCase() === h.toLowerCase()
        );
        
        return isHighlighted ? (
          <Typography 
            key={i} 
            variant={variant} 
            color={highlightColor} 
            weight="bold"
          >
            {part}
          </Typography>
        ) : (
          part
        );
      })}
    </Typography>
  );
};

// Usage
<HighlightText 
  text="Find the perfect stylist for your next haircut" 
  highlight="perfect stylist" 
/>
```

## Accessibility

### Dynamic Type Support

Support for system font size settings:

```typescript
import { useEffect, useState } from 'react';
import { AccessibilityInfo } from 'react-native';

// Hook for getting preferred font scale
const useFontScale = () => {
  const [fontScale, setFontScale] = useState(1);
  
  useEffect(() => {
    const getFontScale = async () => {
      const scale = await AccessibilityInfo.getRecommendedFontSizes();
      setFontScale(scale.largeScale);
    };
    
    getFontScale();
    
    const subscription = AccessibilityInfo.addEventListener(
      'boldTextChanged',
      getFontScale
    );
    
    return () => {
      subscription.remove();
    };
  }, []);
  
  return fontScale;
};

// Apply font scale to typography
const Typography: React.FC<TypographyProps> = (props) => {
  const fontScale = useFontScale();
  
  return (
    <Text
      style={[
        styles.base,
        styles[props.variant],
        { fontSize: styles[props.variant].fontSize * fontScale },
        // Other styles
      ]}
      {...props}
    >
      {props.children}
    </Text>
  );
};
```

### Screen Reader Support

Ensure text is properly labeled for screen readers:

```typescript
// Screen reader friendly component
<Typography 
  variant="body" 
  accessibilityLabel="Find the perfect stylist for your next haircut"
  accessibilityRole="text"
>
  Find the perfect stylist for your next haircut
</Typography>

// For interactive text
<Typography 
  variant="link" 
  accessibilityLabel="Learn more about our services"
  accessibilityRole="button"
  accessibilityHint="Opens the services information page"
  onPress={() => handlePress()}
>
  Learn more
</Typography>
```

## Fallback Behavior

If the custom font fails to load:

```typescript
// Font fallback system
const fontFallbacks = {
  primary: {
    regular: ['Urbanist-Regular', 'Nunito-Regular', 'System'], // 400
    semiBold: ['Urbanist-SemiBold', 'Nunito-SemiBold', 'System'], // 600
    bold: ['Urbanist-Bold', 'Nunito-ExtraBold', 'System'], // 800 (or font's 'bold')
  },
};

// Font loading error handling
const [fontError, setFontError] = useState(false);

useEffect(() => {
  async function loadFonts() {
    try {
      await Font.loadAsync({
        'Urbanist-Regular': require('../assets/fonts/Urbanist-Regular.ttf'),
        // Other fonts
      });
    } catch (error) {
      console.error('Font loading error:', error);
      setFontError(true);
    }
  }
  
  loadFonts();
}, []);

// Apply fallbacks if needed
const getFontFamily = (weight: 'regular' | 'semiBold' | 'bold') => {
  if (fontError) {
    // Use system font if custom font failed to load
    return undefined; // React Native will use system font
  }
  
  return fontFallbacks.primary[weight][0]; // Primary font
};

// In Typography component
const styles = StyleSheet.create({
  regular: {
    fontFamily: getFontFamily('regular'),
    fontWeight: typography.fontWeights.regular,
  },
  // Other styles
});
```

## Text Measurement

For dynamic layout based on text size:

```typescript
import { Text, TextInput } from 'react-native';

// Measure text dimensions
const measureText = (text: string, fontSize: number, fontFamily: string, callback: (width: number, height: number) => void) => {
  const textToMeasure = Text.render(
    <Text
      style={{
        fontSize,
        fontFamily,
      }}
    >
      {text}
    </Text>
  );
  
  textToMeasure.measure((x, y, width, height) => {
    callback(width, height);
  });
};

// Usage
measureText('Sample text', typography.sizes.body, typography.fontFamily, (width, height) => {
  console.log('Text dimensions:', width, height);
  // Use dimensions for layout
});
```

## Typography Guidelines

### Do's and Don'ts

#### Do:
- Use the Typography component for all text in the app
- Follow the type scale for consistent sizing
- Use appropriate variants for different contexts
- Consider contrast for readability
- Test typography on different screen sizes

#### Don't:
- Mix different font families
- Use font sizes outside the type scale
- Use too many different text styles on one screen
- Use low-contrast text colors
- Overuse bold or emphasized text

### Best Practices

1. **Maintain Hierarchy**: Use heading styles for titles and body styles for content
2. **Ensure Readability**: Maintain sufficient contrast between text and background
3. **Be Consistent**: Use the same text styles for similar content throughout the app
4. **Respect Spacing**: Allow adequate space around text elements
5. **Consider Context**: Adapt text styles based on the background and surrounding elements

## Implementation Checklist

- [ ] Set up font loading system
- [ ] Create Typography component with all variants
- [ ] Implement *optional* responsive scaling logic and document usage
- [ ] Add support for text truncation
- [ ] Create special text components (Price, TokenDisplay, HighlightText)
- [ ] Implement accessibility features
- [ ] Set up fallback behavior for font loading failures
- [ ] Test typography on different devices and screen sizes
- [ ] Document usage guidelines for the team
