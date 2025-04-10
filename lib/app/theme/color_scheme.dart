import 'package:flutter/material.dart';

// Define core V2 colors as constants
abstract class AppColors {
  static const Color primaryHighlight = Color(0xFFD2FF4D); // Highlight / CTA / Logo
  static const Color baseDark = Color(0xFF232D30); // Official Background / Base Dark

  // Accent & Secondary Tokens (Direct Hex for simplicity in this file)
  // In a more complex system, these might be part of a custom ThemeExtension
  static const Color canvasLight = Color(0xFFF8F3ED); // Example from range
  static const Color canvasLightAlt = Color(0xFFFCFBF9); // Example from range
  static const Color coolBlue = Color(0xFF8CBACD); // accent.coolBlue
  static const Color coral = Color(0xFFF4805D); // accent.coral
  static const Color jadeLight = Color(0xFFC3FFC2); // accent.jadeLight

  // Text Colors (Direct Hex for simplicity)
  static const Color textPrimary = Color(0xFFFCFBF9); // On dark backgrounds
  static const Color textSecondary = Color(0xFFB7C0C9); // On dark backgrounds
  static const Color textInverted = Color(0xFF232D30); // On light backgrounds
  static const Color textOnHighlight = Color(0xFF232D30); // On primaryHighlight background
  static const Color textDisabled = Color(0xFF7A848C);
  static const Color textLink = Color(0xFF8CBACD); // Same as coolBlue
  static const Color textToken = Color(0xFFD2FF4D); // Same as primaryHighlight
}

// Define the Flutter ColorScheme based on AppColors
const zinappColorScheme = ColorScheme(
  brightness: Brightness.dark, // Base theme is dark

  primary: AppColors.primaryHighlight, // Main interactive color
  onPrimary: AppColors.textOnHighlight, // Text/icons on primary color

  secondary: AppColors.coolBlue, // Secondary actions, highlights
  onSecondary: AppColors.textInverted, // Text/icons on secondary color

  error: AppColors.coral, // Error indication
  onError: AppColors.textInverted, // Text/icons on error color

  background: AppColors.baseDark, // Default screen background
  onBackground: AppColors.textPrimary, // Default text color on background

  surface: AppColors.baseDark, // Default surface color for cards, dialogs etc. (can be overridden)
  onSurface: AppColors.textPrimary, // Default text color on surface

  // --- Less commonly used, provide sensible defaults ---
  surfaceVariant: Color(0xFF303A3E), // Slightly lighter dark surface
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textDisabled,
  outlineVariant: Color(0xFF505A5E),
  shadow: Colors.black,
  scrim: Colors.black.withOpacity(0.5),
  inverseSurface: AppColors.canvasLight, // For elements needing light bg
  onInverseSurface: AppColors.textInverted,
  inversePrimary: AppColors.baseDark, // Contrasting color for primary on light bg
  primaryContainer: AppColors.primaryHighlight, // Usually same as primary
  onPrimaryContainer: AppColors.textOnHighlight,
  secondaryContainer: AppColors.coolBlue, // Usually same as secondary
  onSecondaryContainer: AppColors.textInverted,
  tertiary: AppColors.jadeLight, // Tertiary accent
  onTertiary: AppColors.textInverted,
  tertiaryContainer: AppColors.jadeLight,
  onTertiaryContainer: AppColors.textInverted,
  errorContainer: AppColors.coral,
  onErrorContainer: AppColors.textInverted,
  surfaceTint: AppColors.primaryHighlight, // Often same as primary
);

// Example custom ThemeExtension for semantic colors (more advanced)
// class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
//   const AppSemanticColors({
//     required this.canvasLight,
//     required this.canvasDark,
//     // ... other semantic colors
//   });

//   final Color? canvasLight;
//   final Color? canvasDark;

//   @override
//   ThemeExtension<AppSemanticColors> copyWith({Color? canvasLight, Color? canvasDark}) {
//     return AppSemanticColors(
//       canvasLight: canvasLight ?? this.canvasLight,
//       canvasDark: canvasDark ?? this.canvasDark,
//     );
//   }

//   @override
//   ThemeExtension<AppSemanticColors> lerp(ThemeExtension<AppSemanticColors>? other, double t) {
//     if (other is! AppSemanticColors) {
//       return this;
//     }
//     return AppSemanticColors(
//       canvasLight: Color.lerp(canvasLight, other.canvasLight, t),
//       canvasDark: Color.lerp(canvasDark, other.canvasDark, t),
//     );
//   }
// }

// const zinappSemanticColors = AppSemanticColors(
//   canvasLight: AppColors.canvasLight,
//   canvasDark: AppColors.baseDark,
// );
