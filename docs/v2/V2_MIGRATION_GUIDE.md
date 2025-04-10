# ZinApp V2 Migration Guide

This document provides guidance for migrating components and functionality from ZinApp V1 to V2.

## Overview

ZinApp V2 represents a significant evolution from V1, with major changes to brand identity, visual design, code structure, and the addition of gamification elements. While V2 is a substantial redesign, certain aspects of V1 can be adapted and reused.

## What to Keep from V1

### Logic and Functionality

- **Core Business Logic**: The fundamental business logic for booking, tracking, and service management can be adapted.
- **API Integration**: The basic structure of API calls and data handling can be reused with modifications.
- **Navigation Flow**: The general user journey and screen flow can be maintained while enhancing the transitions.
- **Form Validation**: Basic validation logic can be reused with updated UI components.
- **Authentication**: User authentication logic can be adapted to the new architecture.

### Code Structure

- **Type Definitions**: Many type definitions can be reused or extended.
- **Utility Functions**: Helper functions for date formatting, price calculation, etc., can be reused.
- **Constants**: Some constants like API endpoints, error messages, etc., can be maintained.

## What to Replace in V2

### Visual Design

- **UI Components**: All UI components should be rebuilt using the new design system.
- **Colors and Typography**: Replace all color and typography values with the new design tokens.
- **Layouts**: Update all layouts to use the new spacing system and visual hierarchy.
- **Animations**: Implement new animations and transitions for all interactive elements.

### Code Structure

- **Component Organization**: Reorganize components according to the new file structure.
- **Styling Approach**: Replace direct styling with the design token system.
- **Navigation Implementation**: Enhance navigation with custom transitions and animations.

### Architecture

- **State Management**: Update to the new multi-layered state management approach.
- **Component Communication**: Implement the new component communication patterns.
- **Error Handling**: Enhance error handling with the new error presentation system.

## Migration Process

### 1. Preparation

- **Audit V1 Code**: Identify reusable logic and components.
- **Document Dependencies**: Map out dependencies between components.
- **Create Migration Plan**: Develop a component-by-component migration plan.

### 2. Foundation Setup

- **Set Up Project Structure**: Implement the new file structure.
- **Create Design Token System**: Implement the design token system based on V2_BRAND_IDENTITY.md.
- **Build Foundation Components**: Create the basic UI components following V2_COMPONENT_SYSTEM.md.

### 3. Component Migration

For each component:

1. **Identify V1 Component**: Locate the component in the V1 codebase.
2. **Extract Logic**: Identify and extract reusable logic.
3. **Create V2 Component**: Build the new component using the V2 design system.
4. **Integrate Logic**: Integrate the extracted logic into the new component.
5. **Test Component**: Verify the component works as expected.

### 4. Screen Migration

For each screen:

1. **Identify V1 Screen**: Locate the screen in the V1 codebase.
2. **Extract Logic**: Identify and extract reusable logic.
3. **Create V2 Screen**: Build the new screen using V2 components.
4. **Integrate Logic**: Integrate the extracted logic into the new screen.
5. **Add Animations**: Implement animations and transitions.
6. **Test Screen**: Verify the screen works as expected.

### 5. Gamification Integration

- **Identify Integration Points**: Determine where gamification elements should be integrated.
- **Implement XP System**: Add XP tracking to user actions.
- **Add Visual Elements**: Implement UI components for displaying XP, levels, and tokens.
- **Test Gamification**: Verify the gamification system works as expected.

## Component Migration Examples

### Button Component

#### V1 Button
```typescript
// V1 Button
const Button = ({ title, onPress, disabled }) => {
  return (
    <TouchableOpacity
      style={[styles.button, disabled && styles.disabled]}
      onPress={onPress}
      disabled={disabled}
    >
      <Text style={styles.buttonText}>{title}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    backgroundColor: '#F4805D',
    padding: 12,
    borderRadius: 4,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
  },
  disabled: {
    backgroundColor: '#ccc',
  },
});
```

