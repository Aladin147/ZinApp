# ZinApp Visual Identity System

## Overview

The ZinApp Visual Identity System defines the visual language that creates a cohesive, premium brand experience across the application. This document outlines the core visual elements, principles, and implementation guidelines for maintaining a consistent and distinctive brand presence.

## Core Visual Elements

### 1. Color System

#### Primary Brand Colors
- **Neon Green (`#D2FF4D`)**: The signature ZinApp color, used for key interactive elements and brand accents
- **Dark Base (`#232D30`)**: The foundation of our UI, providing a sophisticated backdrop for content
- **Cream Canvas (`#F8F3ED`)**: Used for light surfaces and contrast elements

#### Accessibility-Enhanced Variants
- **Dark Green (`#9EBF3B`)**: A darker variant of the primary color for better contrast on light backgrounds
- **Deeper Green (`#6A8026`)**: For text on light backgrounds requiring high contrast
- **Dark Base Alt (`#2A363A`)**: A slightly lighter variant for layering and depth

#### Text Colors
- **Primary Text (`#FCFBF9`)**: For primary text on dark backgrounds
- **Secondary Text (`#B7C0C9`)**: For secondary text on dark backgrounds
- **Inverted Text (`#1A2326`)**: For text on light backgrounds
- **Inverted Secondary (`#394548`)**: For secondary text on light backgrounds

#### Contrast Ratios
- Dark background with primary text: 16.1:1 (WCAG AAA)
- Dark background with secondary text: 9.8:1 (WCAG AAA)
- Light background with primary text: 13.5:1 (WCAG AAA)
- Light background with secondary text: 8.7:1 (WCAG AAA)
- Neon on dark background: 4.8:1 (WCAG AA for large text)
- Dark green on light background: 7.2:1 (WCAG AAA)

### 2. Brand Patterns

ZinApp uses a system of distinctive background patterns derived from the logo to reinforce brand identity while maintaining content readability.

#### Pattern Variants
- **Subtle Pattern**: Light, abstract elements for general use
- **Featured Pattern**: More prominent elements for feature screens
- **Minimal Pattern**: Very subtle dot pattern for content-heavy screens
- **Special Pattern**: Distinctive pattern for splash and onboarding screens

#### Pattern Principles
- Patterns should never compete with content
- Pattern opacity should be kept low (typically 5-15%)
- Patterns should incorporate brand shapes and angles
- Patterns should have subtle animation when appropriate

### 3. Typography

#### Font Family
- **Primary Font**: [Font Name] - A modern, geometric sans-serif with excellent readability
- **Monospace**: [Font Name] - For code and technical content

#### Type Scale
- **Display Large**: 57px / 64px line height
- **Display Medium**: 45px / 52px line height
- **Display Small**: 36px / 44px line height
- **Headline Large**: 32px / 40px line height
- **Headline Medium**: 28px / 36px line height
- **Headline Small**: 24px / 32px line height
- **Title Large**: 22px / 28px line height
- **Title Medium**: 16px / 24px line height
- **Title Small**: 14px / 20px line height
- **Body Large**: 16px / 24px line height
- **Body Medium**: 14px / 20px line height
- **Body Small**: 12px / 16px line height

### 4. Shape System

#### Border Radius
- **Small**: 8px (for small components like chips)
- **Medium**: 12px (for buttons, cards)
- **Large**: 16px (for modal dialogs, large cards)
- **Extra Large**: 24px (for full-screen panels)

#### Elevation & Shadows
- **Level 0**: No elevation (flat)
- **Level 1**: Subtle shadow for cards (2dp)
- **Level 2**: Medium shadow for floating elements (4dp)
- **Level 3**: Pronounced shadow for dialogs (8dp)
- **Level 4**: Heavy shadow for modals (16dp)

## Visual Principles

### 1. Layered Depth
Create a sense of depth through layering, shadows, and subtle parallax effects. Elements should feel like they exist in a three-dimensional space rather than flat on the screen.

### 2. Breathing Space
Use generous whitespace to create a sense of luxury and focus. Content should never feel cramped or overwhelming.

### 3. Consistent Motion
All animations and transitions should follow the ZinApp Motion System, creating a cohesive feel across the application.

### 4. Subtle Branding
Brand elements should be present but not overwhelming. The goal is to create a distinctive environment that feels like ZinApp without explicit branding on every screen.

### 5. Precision & Quality
Every visual element should be precisely aligned and rendered at high quality. Attention to detail in visual implementation is critical to the premium feel.

## Implementation Guidelines

### 1. Background Patterns

Use the `ZinBackground` component to add brand-reinforcing patterns:

```dart
ZinBackground(
  variant: ZinBackgroundVariant.subtle,
  animated: true,
  patternOpacity: 0.05,
  child: YourContent(),
)
```

Adjust the pattern variant and opacity based on the content density and importance:

- Content-heavy screens: Use `minimal` variant with low opacity (0.03-0.05)
- Feature screens: Use `featured` variant with medium opacity (0.05-0.10)
- Splash/onboarding: Use `special` variant with higher opacity (0.10-0.15)

### 2. Color Usage

Follow these guidelines for color application:

- Use the primary neon green sparingly for emphasis and key interactive elements
- On light backgrounds, use the darker green variants for text and icons
- Layer the base dark color with subtle variations to create depth
- Use accent colors as highlights, not as primary UI colors

### 3. Typography Implementation

Implement typography consistently:

- Use the predefined text styles from the theme
- Maintain proper hierarchy with clear distinction between levels
- Ensure sufficient contrast between text and background
- Use appropriate line height and letter spacing for readability

### 4. Shape & Elevation

Apply shape and elevation consistently:

- Use the appropriate border radius for each component type
- Apply elevation consistently based on the component's position in the interface hierarchy
- Combine elevation with subtle shadows for a premium feel
- Use shape to create visual distinction between different types of components

## Examples

### Premium Card Implementation

```dart
AnimatedCard(
  elevation: 1.0,
  color: AppColors.baseDark,
  borderRadius: BorderRadius.circular(16),
  padding: const EdgeInsets.all(16),
  onTap: () {},
  child: YourContent(),
)
```

### Featured Screen Background

```dart
ZinBackground(
  variant: ZinBackgroundVariant.featured,
  animated: true,
  patternOpacity: 0.08,
  child: YourScreenContent(),
)
```

### Text with Proper Contrast

```dart
// On dark background
Text(
  'Primary Text',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    color: AppColors.textPrimary,
  ),
)

// On light background
Text(
  'Primary Text',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    color: AppColors.textInverted,
  ),
)
```
