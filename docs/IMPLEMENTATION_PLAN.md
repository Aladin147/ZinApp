# ZinApp Implementation Plan

This document outlines the implementation plan for ZinApp based on the Unified Implementation Plan document. It provides a structured approach to implementing the visual design and user experience of the application.

## 🎯 Current Status

We have completed the following:
- Navigation Flow setup
- Initial screen wiring
- Core screen shell logic
- Initial font and color token creation
- Typography system implementation with Inter font (as fallback for Uber Move)
- Color system with semantic naming and consistent palette
- Spacing system with comprehensive scale and component-specific values

## 🚀 Implementation Phases

### Phase 1: Typography System Refinement (Completed)
- ✅ Create abstract Typography components
- ✅ Replace leftover unstyled `<Text>` components
- ✅ Confirm line-height consistency with visual specs
- ✅ Update DESIGN_TOKENS.md with comprehensive design system documentation
- ✅ Update colors.ts with new color values from the visual guidelines

### Phase 2: Visual Identity Implementation (Current Focus)
- [ ] Update Button component to match specifications:
  - [ ] Radius: 12px
  - [ ] Height: 48px (standard) / 56px (hero)
  - [ ] Filled variant: #F4805D, white text
  - [ ] Outline variant: white fill, #F4805D 2px border
  - [ ] Tap feedback: bounce animation (scale 0.95)
- [ ] Update Card component to match specifications:
  - [ ] Radius: 16px
  - [ ] Inner padding: 16px
  - [ ] Shadow: none (flat design)
- [ ] Update Avatar component:
  - [ ] Size: 48px
  - [ ] Radius: 20px
  - [ ] Badging: Cool Blue Slate border + optional verified icon
- [ ] Create color showcase screen for testing
- [ ] Implement consistent elevation (shadows) across components
- [ ] Refine screen layouts with enhanced spacing system

### Phase 3: Animation & Interaction Implementation
- [ ] Add FadeIn or SlideIn animations to:
  - [ ] CTA block on Landing
  - [ ] Stylist list render
  - [ ] Booking success screen
- [ ] Add bounce animation on primary button press
- [ ] Add shimmer placeholder on stylist cards while loading
- [ ] Implement screen transitions:
  - [ ] Slide + Fade (200-300ms)
- [ ] Implement button tap animation:
  - [ ] Scale down to 0.95 briefly
- [ ] Implement booking confirmation animation:
  - [ ] Confetti animation
- [ ] Implement map avatar animation:
  - [ ] Pulse animation (location)

### Phase 4: Component Identity Pass
- [ ] Verify that all screens use:
  - [ ] Typography tokens
  - [ ] Correct avatar, icon, and button components
  - [ ] Proper layout grid spacing
- [ ] Style StylistCard, ServiceCard, Avatar, CTAButton, etc. to be production-grade visuals
- [ ] Confirm consistent corner radii and icon alignment
- [ ] Implement proper error states and loading indicators

### Phase 5: Final Polish & Documentation
- [ ] Update journal.md to cover visual polish and animation tasks
- [ ] Document added animation interactions in ANIMATION_INTERACTION_SYSTEM.md
- [ ] Perform final visual QA across all screens
- [ ] Ensure consistent application of design tokens across all components
- [ ] Test on multiple device sizes to ensure responsive design

## 🎨 Visual Identity Requirements

### Color Palette
| Role                      | Color Code     | Usage Area                              |
|---------------------------|----------------|------------------------------------------|
| Primary CTA / Accent      | `#F4805D`      | Buttons, highlights, icons (main color) |
| Background                | `#F8F3ED`      | Screens, card backdrops                 |
| Secondary Cream           | `#FCFBF9`      | Panel sections, forms                   |
| Text / Foreground Slate   | `#3C3C3C`      | Body text, titles, icons                |
| Stylist Accent (Cool Blue)| `#8CBACD`      | Avatar outlines, stylist-specific chips |

### Typography System
| Type           | Size | Weight   | Use                                  |
|----------------|------|----------|---------------------------------------|
| ScreenTitle    | 24px | Bold     | Screen headers                        |
| SectionHeader  | 18px | Bold     | Card titles, small blocks             |
| BodyText       | 14px | Regular  | Descriptive text, labels              |
| ButtonText     | 16px | Medium   | Button labels                         |

### Layout Guidelines
- Spacing system: 4pt grid only
- Outer margins: 16px
- Section spacing: 24px
- Always wrap screens with ScreenWrapper
- Avoid inline styling. All layout to use Tailwind classes or tokens

## 📋 Implementation Checklist

For each component we update, we should ensure:
1. It uses the correct typography tokens
2. It uses the correct color tokens
3. It uses the correct spacing tokens
4. It has the correct border radius
5. It has the correct animations
6. It is responsive and works on different device sizes
7. It is accessible and has proper contrast

## 🧪 Testing Strategy

For each phase:
1. Test on multiple device sizes
2. Test in light and dark mode (if applicable)
3. Test with different content lengths
4. Test animations and interactions
5. Test accessibility features

## 📝 Documentation Updates

After each phase, update:
1. journal.md with progress
2. ANIMATION_INTERACTION_SYSTEM.md with any new animations
3. DESIGN_TOKENS.md with any updates to the design system
