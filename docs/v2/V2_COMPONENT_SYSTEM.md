# ZinApp V2 Component System

This document outlines the component system for ZinApp V2, including design principles, component structure, and visual guidelines.

## Design Principles

ZinApp V2 components follow these core design principles:

1. **Depth & Layering**: Components use shadows, elevation, and layering to create a sense of depth and hierarchy.

2. **Rounded Corners**: All components have rounded corners for a friendly, approachable feel.

3. **Generous Padding**: Components use ample padding to create breathing room and improve readability.

4. **Visual Feedback**: Every interactive component provides clear visual feedback.

5. **Consistent Spacing**: Components use a consistent spacing system.

6. **Expressive Typography**: Typography creates clear hierarchy and improves readability.

7. **Playful Animations**: Subtle animations add personality and improve user experience.

8. **Gamification Integration**: Components support gamification elements like XP, levels, and rewards.

## Component Categories

### 1. Foundation Components

These are the basic building blocks of the UI:

#### Button

- **Variants**: Primary, Secondary, Outline, Text
- **States**: Default, Hover, Pressed, Disabled
- **Sizes**: Small, Medium, Large
- **Features**:
  - Rounded corners (12px radius)
  - Icon support (left or right)
  - Loading state
  - Ripple effect on press
  - Scale animation on press (0.98)

#### Card

- **Variants**: Standard, Elevated, Bubble
- **States**: Default, Interactive, Selected
- **Features**:
  - Rounded corners (16px radius)
  - Shadow with elevation
  - Optional border
  - Content padding (16px)
  - Interactive hover state

#### Typography

- **Variants**: Heading (L/M/S), Body, Caption, Button
- **Weights**: Regular, Medium, Bold
- **Features**:
  - Consistent line height
  - Optional truncation
  - Support for emphasis
  - Automatic contrast adjustment

#### Input

- **Variants**: Text, Number, Select, Checkbox, Radio
- **States**: Default, Focus, Error, Disabled
- **Features**:
  - Floating label
  - Helper text
  - Error message
  - Icon support
  - Animation on focus

### 2. Layout Components

These components handle layout and structure:

#### ScreenWrapper

- Provides consistent screen padding
- Handles safe area insets
- Supports scroll behavior
- Includes background styling

#### CardWrapper

- Wraps content in a card with consistent styling
- Handles padding and margins
- Supports different card variants

#### Grid

- Flexible grid system for layout
- Supports different column counts
- Handles responsive behavior
- Maintains consistent spacing

#### Divider

- Horizontal or vertical divider
- Customizable color and thickness
- Optional spacing around divider

### 3. Feature Components

These are more complex, feature-specific components:

#### StylistCard

- Displays stylist information
- Shows rating and level
- Includes avatar and services
- Supports interaction for booking

#### ServiceCard

- Displays service information
- Shows price and duration
- Includes icon or image
- Supports selection state

#### BookingStep

- Guides user through booking process
- Shows current step and progress
- Includes navigation controls
- Maintains context between steps

#### RatingInput

- Allows user to rate experience
- Shows current and average ratings
- Includes animation on selection
- Supports half-star ratings

### 4. Feedback Components

These components provide feedback to the user:

#### Toast

- Shows temporary messages
- Supports success, error, info variants
- Includes animation for entry/exit
- Auto-dismisses after timeout

#### Dialog

- Modal dialog for important information
- Supports different sizes and content
- Includes primary and secondary actions
- Has animation for entry/exit

#### LoadingIndicator

- Shows loading state
- Supports different sizes
- Includes animation
- Optional text message

#### ErrorDisplay

- Shows error messages
- Supports inline and full-screen variants
- Includes retry action
- Has appropriate error styling

## Visual Specifications

### Elevation & Shadows

Components use a consistent elevation system:

| Level | Use Case | Shadow Properties |
|-------|----------|-------------------|
| 0 | Flat elements | No shadow |
| 1 | Cards, buttons | 0px 2px 4px rgba(0,0,0,0.1) |
| 2 | Floating elements | 0px 4px 8px rgba(0,0,0,0.15) |
| 3 | Dialogs, modals | 0px 8px 16px rgba(0,0,0,0.2) |
| 4 | Popovers | 0px 12px 24px rgba(0,0,0,0.25) |

### Corner Radius

Components use a consistent corner radius system:

| Size | Use Case | Radius |
|------|----------|--------|
| Small | Small elements (chips, tags) | 8px |
| Medium | Buttons, inputs | 12px |
| Large | Cards, dialogs | 16px |
| Extra Large | Full-screen cards | 24px |

### Spacing System

Components use a consistent spacing system:

| Token | Size | Use Case |
|-------|------|----------|
| spacing.xxs | 4px | Minimal spacing, icons |
| spacing.xs | 8px | Tight spacing, related elements |
| spacing.sm | 12px | Standard spacing |
| spacing.md | 16px | Default content padding |
| spacing.lg | 24px | Section spacing |
| spacing.xl | 32px | Major section spacing |
| spacing.xxl | 48px | Screen padding |

### Animation Guidelines

Components use consistent animation properties:

| Type | Duration | Easing | Use Case |
|------|----------|--------|----------|
| Micro | 100-150ms | ease-out | Button press, toggle |
| Small | 200-300ms | ease-in-out | Fade, slide |
| Medium | 300-500ms | ease-in-out | Page transition |
| Large | 500-800ms | ease-in-out | Complex animations |

## Component Implementation

### Component Structure

Each component follows this structure:

```typescript
// Imports
import React from 'react';
import { View, StyleSheet } from 'react-native';
import { colors, spacing } from '../constants';

// Props interface
interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
}

// Component implementation
const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  variant = 'primary',
  size = 'medium',
  disabled = false,
}) => {
  // Component logic
  
  return (
    <View style={[styles.container, styles[variant], styles[size], disabled && styles.disabled]}>
      {/* Component content */}
    </View>
  );
};

// Styles
const styles = StyleSheet.create({
  container: {
    // Base styles
  },
  // Variant styles
  // Size styles
  // State styles
});

export default Button;
```

### Style Guidelines

1. Use design tokens for all visual properties (colors, spacing, typography)
2. Implement variants and states as style objects
3. Use composition for complex components
4. Ensure accessibility for all components
5. Include appropriate animations and transitions

## Accessibility Guidelines

All components must follow these accessibility guidelines:

1. Ensure sufficient color contrast (WCAG AA)
2. Provide appropriate text alternatives for non-text content
3. Support keyboard navigation
4. Include proper focus indicators
5. Support screen readers with appropriate labels
6. Allow for text resizing without breaking layout
7. Provide sufficient touch targets (minimum 44x44px)

## Component Documentation

Each component should include:

1. **Purpose**: What the component is for
2. **Props**: All available props with types and descriptions
3. **Variants**: Available variants with visual examples
4. **States**: Different states the component can be in
5. **Accessibility**: Accessibility considerations
6. **Examples**: Usage examples with code snippets

## QA Checklist for Components

Before a component is considered complete, it should pass this checklist:

- [ ] Implements all required variants and states
- [ ] Uses design tokens for all visual properties
- [ ] Includes appropriate animations and transitions
- [ ] Follows accessibility guidelines
- [ ] Works across different screen sizes
- [ ] Has comprehensive documentation
- [ ] Passes all unit tests
