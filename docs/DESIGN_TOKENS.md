# ZinApp Design Tokens

## 🎨 Purpose

Centralizes all colors, typography sizes, spacing units, and motion rules to create consistent UI across the app and help both devs and designers reference implementation-safe values.

---

## 🎨 Color Palette (Glovo-inspired)

| Token         | Value       | Purpose                                 |
|---------------|-------------|----------------------------------------|
| `primary`     | `#FF5E5B`   | Primary CTA, buttons, highlights, icons |
| `secondary`   | `#F8F3ED`   | Background, card backdrops              |
| `cream`       | `#FCFBF9`   | Panel sections, forms                   |
| `textSlate`   | `#3C3C3C`   | Body text, titles, icons                |
| `stylistBlue` | `#00C1B2`   | Avatar outlines, stylist-specific chips |
| `accent1`     | `#FFBD00`   | Glovo-like yellow accent               |
| `accent2`     | `#7B68EE`   | Playful purple accent                   |
| `success`     | `#4CAF50`   | Success states, completed               |
| `info`        | `#2196F3`   | Information, notifications              |
| `warning`     | `#FFC107`   | Warning states, alerts                  |
| `error`       | `#F44336`   | Error states, destructive               |
| `bgLight`     | `#FCFBF9`   | Light backgrounds                       |
| `bgDark`      | `#1C1C1E`   | Dark backgrounds                        |
| `warmSand`    | `#F8F3ED`   | Warm backgrounds, cards                 |
| `textPrimary` | `#3C3C3C`   | Headlines, primary text                 |
| `textMuted`   | `#7A7A7A`   | Secondary text, captions                |
| `gray100`     | `#F5F5F5`   | Lightest gray              |
| `gray200`     | `#EEEEEE`   | Light gray                 |
| `gray300`     | `#E0E0E0`   | Medium light gray          |
| `gray400`     | `#BDBDBD`   | Medium gray                |
| `gray500`     | `#9E9E9E`   | Medium dark gray           |
| `gray600`     | `#757575`   | Dark gray                  |
| `gray700`     | `#616161`   | Darker gray                |
| `gray800`     | `#424242`   | Very dark gray             |
| `gray900`     | `#212121`   | Almost black               |

---

## 🔠 Typography (Playful & Friendly)

| Token           | Size (px) | Weight    | Line Height | Letter Spacing | Use                       |
|-----------------|-----------|-----------|-------------|----------------|---------------------------|
| `screenTitle`   | `28px`    | bold      | `36px`      | `-0.5px`       | Screen headers            |
| `heading`       | `22px`    | bold      | `30px`      | `-0.5px`       | Large headings            |
| `sectionHeader` | `18px`    | bold      | `24px`      | `-0.25px`      | Card titles, small blocks |
| `subheading`    | `16px`    | bold      | `24px`      | `0px`          | Subheadings               |
| `body`          | `15px`    | regular   | `22px`      | `0px`          | Descriptive text, labels  |
| `bodyMedium`    | `15px`    | medium    | `22px`      | `0px`          | Emphasized body text      |
| `bodyBold`      | `15px`    | bold      | `22px`      | `0px`          | Important body text       |
| `button`        | `16px`    | medium    | `20px`      | `0px`          | Button labels             |
| `caption`       | `13px`    | regular   | `18px`      | `0px`          | Labels, taglines          |
| `captionMedium` | `13px`    | medium    | `18px`      | `0px`          | Emphasized small text     |

### Font Family

Primary font: **Uber Move** (fallback: Inter/Satoshi/SF Pro)

```typescript
fontFamily: {
  primary: 'UberMove', // Fallback: 'Inter'
  primaryMedium: 'UberMove-Medium', // Fallback: 'Inter-Medium'
  primarySemiBold: 'UberMove-SemiBold', // Fallback: 'Inter-SemiBold'
  primaryBold: 'UberMove-Bold', // Fallback: 'Inter-Bold'
  mono: 'monospace',
}
```

### Typography Usage Guidelines

- Use `screenTitle` for main screen headers
- Use `heading` for major section titles
- Use `sectionHeader` for card headers and section dividers
- Use `subheading` for subsections and list headers
- Use `body` for general text content
- Use `bodyMedium` for emphasized text within paragraphs
- Use `bodyBold` for important information that needs to stand out
- Use `button` for all button labels
- Use `caption` for supplementary information, labels, and timestamps
- Use `captionMedium` for emphasized captions and form labels