#### V2 Button
```typescript
// V2 Button
import { colors, spacing, typography } from '../../constants/design-tokens';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
  iconName?: string;
  iconPosition?: 'left' | 'right';
}

const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  variant = 'primary',
  size = 'medium',
  disabled = false,
  iconName,
  iconPosition = 'left',
}) => {
  // Animation for press feedback
  const scale = useRef(new Animated.Value(1)).current;
  
  const handlePressIn = () => {
    Animated.spring(scale, {
      toValue: 0.98,
      useNativeDriver: true,
    }).start();
  };
  
  const handlePressOut = () => {
    Animated.spring(scale, {
      toValue: 1,
      useNativeDriver: true,
    }).start();
  };
  
  return (
    <Animated.View style={{ transform: [{ scale }] }}>
      <TouchableOpacity
        style={[
          styles.container,
          styles[variant],
          styles[size],
          disabled && styles.disabled,
        ]}
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        disabled={disabled}
      >
        {iconName && iconPosition === 'left' && (
          <Icon name={iconName} style={styles.iconLeft} />
        )}
        <Text style={[
          styles.text,
          styles[`${variant}Text`],
          styles[`${size}Text`],
          disabled && styles.disabledText,
        ]}>
          {title}
        </Text>
        {iconName && iconPosition === 'right' && (
          <Icon name={iconName} style={styles.iconRight} />
        )}
      </TouchableOpacity>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 12,
  },
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
  small: {
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
  },
  medium: {
    paddingVertical: spacing.sm,
    paddingHorizontal: spacing.md,
  },
  large: {
    paddingVertical: spacing.md,
    paddingHorizontal: spacing.lg,
  },
  disabled: {
    backgroundColor: colors.text.disabled,
    borderColor: colors.text.disabled,
  },
  text: {
    fontFamily: typography.fontFamily,
    fontWeight: typography.fontWeights.medium,
  },
  primaryText: {
    color: colors.text.onHighlight,
  },
  secondaryText: {
    color: colors.text.primary,
  },
  outlineText: {
    color: colors.primary,
  },
  smallText: {
    fontSize: typography.sizes.body,
  },
  mediumText: {
    fontSize: typography.sizes.body,
  },
  largeText: {
    fontSize: typography.sizes.bodyLarge,
  },
  disabledText: {
    color: colors.text.primary,
  },
  iconLeft: {
    marginRight: spacing.xs,
  },
  iconRight: {
    marginLeft: spacing.xs,
  },
});
```

### Card Component

#### V1 Card
```typescript
// V1 Card
const Card = ({ children, style }) => {
  return (
    <View style={[styles.card, style]}>
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: 'white',
    borderRadius: 8,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
});
```

#### V2 Card
```typescript
// V2 Card
import { colors, spacing, elevation } from '../../constants/design-tokens';

interface CardProps {
  children: React.ReactNode;
  variant?: 'standard' | 'elevated' | 'bubble';
  interactive?: boolean;
  selected?: boolean;
  style?: ViewStyle;
  onPress?: () => void;
}

const Card: React.FC<CardProps> = ({
  children,
  variant = 'standard',
  interactive = false,
  selected = false,
  style,
  onPress,
}) => {
  // Animation for interactive feedback
  const scale = useRef(new Animated.Value(1)).current;
  
  const handlePressIn = () => {
    if (interactive) {
      Animated.spring(scale, {
        toValue: 0.98,
        useNativeDriver: true,
      }).start();
    }
  };
  
  const handlePressOut = () => {
    if (interactive) {
      Animated.spring(scale, {
        toValue: 1,
        useNativeDriver: true,
      }).start();
    }
  };
  
  const CardComponent = interactive ? TouchableOpacity : View;
  
  return (
    <Animated.View
      style={[
        { transform: [{ scale }] },
        interactive && styles.interactive,
      ]}
    >
      <CardComponent
        style={[
          styles.card,
          styles[variant],
          selected && styles.selected,
          style,
        ]}
        onPress={interactive ? onPress : undefined}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        activeOpacity={0.9}
      >
        {children}
      </CardComponent>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.neutral.canvasLight,
    borderRadius: 16,
    padding: spacing.md,
    overflow: 'hidden',
  },
  standard: {
    ...elevation.level1,
  },
  elevated: {
    ...elevation.level2,
  },
  bubble: {
    ...elevation.level2,
    borderRadius: 24,
  },
  selected: {
    borderWidth: 2,
    borderColor: colors.primary,
  },
  interactive: {
    cursor: 'pointer',
  },
});
```

## Screen Migration Examples

### Service Selection Screen

#### Key Changes

1. **Visual Design**: Update to use the new color palette, typography, and spacing.
2. **Component Structure**: Use the new component hierarchy and organization.
3. **Animation**: Add animations for transitions and interactions.
4. **Gamification**: Integrate XP and token elements.

#### Implementation Steps

1. Create the screen wrapper using the new design system.
2. Implement the service grid using the new Card and Typography components.
3. Add animations for card selection and screen transitions.
4. Integrate gamification elements (XP for browsing, tokens for special services).
5. Implement error handling and loading states using the new system.

## Testing Migration

### Component Testing

- Test each migrated component in isolation.
- Verify visual appearance matches the design system.
- Test all interactive states (hover, press, disabled).
- Verify animations and transitions work as expected.

### Integration Testing

- Test components together in screens.
- Verify data flow and component communication.
- Test navigation between screens.
- Verify gamification elements work correctly.

### Visual Regression Testing

- Compare V1 and V2 screens to ensure functionality is preserved.
- Verify the new design enhances rather than detracts from usability.

## Common Migration Challenges

### Challenge: Maintaining State During Migration

**Solution**: Use adapter patterns to bridge V1 state management with V2 components.

### Challenge: Ensuring Consistent Visual Design

**Solution**: Create a comprehensive design token system and component library.

### Challenge: Handling Deprecated APIs

**Solution**: Create wrapper functions to abstract API changes.

### Challenge: Managing Technical Debt

**Solution**: Prioritize clean architecture in V2 to avoid accumulating new technical debt.

## Conclusion

Migrating from ZinApp V1 to V2 is a significant undertaking, but with a systematic approach, it can be accomplished efficiently. By reusing core logic while rebuilding the visual layer, we can create a more engaging, maintainable, and scalable application that meets the new brand vision.
