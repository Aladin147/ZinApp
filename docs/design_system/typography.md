# ZinApp V2 Typography System

## Font Family

ZinApp V2 uses **Urbanist** as its primary font family. Urbanist is a modern, clean sans-serif typeface that provides excellent readability across different screen sizes and device types.

## Font Weights

| Weight Name | Font Weight | Font File |
|-------------|-------------|-----------|
| Regular | 400 | Urbanist-Regular.ttf |
| SemiBold | 600 | Urbanist-SemiBold.ttf |
| ExtraBold | 800 | Urbanist-ExtraBold.ttf |

## Text Styles

### Headings

| Style Name | Font Size | Line Height | Letter Spacing | Font Weight | Usage |
|------------|-----------|-------------|----------------|-------------|-------|
| `headingLarge` | 28px | 1.3 (36.4px) | -0.5px | ExtraBold (800) | Main screen titles, onboarding headers |
| `headingMedium` | 24px | 1.3 (31.2px) | -0.5px | ExtraBold (800) | Section titles, modal headers |
| `headingSmall` | 20px | 1.3 (26px) | -0.25px | ExtraBold (800) | Card titles, subsection headers |

### Body Text

| Style Name | Font Size | Line Height | Letter Spacing | Font Weight | Usage |
|------------|-----------|-------------|----------------|-------------|-------|
| `bodyLarge` | 18px | 1.5 (27px) | 0px | Regular (400) | Featured content, important paragraphs |
| `body` | 16px | 1.5 (24px) | 0px | Regular (400) | Standard body text, descriptions |
| `bodySmall` | 14px | 1.5 (21px) | 0px | Regular (400) | Secondary information, metadata |
| `caption` | 13px | 1.5 (19.5px) | 0.25px | Regular (400) | Captions, timestamps, fine print |

### Interactive Text

| Style Name | Font Size | Line Height | Letter Spacing | Font Weight | Usage |
|------------|-----------|-------------|----------------|-------------|-------|
| `buttonLarge` | 18px | 1.2 (21.6px) | 0.5px | SemiBold (600) | Large buttons, primary CTAs |
| `buttonMedium` | 16px | 1.2 (19.2px) | 0.5px | SemiBold (600) | Standard buttons |
| `buttonSmall` | 14px | 1.2 (16.8px) | 0.5px | SemiBold (600) | Small buttons, compact CTAs |
| `link` | 16px | 1.5 (24px) | 0px | SemiBold (600) | Hyperlinks, interactive text |

### Special Text

| Style Name | Font Size | Line Height | Letter Spacing | Font Weight | Usage |
|------------|-----------|-------------|----------------|-------------|-------|
| `token` | 16px | 1.2 (19.2px) | 0px | ExtraBold (800) | Token values, gamification elements |

## Typography Mapping to Flutter

ZinApp V2 maps its custom typography to Flutter's `TextTheme` for consistent usage throughout the application:

| ZinApp Style | Flutter TextTheme |
|--------------|-------------------|
| `headingLarge` | `headlineLarge` |
| `headingMedium` | `headlineMedium` |
| `headingSmall` | `headlineSmall` |
| `bodyLarge` | `bodyLarge` |
| `body` | `bodyMedium` |
| `bodySmall` | `bodySmall` |
| `buttonMedium` | `labelLarge` |
| `buttonSmall` | `labelMedium` |
| `caption` | `labelSmall` |

## Typography Usage Guidelines

### Hierarchy

Maintain clear typographic hierarchy by:
- Using only one `headingLarge` per screen as the main title
- Following a logical progression from larger to smaller text styles
- Using weight and size to establish importance
- Avoiding too many different text styles on a single screen

### Readability

Ensure optimal readability by:
- Maintaining sufficient contrast between text and background
- Using appropriate line height for comfortable reading
- Limiting line length to improve readability (especially for body text)
- Using proper text alignment (generally left-aligned for most content)

### Responsive Considerations

Typography should adapt to different screen sizes:
- Consider implementing responsive scaling for extreme screen sizes
- Maintain minimum font sizes for readability (14px for most content)
- Test typography on both small and large devices

## Implementation Notes

The typography system is implemented in Flutter through:
- A static `AppTextStyles` class with text style constants
- The Flutter `TextTheme` for Material Design integration
- Font declarations in the `pubspec.yaml` file

See `lib/app/theme/text_theme.dart` for the implementation details.
