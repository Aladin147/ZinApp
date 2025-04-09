# ZinApp Visual Guidelines

This document provides comprehensive visual guidelines for ZinApp, based on the audit requirements and design specifications. It serves as the definitive reference for all visual aspects of the application.

## 🎨 Brand Identity

ZinApp's design system is not generic. It is a refined, culturally grounded visual identity with specific tone and purpose:

- **Youthful but mature, modern but warm, premium but not sterile.**
- Colors and layout are meant to evoke trust, clarity, and delight.
- UI must feel like it belongs in the Glovo/Uber/Postmates product family — not LinkedIn.

## 🎨 Color Palette (Strict Enforcement)

| Role | Color Code | Usage Area |
|------|------------|------------|
| Primary CTA / Accent | #F4805D | Buttons, highlights, icons (main color) |
| Background | #FEF1D8 | Screens, card backdrops |
| Secondary Cream | #FFFAF2 | Panel sections, forms |
| Text / Foreground Slate | #3C3C3C | Body text, titles, icons |
| Stylist Accent (Cool Blue) | #8CBACD | Avatar outlines, stylist-specific chips |

### Color Usage Guidelines

- **Primary Coral (#F4805D)**: Use for primary CTAs, important highlights, and key interactive elements. This color should be the most prominent accent in the app.
- **Background (#FEF1D8)**: Use for screen backgrounds and card backdrops. This warm, creamy color provides a soft, inviting foundation.
- **Secondary Cream (#FFFAF2)**: Use for panel sections, forms, and secondary elements. This lighter cream color provides subtle contrast against the background.
- **Text/Foreground Slate (#3C3C3C)**: Use for all text elements, including titles, body text, and icons. This dark slate color provides good readability against the light backgrounds.
- **Stylist Accent (Cool Blue) (#8CBACD)**: Primarily for stylist-related elements, such as avatar outlines, stylist-specific chips, and stylist-related icons. Can be used very sparingly elsewhere if needed.

### Color Restrictions

- Do NOT use generic greens or blues for primary actions.
- Cool Blue (#8CBACD) should be used primarily for stylist-related components, but can be used very sparingly elsewhere if needed.
- Primary CTA must always be Coral (#F4805D).
- Avoid grayscale-themed backgrounds and borders.

## 👤 Typography System

| Type | Size | Weight | Use |
|------|------|--------|-----|
| ScreenTitle | 24px | Bold | Screen headers |
| SectionHeader | 18px | Bold | Card titles, small blocks |
| BodyText | 14px | Regular | Descriptive text, labels |
| ButtonText | 16px | Medium | Button labels |

### Font Family

- **Primary Font**: Uber Move
- **Fallback Fonts**: Inter, Satoshi

### Typography Guidelines

- Do NOT hardcode font sizes or weights. Use reusable typography components only.
- Maintain consistent line heights (approximately 1.4-1.5x the font size).
- Use appropriate letter spacing for different text sizes (tighter for larger text, normal for body text).
- Ensure sufficient contrast between text and background colors.

## 🪩 Visual Dynamics (Layout, Feel, Polish)

Every screen must reflect this spirit:

- **Rounded, friendly corners**:
  - Cards: 16px
  - Buttons: 20px
  - Sections: 24px bottom corners

- **Fullscreen visual contrast**:
  - Hero blocks with background fill
  - Clear visual hierarchy between sections

- **Minimal, flat cards with breathing room**:
  - 16px outer margin
  - 12px inner padding
  - No box shadows unless subtle and purposeful

- **Color Usage**:
  - Use Cool Blue accents strictly for stylist-related components
  - Primary CTA always coral, bouncy, and full-width

## 🧱 Sectional Structure (Hero > Body > CTA)

### Hero Block
- Start each screen with a Hero Block:
  - Coral background (#F4805D)
  - Centered icon (24–36px)
  - ScreenTitle below (24px Bold)

### Body Components
- Must follow vertical rhythm with consistent margin and spacing grid (4pt system)
- Maintain consistent spacing between sections (24px)
- Use cards for content grouping with consistent styling

### Call to Action
- End with primary CTA and potential secondary actions (e.g., 'Skip', 'Back')
- Primary CTA should be full-width, coral, and have a bounce animation on tap
- Secondary actions should be visually distinct but less prominent

## 🎯 Components Visual Language

### Buttons
- Full-width, 48–56px height, 20px radius, solid fill
- Primary buttons: Coral (#F4805D)
- Bounce animation on tap (scale down to 0.95 briefly)
- Text: 16px Medium, centered

### Cards
- Flat, 16px radius, no shadows, Cream background (#FFFAF2)
- 12px inner padding, 16px outer margin
- Consistent spacing between card elements (12px)

### Avatars
- Fully rounded, blue outline for verified (#8CBACD)
- 40–56px sizing
- Consistent styling across the app

### Section Headers
- Optional icon + title, placed in hero or card header
- 18px Bold, consistent spacing above and below

### Lists
- Use cards per entry, 12px spacing in between
- Consistent styling for all list items

## 🧩 Iconography Rules

- Emoji icons preferred for service select (✂️, 💈, 🧔) if aligned with brand mood
- Otherwise, flat custom icons with 2px stroke, adaptive color tint (Coral/Blue)
- Avoid drop shadows, 3D effects, or inconsistent stroke weights
- Icon sizes should be consistent (24px for standard icons, 16px for small icons)

## 🎥 Animation System

Use Moti, Reanimated, or Lottie:

| Element | Animation Type |
|---------|---------------|
| Screen Transition | Slide + Fade (200-300ms) |
| Button Tap | Scale down to 0.95 briefly |
| Booking Confirmation | Confetti animation |
| Map Avatar | Pulse animation (location) |

### Animation Guidelines

- Keep animations subtle and purposeful
- Use consistent timing and easing curves
- Ensure animations don't interfere with usability
- Provide visual feedback for user interactions

## 📏 Spacing System

- Based on a 4pt grid system
- All spacing values should be multiples of 4pt
- Consistent spacing between elements:
  - 8px between related elements
  - 16px between sections
  - 24px between major sections
- Maintain consistent vertical rhythm throughout the app

## 🧪 Implementation Requirements

- Every `<Text>` element must be wrapped in a typography component
- Use design tokens for all colors, spacing, and typography
- Follow the sectional structure for all screens
- Implement proper animations for all interactions
- Use consistent styling for all components

By following these guidelines, we ensure a consistent, high-quality user experience that reflects ZinApp's brand identity and meets the audit requirements.