---

## 📐 Spacing Scale

Based on a 4pt grid system (multiples of 4).

| Token    | Value       | Use Case                       |
|----------|-------------|--------------------------------|
| `xxs`    | `4px`       | Minimum spacing, tight layouts |
| `xs`     | `8px`       | Compact spacing               |
| `sm`     | `12px`      | Small spacing                 |
| `md`     | `16px`      | Standard spacing              |
| `lg`     | `24px`      | Large spacing                 |
| `xl`     | `32px`      | Extra large spacing           |
| `xxl`    | `48px`      | Double extra large spacing    |
| `xxxl`   | `64px`      | Triple extra large spacing    |

### Named Spacing

| Token           | Value       | Use Case                           |
|-----------------|-------------|------------------------------------|
| `tight`         | `4px`       | Minimal spacing between elements   |
| `default`       | `8px`       | Default spacing between elements   |
| `loose`         | `16px`      | Generous spacing between sections  |
| `screenMargin`  | `16px`      | Standard margin from screen edge   |
| `gutter`        | `16px`      | Standard gutter between columns    |
| `sectionGap`    | `24px`      | Gap between major sections         |
| `verticalGap`   | `16px`      | Vertical gap between components    |
| `horizontalGap` | `12px`      | Horizontal gap between components  |
| `inlineGap`     | `8px`       | Gap between inline elements        |
| `stackGap`      | `12px`      | Gap between stacked elements       |

### Component-Specific Spacing

| Component | Spacing                                                         |
|-----------|----------------------------------------------------------------|
| Cards     | `16px` padding, `24px` border radius (Glovo-like rounded corners) |
| Buttons   | `16px` horizontal padding, `48px` height (standard), `56px` height (hero), `24px` radius (fully rounded) |
| Inputs    | `12px` padding, `12px` border radius, `8px` gap between elements |
| Headers   | `16px` padding, `56px` height                                   |
| Sections  | `24px` bottom margin                                            |
| Screens   | `16px` horizontal padding                                       |

### Icon Sizes

| Token    | Value       | Use Case                       |
|----------|-------------|--------------------------------|
| `xs`     | `12px`      | Extra small icons              |
| `small`  | `16px`      | Small icons                    |
| `medium` | `24px`      | Medium icons                   |
| `large`  | `32px`      | Large icons                    |
| `xl`     | `40px`      | Extra large icons              |

---

## 🎞️ Motion Tokens

| Token         | Value    | Description                        |
|---------------|----------|------------------------------------|
| `screenTransition` | 200-300ms | Slide + Fade screen transitions    |
| `buttonTap`   | 100ms    | Scale down to 0.95 briefly         |
| `confetti`    | 1000ms   | Booking confirmation animation     |
| `mapPulse`    | 1500ms   | Pulsing animation for map avatars  |
| `fadeIn`      | 400ms    | Appear transitions for cards       |
| `slideUp`     | 500ms    | Bottom sheet animations            |

---

## 🔄 Border Radius

| Token         | Value    | Use Case                           |
|---------------|----------|------------------------------------|
| `xs`          | `4px`    | Small elements, tags               |
| `sm`          | `8px`    | Input fields, small cards          |
| `md`          | `12px`   | Buttons, standard cards            |
| `lg`          | `16px`   | Large cards, modals                |
| `xl`          | `24px`   | Hero cards, featured content       |
| `full`        | `9999px` | Pills, circular elements           |

---

## 🔲 Elevation (Shadows)

| Token         | Values                              | Use Case                 |
|---------------|-------------------------------------|--------------------------|
| `none`        | No shadow                           | Flat elements            |
| `sm`          | `0px 1px 2px rgba(0, 0, 0, 0.05)`  | Subtle elevation         |
| `md`          | `0px 2px 4px rgba(0, 0, 0, 0.1)`   | Cards, buttons           |
| `lg`          | `0px 4px 8px rgba(0, 0, 0, 0.15)`  | Floating elements        |
| `xl`          | `0px 8px 16px rgba(0, 0, 0, 0.2)`  | Modals, popovers         |

> These tokens are implemented in the constants directory and should be used consistently throughout the app.
