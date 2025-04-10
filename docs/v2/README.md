# ZinApp V2 Development

This directory contains documentation for the V2 development of ZinApp. V2 represents a significant evolution from V1, with major changes to brand identity, visual design, code structure, and the addition of gamification elements.

## Current Status

V2 is in the active development phase. We have received the official memo outlining the new direction and requirements for ZinApp V2.

## Documentation Structure

Based on the V2 memo, our documentation includes:

- **V2_BRAND_IDENTITY.md**: Documentation of the new brand identity, colors, typography, and design tokens
- **V2_ARCHITECTURE.md**: Overview of the new architecture and design patterns
- **V2_COMPONENT_SYSTEM.md**: Documentation of the UI component system and visual design principles
- **V2_GAMIFICATION.md**: Details of the gamification system implementation
- **V2_FILE_STRUCTURE.md**: Guidelines for file organization and structure
- **V2_PROGRESS_JOURNAL.md**: Ongoing record of development progress and decisions
- **V2_MIGRATION_GUIDE.md**: Guide for migrating components and functionality from V1

## Development Approach

Based on the V2 memo, our development approach follows these principles:

1. **Reuse Logic Where Possible**: We'll preserve and adapt functional logic from V1 where appropriate.

2. **Redesign and Refactor Components**: We'll rebuild UI components to match the new design system and brand identity.

3. **Rebuild Screens with New Layout Philosophy**: We'll implement screens with the new visual approach focusing on depth, padding, and smoothness.

4. **Move Toward Modularity and Fluid Responsiveness**: We'll ensure the application is modular and responsive across different devices.

5. **Implement Gamification**: We'll integrate the new gamification system with XP, tiers, and Zin tokens.

6. **Enhance Visual Feedback**: We'll add animations and transitions to improve user interaction and feedback.

## Key Brand Identity Elements

### Primary Colors
- **#D2FF4D**: Highlight / CTA / Logo (for energy, currency, or reward system actions)
- **#232D30**: Official Background / Base Dark (primary background for depth and polish)

### Typography
- Modern sans-serif font (e.g., Urbanist, Nunito, or Inter)
- Headings: 28px / 24px / 20px tiers
- Body: 16px default
- Caption/meta: 13–14px
- CTA Buttons: Uppercase or bold, 16–18px
- Weight hierarchy: Regular (400) / Medium (500) / Bold (700) only

### Iconography
- Style: Flat, outlined or filled with soft edges
- Sizing: Standard 20–24px, matching text cap height
- Positioning: Vertically aligned to center of adjacent text
- Padding: 8–10px from adjacent elements
- Sets: Prefer Lucide or Heroicons, or custom match

## Getting Started

To contribute to ZinApp V2 development:

1. Clone the repository and checkout the V2-Dev branch
2. Review the documentation in the docs/v2 directory
3. Follow the file structure guidelines in V2_FILE_STRUCTURE.md
4. Use the design tokens and components as specified in V2_BRAND_IDENTITY.md and V2_COMPONENT_SYSTEM.md

## V1 Reference

The final state of V1 is preserved in the `master` branch. While V2 represents a significant departure from V1 in terms of visual design and structure, some functional logic from V1 may be adapted and reused in V2.
