# ZinApp UI Implementation Plan

This document outlines the plan to bring the ZinApp UI up to the standard specified in the documentation.

## 1. Theme Implementation

### Create Theme Provider
- [ ] Create `theme/index.ts` to export all theme-related utilities
- [ ] Create `theme/colors.ts` with the color palette from DESIGN_TOKENS.md
- [ ] Create `theme/typography.ts` with the typography system
- [ ] Create `theme/spacing.ts` with the spacing scale
- [ ] Create `theme/motion.ts` with animation constants

### Configure twrnc
- [ ] Create `tailwind.config.js` to extend the default configuration
- [ ] Add custom colors, spacing, and typography from the design tokens
- [ ] Set up a theme provider component to wrap the app

## 2. Core UI Components

### Basic Components
- [ ] Create `components/common/Button.tsx` with primary, secondary, and outline variants
- [ ] Create `components/common/Card.tsx` with proper styling and variants
- [ ] Create `components/common/Avatar.tsx` with size variants and badge support
- [ ] Create `components/common/Typography.tsx` with heading, body, and caption variants

### Components from COMPONENT_MAP.md
- [ ] Create `components/specific/ServiceIconBtn.tsx`
- [ ] Create `components/specific/BarberCard.tsx`
- [ ] Create `components/specific/AvatarBadge.tsx`
- [ ] Create `components/specific/RatingStars.tsx`
- [ ] Create `components/specific/MapTracker.tsx`

### Layout Components
- [ ] Create `components/layout/Screen.tsx` for consistent screen layout
- [ ] Create `components/layout/Header.tsx` for screen headers
- [ ] Create `components/layout/Footer.tsx` for screen footers
- [ ] Create `components/layout/Section.tsx` for content sections

## 3. Screen Enhancements

### Update Screens
- [ ] Update `screens/LandingScreen.tsx` to use the new components and styling
- [ ] Update `screens/ServiceSelectScreen.tsx` to use the new components and styling
- [ ] Update `screens/StylistListScreen.tsx` to use the new components and styling
- [ ] Update `screens/BarberProfileScreen.tsx` to use the new components and styling
- [ ] Update `screens/BookingScreen.tsx` to use the new components and styling
- [ ] Update `screens/LiveTrackScreen.tsx` to use the new components and styling
- [ ] Update `screens/Bsse7aScreen.tsx` to use the new components and styling

## 4. Visual Identity

### Color System
- [ ] Apply the color system consistently across all components
- [ ] Create color utilities for easy access to the color palette
- [ ] Implement dark mode support (if specified in the documentation)

### Typography
- [ ] Set up the typography system with the correct font styles
- [ ] Create typography utilities for easy access to the typography styles
- [ ] Ensure consistent text styling across all screens

### UI Elements
- [ ] Create styled buttons matching the design tokens
- [ ] Create styled cards and containers matching the design tokens
- [ ] Create styled form elements matching the design tokens

## 5. Animation System

### Transitions
- [ ] Implement screen transitions as specified in ANIMATION_INTERACTION_SYSTEM.md
- [ ] Create transition utilities for consistent animations

### Interactions
- [ ] Add animations for button presses
- [ ] Add animations for card interactions
- [ ] Add animations for loading states

### Motion System
- [ ] Implement the motion system described in the documentation
- [ ] Create motion utilities for easy access to the motion system

## Implementation Priority

1. **Theme Implementation** - This is the foundation for all other UI work
2. **Basic UI Components** - These are needed for all screens
3. **Screen Enhancements** - Update screens to use the new components
4. **Visual Identity** - Apply consistent styling across the app
5. **Animation System** - Add animations for a polished user experience

## Timeline Estimate

- Theme Implementation: 1 day
- Core UI Components: 2-3 days
- Screen Enhancements: 2-3 days
- Visual Identity: 1-2 days
- Animation System: 1-2 days

Total: 7-11 days for a complete implementation
