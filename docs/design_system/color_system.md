# ZinApp V2 Color System

## Core Brand Colors

| Token Name | Hex Value | RGB Value | Description | Usage |
|------------|-----------|-----------|-------------|-------|
| `primaryHighlight` | `#D2FF4D` | `210, 255, 77` | Primary highlight color | CTAs, buttons, logo, interactive elements |
| `baseDark` | `#232D30` | `35, 45, 48` | Base dark color | App background, dark surfaces |

## Accent Colors

| Token Name | Hex Value | RGB Value | Description | Usage |
|------------|-----------|-----------|-------------|-------|
| `coolBlue` | `#8CBACD` | `140, 186, 205` | Cool blue accent | Secondary actions, links, accents |
| `coral` | `#F4805D` | `244, 128, 93` | Coral accent | Errors, warnings, engagement indicators |
| `jadeLight` | `#C3FFC2` | `195, 255, 194` | Jade light accent | Success states, positive indicators |

## Canvas Colors

| Token Name | Hex Value | RGB Value | Description | Usage |
|------------|-----------|-----------|-------------|-------|
| `canvasLight` | `#F8F3ED` | `248, 243, 237` | Light canvas | Light mode backgrounds, cards |
| `canvasLightAlt` | `#FCFBF9` | `252, 251, 249` | Light canvas alternate | Light mode alternate surfaces |

## Text Colors

| Token Name | Hex Value | RGB Value | Description | Usage |
|------------|-----------|-----------|-------------|-------|
| `textPrimary` | `#FCFBF9` | `252, 251, 249` | Primary text on dark | Main text on dark backgrounds |
| `textSecondary` | `#B7C0C9` | `183, 192, 201` | Secondary text on dark | Secondary text on dark backgrounds |
| `textInverted` | `#232D30` | `35, 45, 48` | Text on light backgrounds | Text on light surfaces |
| `textOnHighlight` | `#232D30` | `35, 45, 48` | Text on highlight | Text on primaryHighlight |
| `textDisabled` | `#7A848C` | `122, 132, 140` | Disabled text | Disabled states |
| `textLink` | `#8CBACD` | `140, 186, 205` | Link text | Hyperlinks, interactive text |
| `textToken` | `#D2FF4D` | `210, 255, 77` | Token text | Token values, gamification elements |

## Semantic Colors

| Token Name | Description | Usage |
|------------|-------------|-------|
| `success` | Success states | Same as jadeLight |
| `warning` | Warning states | Amber/orange variant |
| `error` | Error states | Same as coral |
| `info` | Information states | Same as coolBlue |

## Color Usage Guidelines

### Accessibility Considerations

All color combinations in the ZinApp V2 design system have been tested for accessibility compliance:

- Text on dark backgrounds (baseDark) uses high-contrast colors (textPrimary, primaryHighlight)
- Text on light backgrounds (canvasLight) uses dark colors (textInverted)
- Interactive elements maintain a minimum contrast ratio of 4.5:1 for normal text and 3:1 for large text
- Error states use the coral color which meets accessibility requirements for error messaging

### Color Combinations

**Primary Button:**
- Background: primaryHighlight (#D2FF4D)
- Text: textOnHighlight (#232D30)

**Secondary Button:**
- Background: transparent
- Border: primaryHighlight (#D2FF4D)
- Text: primaryHighlight (#D2FF4D)

**Cards on Dark Background:**
- Background: baseDark (#232D30) with slight elevation
- Text: textPrimary (#FCFBF9)
- Accents: primaryHighlight (#D2FF4D), coolBlue (#8CBACD)

**Cards on Light Background:**
- Background: canvasLight (#F8F3ED)
- Text: textInverted (#232D30)
- Accents: primaryHighlight (#D2FF4D), coral (#F4805D)

### Dark Mode vs Light Mode

ZinApp V2 is primarily designed for dark mode, with the baseDark color as the main background. However, the color system supports light mode through the canvasLight colors and appropriate text color inversions.

## Implementation Notes

The color system is implemented in Flutter through:
- A static `AppColors` class with color constants
- The Flutter `ColorScheme` for Material Design integration
- Custom theme extensions for additional semantic colors

See `lib/app/theme/color_scheme.dart` for the implementation details.
