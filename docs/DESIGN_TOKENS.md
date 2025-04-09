# ZinApp Design Tokens

## 🎨 Purpose

Centralizes all colors, typography sizes, spacing units, and motion rules to create consistent UI across the app and help both devs and designers reference implementation-safe values.

---

## 🎨 Color Palette

| Token         | Value       | Purpose                    |
|---------------|-------------|----------------------------|
| `primary`     | `#FF6A33`   | CTA buttons, icons         |
| `secondary`   | `#F8F0E3`   | Secondary buttons, cards   |
| `accent`      | `#8CBACD`   | Stylist-related elements   |
| `success`     | `#4CAF50`   | Success states, completed  |
| `info`        | `#2196F3`   | Information, notifications |
| `warning`     | `#FFC107`   | Warning states, alerts     |
| `error`       | `#F44336`   | Error states, destructive  |
| `bgLight`     | `#FFFFFF`   | Backgrounds (light)        |
| `bgDark`      | `#1C1C1E`   | Backgrounds (dark)         |
| `darkSlate`   | `#2B2B2B`   | Dark backgrounds, headers  |
| `warmSand`    | `#F5E8D3`   | Warm backgrounds, cards    |
| `textPrimary` | `#2B2B2B`   | Headlines, primary text    |
| `textMuted`   | `#7A7A7A`   | Secondary text, captions   |
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

## 🔠 Typography

| Token           | Size (px) | Weight    | Line Height | Letter Spacing | Use                       |
|-----------------|-----------|-----------|-------------|----------------|---------------------------|
| `screenTitle`   | `24px`    | bold      | `32px`      | `-0.5px`       | Main screen titles        |
| `heading`       | `20px`    | bold      | `28px`      | `-0.5px`       | Large headings            |
| `sectionHeader` | `18px`    | bold      | `26px`      | `-0.25px`      | Section headers           |
| `subheading`    | `16px`    | bold      | `24px`      | `0px`          | Subheadings               |
| `body`          | `14px`    | regular   | `20px`      | `0px`          | Standard text             |
| `bodyMedium`    | `14px`    | medium    | `20px`      | `0px`          | Emphasized body text      |
| `bodyBold`      | `14px`    | bold      | `20px`      | `0px`          | Important body text       |
| `button`        | `16px`    | medium    | `20px`      | `0px`          | Button text               |
| `caption`       | `12px`    | regular   | `16px`      | `0px`          | Labels, taglines          |
| `captionMedium` | `12px`    | medium    | `16px`      | `0px`          | Emphasized small text     |

### Font Family

Primary font: **Inter** (as a fallback for Uber Move)

```typescript
fontFamily: {
  primary: 'Inter',
  primaryMedium: 'Inter-Medium',
  primarySemiBold: 'Inter-SemiBold',
  primaryBold: 'Inter-Bold',
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
| Cards     | `16px` padding, `8px` inner padding, `8px` border radius        |
| Buttons   | `16px` horizontal padding, `12px` vertical padding, `8px` radius |
| Inputs    | `12px` padding, `8px` border radius, `8px` gap between elements |
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
| `easeInOut`   | 300ms    | Default screen transitions         |
| `bounce`      | 600ms    | On-tap animations                  |
| `fadeIn`      | 400ms    | Appear transitions for cards       |
| `slideUp`     | 500ms    | Bottom sheet animations            |
| `pulse`       | 1500ms   | Attention-grabbing animations      |

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
