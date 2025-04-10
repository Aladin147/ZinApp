# ZinApp V2 File Structure

This document outlines the file structure and organization for ZinApp V2.

## Overview

ZinApp V2 follows a modular, organized file structure to ensure maintainability, scalability, and clear separation of concerns. The structure is designed to support the new visual design, gamification features, and improved architecture.

## Root Directory Structure

```
/zinapp
├── /assets            # Static assets
│   ├── /icons         # Icon assets
│   ├── /illustrations # Illustration assets
│   ├── /animations    # Lottie and Rive animations
│   └── /images        # Image assets
├── /components        # Reusable UI components
│   ├── /ui            # Basic UI components
│   └── /layout        # Layout components
├── /constants         # App-wide constants
│   └── /design-tokens # Design tokens and theme
├── /lib               # Application logic
│   ├── /game_logic    # Gamification system logic
│   └── /token_engine  # Token and rewards logic
├── /mock-api          # Mock API server for development
├── /screens           # App screens
├── /types             # TypeScript type definitions
├── /navigation        # Navigation configuration
├── /docs              # Documentation files
│   └── /v2            # V2-specific documentation
├── App.tsx            # Main app component
└── README.md          # Project overview
```

## Detailed Structure

### Components Directory

```
/components
├── /ui                # Basic UI components
│   ├── Button.tsx     # Button component
│   ├── Card.tsx       # Card component
│   ├── Typography.tsx # Typography component
│   ├── Icon.tsx       # Icon component
│   └── ...            # Other UI components
├── /layout            # Layout components
│   ├── ScreenWrapper.tsx  # Screen wrapper component
│   ├── CardWrapper.tsx    # Card wrapper component
│   └── ...                # Other layout components
└── /specific          # Feature-specific components
    ├── StylistCard.tsx    # Stylist card component
    ├── ServiceCard.tsx    # Service card component
    └── ...                # Other specific components
```

### Constants Directory

```
/constants
├── index.ts           # Exports all constants
├── spacing.ts         # Spacing constants
├── /design-tokens     # Design tokens
│   ├── colors.ts      # Color tokens
│   ├── typography.ts  # Typography tokens
│   ├── spacing.ts     # Spacing tokens
│   └── theme.ts       # Theme configuration
└── ...                # Other constants
```

### Lib Directory

```
/lib
├── /game_logic        # Gamification system logic
│   ├── index.ts       # Exports all game logic
│   ├── xp.ts          # XP calculation and management
│   ├── levels.ts      # Level definitions and progression
│   └── rewards.ts     # Reward system logic
├── /token_engine      # Token and rewards logic
│   ├── index.ts       # Exports all token logic
│   ├── tokens.ts      # Token management
│   └── transactions.ts # Token transaction logic
└── /mock_data         # Mock data for development
    ├── users.json     # Mock user data
    ├── stylists.json  # Mock stylist data
    └── services.json  # Mock service data
```

### Screens Directory

```
/screens
├── LandingScreen.tsx  # Landing screen
├── ServiceSelectScreen.tsx # Service selection screen
├── StylistListScreen.tsx   # Stylist list screen
├── BarberProfileScreen.tsx # Barber profile screen
├── BookingScreen.tsx       # Booking screen
├── LiveTrackScreen.tsx     # Live tracking screen
├── Bsse7aScreen.tsx        # Completion screen
└── ...                     # Other screens
```

## File Naming Conventions

1. **Components**: PascalCase (e.g., `Button.tsx`, `CardWrapper.tsx`)
2. **Utilities and Hooks**: camelCase (e.g., `useAuth.ts`, `formatDate.ts`)
3. **Constants**: camelCase (e.g., `colors.ts`, `spacing.ts`)
4. **Screens**: PascalCase with Screen suffix (e.g., `LandingScreen.tsx`)
5. **Types**: PascalCase with type-specific suffix (e.g., `UserType.ts`, `ApiResponse.ts`)

## Import Conventions

1. Use relative imports for files in the same directory or subdirectories
2. Use absolute imports for files in different directories
3. Group imports in the following order:
   - React and React Native imports
   - Third-party library imports
   - Absolute imports from the project
   - Relative imports

Example:
```typescript
// React and React Native imports
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';

// Third-party library imports
import { useNavigation } from '@react-navigation/native';
import { LinearGradient } from 'expo-linear-gradient';

// Absolute imports from the project
import { colors, spacing } from '../constants';
import { Button, Typography } from '../components';

// Relative imports
import { formatPrice } from './utils';
```

## Mandatory File Structure Rules

1. All UI components must go inside `/components/ui/`
2. Shared layout wrappers (ScreenWrapper, CardWrapper) must go in `/components/layout/`
3. Design tokens and constants must only live inside `/constants/design-tokens.ts`
4. Illustration and icon assets must be placed in `/assets/illustrations/` and `/assets/icons/`
5. Game logic must live in `/lib/game_logic/`
6. Demo token logic must be in `/lib/token_engine/`

## Component Structure

Each component should follow this structure:

```typescript
import React from 'react';
import { View, StyleSheet } from 'react-native';
import { colors, spacing } from '../constants';

// Define component props
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

// Component styles
const styles = StyleSheet.create({
  container: {
    // Base styles
  },
  primary: {
    // Primary variant styles
  },
  secondary: {
    // Secondary variant styles
  },
  // Other styles
});

export default Button;
```
