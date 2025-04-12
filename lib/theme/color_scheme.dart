import 'package:flutter/material.dart';

// Define core V2 colors as constants
abstract class AppColors {
  // Primary Brand Colors
  static const Color primaryHighlight = Color(0xFFD2FF4D); // Highlight / CTA / Logo - Neon green
  static const Color primaryHighlightDark = Color(0xFF9EBF3B); // Darker variant for better contrast on light backgrounds
  static const Color primaryHighlightDarker = Color(0xFF6A8026); // Even darker variant for text on light backgrounds
  static const Color baseDark = Color(0xFF232D30); // Official Background / Base Dark
  static const Color baseDarkAlt = Color(0xFF2A363A); // Slightly lighter dark background for layering

  // Background Colors
  static const Color canvasLight = Color(0xFFF8F3ED); // Cream background
  static const Color canvasLightAlt = Color(0xFFFCFBF9); // Lighter cream variant
  static const Color canvasDarkOverlay = Color(0x26000000); // Subtle dark overlay (15% opacity)
  static const Color canvasLightOverlay = Color(0x26FFFFFF); // Subtle light overlay (15% opacity)

  // Accent Colors
  static const Color coolBlue = Color(0xFF8CBACD); // accent.coolBlue
  static const Color coolBlueDark = Color(0xFF5A8A9E); // Darker variant for better contrast
  static const Color coral = Color(0xFFF4805D); // accent.coral
  static const Color coralDark = Color(0xFFD05A38); // Darker variant for better contrast
  static const Color jadeLight = Color(0xFFC3FFC2); // accent.jadeLight
  static const Color jadeDark = Color(0xFF7ABF79); // Darker variant for better contrast

  // Text Colors (Direct Hex for simplicity)
  static const Color textPrimary = Color(0xFFFCFBF9); // On dark backgrounds
  static const Color textSecondary = Color(0xFFB7C0C9); // On dark backgrounds
  static const Color textInverted = Color(0xFF1A2326); // On light backgrounds (darker for better contrast)
  static const Color textInvertedSecondary = Color(0xFF394548); // Secondary text on light backgrounds
  static const Color textOnHighlight = Color(0xFF232D30); // On primaryHighlight background
  static const Color textDisabled = Color(0xFF7A848C);
  static const Color textLink = Color(0xFF5A8A9E); // Darker blue for better contrast
  static const Color textToken = Color(0xFF6A8026); // Darker green for better contrast

  // Feedback Colors
  static const Color success = Color(0xFF7ABF79); // Success state
  static const Color warning = Color(0xFFE6B54A); // Warning state
  static const Color error = Color(0xFFD05A38); // Error state (darker coral)
}

// Define the Flutter ColorScheme based on AppColors
const zinappColorScheme = ColorScheme(
  brightness: Brightness.dark, // Base theme is dark

  // Primary colors
  primary: AppColors.primaryHighlight, // Main interactive color
  onPrimary: AppColors.textOnHighlight, // Text/icons on primary color
  primaryContainer: AppColors.primaryHighlightDark, // Darker variant for containers
  onPrimaryContainer: AppColors.textOnHighlight, // Text on primary containers

  // Secondary colors
  secondary: AppColors.coolBlue, // Secondary actions, highlights
  onSecondary: AppColors.textInverted, // Text/icons on secondary color
  secondaryContainer: AppColors.coolBlueDark, // Darker variant for containers
  onSecondaryContainer: AppColors.textPrimary, // Text on secondary containers

  // Tertiary colors
  tertiary: AppColors.jadeLight, // Tertiary accent
  onTertiary: AppColors.textInverted, // Text on tertiary
  tertiaryContainer: AppColors.jadeDark, // Darker variant for containers
  onTertiaryContainer: AppColors.textPrimary, // Text on tertiary containers

  // Error colors
  error: AppColors.error, // Error indication
  onError: AppColors.textPrimary, // Text on error
  errorContainer: AppColors.coralDark, // Error container
  onErrorContainer: AppColors.textPrimary, // Text on error container

  // Surface colors
  surface: AppColors.baseDark, // Default surface color
  onSurface: AppColors.textPrimary, // Text on surface
  onSurfaceVariant: AppColors.textSecondary, // Text on surface variant
  surfaceContainerHighest: AppColors.baseDarkAlt, // Highest elevation surface
  surfaceContainerHigh: AppColors.baseDarkAlt, // High elevation surface
  surfaceContainer: AppColors.baseDark, // Standard surface container

  // Inverse colors (for light mode elements in dark theme)
  inverseSurface: AppColors.canvasLight, // Light surface in dark theme
  onInverseSurface: AppColors.textInverted, // Text on inverse surface
  inversePrimary: AppColors.primaryHighlightDarker, // Primary color on light backgrounds

  // Utility colors
  outline: AppColors.textDisabled, // Outline color
  outlineVariant: Color(0xFF505A5E), // Variant outline color
  shadow: Colors.black, // Shadow color
  scrim: Color(0x80000000), // Scrim color (50% black)
  surfaceTint: AppColors.primaryHighlight, // Surface tint color
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
