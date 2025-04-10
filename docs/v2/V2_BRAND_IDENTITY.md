# ZinApp V2 Brand Identity

This document outlines the brand identity for ZinApp V2, including colors, typography, iconography, and design tokens.

## Brand Vision

ZinApp V2 is positioned as a flagship product representing the edge of design, gamification, and user-centric experience in our market. The visual identity moves away from the flat, corporate, outdated feel of V1 toward a gamified, joyful UI energy with dynamic layering, depth, and visual feedback.

## Color System

### Primary Colors

- **#D2FF4D** → Highlight / CTA / Logo
  - Always used to indicate energy, currency, or reward system actions
  - Primary visual identifier for the brand
  - Used for call-to-action buttons, highlights, and the logo

- **#232D30** → Official Background / Base Dark
  - Used across screens as primary background for depth and polish
  - Provides contrast for content and highlights
  - Creates a sophisticated, premium feel

### Accent & Secondary Tokens

These tokens should be accessed via token categories rather than hardcoded hex values:

- **neutral.canvasLight**: Range from #F8F3ED to #FCFBF9
  - Used for light backgrounds, cards, and panels
  - Provides contrast against the dark background

- **neutral.canvasDark**: #232D30
  - Used for dark backgrounds and containers
  - Creates depth and hierarchy

- **accent.coolBlue**: #8CBACD
  - Used for stylist interactions and secondary highlights
  - Provides a cool, calming contrast to the energetic primary color

- **accent.coral**: #F4805D
  - Used for warmth, celebration, and confirmations
  - Adds emotional warmth to the interface

- **accent.jadeLight**: #C3FFC2
  - Used as contextual success highlights
  - Indicates positive actions and confirmations

### Font Color Logic

| Use Case | Token / Color | Usage Logic |
|----------|---------------|-------------|
| Primary Text | text.primary (#FCFBF9) | Base reading color on dark backgrounds |
| Secondary Text | text.secondary (#B7C0C9) | Descriptions, meta, captions |
| Inverted Text | text.inverted (#232D30) | Used when background is cream or yellow (light canvas) |
| CTA Text | text.onHighlight (#232D30) | Applied on yellow #D2FF4D buttons to ensure readability |
| Disabled/Muted | text.disabled (#7A848C) | For low priority/inactive UI elements |
| Link / Interactive | text.link (#8CBACD) | Underlines or hover interactions |
| Token Values / Prices | text.token (#D2FF4D) | Always in yellow, bold, animated where applicable |

**Important**: Fonts and colors must always follow adaptive contrast based on screen mode. Ensure no hardcoding and validate against the WCAG AA accessibility rules.

## Typography System

### Font Family

Use a modern sans-serif font:
- Urbanist
- Nunito
- Inter

### Type Scale

- **Headings**:
  - Headline Large: 28px
  - Headline Medium: 24px
  - Headline Small: 20px

- **Body**:
  - Body Default: 16px
  - Caption/Meta: 13-14px
  - CTA Buttons: Uppercase or bold, 16-18px

### Font Weights

- Regular (400)
- Medium (500)
- Bold (700)

### Line Heights

- Headings: 1.2-1.3x font size
- Body: 1.5x font size
- Buttons: 1.2x font size

## Iconography

### Style

- Flat, outlined or filled with soft edges
- Consistent stroke weight
- Rounded corners
- Simple, clear shapes

### Sizing

- Standard 20-24px
- Match text cap height for inline icons
- Larger (32-48px) for feature icons

### Positioning

- Vertically aligned to center of adjacent text
- Consistent padding from text (8-10px)
- Centered in containers

### Icon Sets

- Prefer Lucide or Heroicons
- Custom icons should match the style of the chosen set

## Animation & Motion

### Loading & Splash Animations

- Splash animation: Code-based prototype for now
- Target: Full animation (Lottie or Rive) for enhanced demo
- Duration: 2.5-3s max, transitions directly into onboarding or home
- Palette: #D2FF4D, #8CBACD, white text, dark background

### Interaction Animations

- Button presses: Subtle scale (0.95-0.98) with quick spring return
- Transitions: Smooth, with 300-500ms duration
- Card hovers: Subtle elevation increase
- List items: Subtle background color change on hover/press

## Error & Alert Styling

- Use coral #F4805D for alerts
- Contextually choose background to balance brightness
- Avoid flat red unless necessary for destructive actions
- All alerts use rounded cards or toasts with elevation

## Design Token Implementation

- Use Flutter Theme extension with design tokens stored in theme.dart
- Colors, padding, spacing defined via static maps or token extension
- Follow naming convention: AppColors.primaryHighlight, AppTextStyles.headlineLarge

## Design Principles

1. **Depth & Layering**: Use shadows, elevation, and layering to create a sense of depth and hierarchy.

2. **Rounded Corners**: All UI elements should have rounded corners for a friendly, approachable feel.

3. **Generous Padding**: Use ample padding to create breathing room and improve readability.

4. **Visual Feedback**: Every interaction should have clear visual feedback.

5. **Consistent Spacing**: Use a consistent spacing system throughout the application.

6. **Expressive Typography**: Use typography to create clear hierarchy and improve readability.

7. **Playful Animations**: Use subtle animations to add personality and improve user experience.

8. **Gamification Elements**: Integrate gamification elements like XP, levels, and rewards throughout the UI.
