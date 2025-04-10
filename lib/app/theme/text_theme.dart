import 'package:flutter/material.dart';
// Assuming color_scheme.dart is in the same directory or imported correctly
import 'package:zinapp_v2/app/theme/color_scheme.dart';

// Define font family name (ensure this matches the declaration in pubspec.yaml)
const String primaryFontFamily = 'Urbanist';

// Define font weights (adjust mapping if font file uses different names for weights)
const FontWeight regularWeight = FontWeight.w400;
const FontWeight semiBoldWeight = FontWeight.w600;
const FontWeight boldWeight = FontWeight.w800; // Corresponds to ExtraBold in some fonts

// Define base text styles using the primary font and weights
// Sizes are base values; responsive scaling can be applied later if needed.
abstract class AppTextStyles {
  // Headings
  static const TextStyle headingLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 28.0,
    fontWeight: boldWeight,
    height: 1.3, // line-height = 1.3 * font-size
    letterSpacing: -0.5,
    color: AppColors.textPrimary, // Default color on dark bg
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24.0,
    fontWeight: boldWeight,
    height: 1.3,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20.0,
    fontWeight: boldWeight,
    height: 1.3,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18.0,
    fontWeight: regularWeight,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16.0,
    fontWeight: regularWeight,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14.0,
    fontWeight: regularWeight,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textSecondary, // Default secondary color
  );

  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 13.0,
    fontWeight: regularWeight,
    height: 1.5,
    letterSpacing: 0.25,
    color: AppColors.textSecondary,
  );

  // Interactive Text
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18.0, // Matches bodyLarge size
    fontWeight: semiBoldWeight,
    height: 1.2,
    letterSpacing: 0.5,
    // Color typically set by ButtonStyle based on context (e.g., onHighlight)
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16.0, // Matches body size
    fontWeight: semiBoldWeight,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14.0, // Matches bodySmall size
    fontWeight: semiBoldWeight,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static const TextStyle link = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16.0, // Matches body size
    fontWeight: semiBoldWeight,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textLink, // Specific link color
    // textDecoration: TextDecoration.underline, // Consider adding underline in usage
  );

  // Special Text
  static const TextStyle token = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16.0, // Example size, adjust as needed
    fontWeight: boldWeight, // Typically bold
    color: AppColors.textToken, // Specific token color
  );
}

// Create the TextTheme for ThemeData
const zinappTextTheme = TextTheme(
  // Display styles (Larger headings, less common in mobile apps)
  // displayLarge: AppTextStyles.headingLarge.copyWith(fontSize: 57), // Example mapping
  // displayMedium: AppTextStyles.headingLarge.copyWith(fontSize: 45),
  // displaySmall: AppTextStyles.headingLarge.copyWith(fontSize: 36),

  // Headline styles (Map to our Heading styles)
  headlineLarge: AppTextStyles.headingLarge, // Use for most prominent screen titles
  headlineMedium: AppTextStyles.headingMedium, // Use for section titles
  headlineSmall: AppTextStyles.headingSmall, // Use for card titles, sub-sections

  // Title styles (Often used for AppBar titles, dialog titles)
  titleLarge: AppTextStyles.headingSmall.copyWith(fontWeight: semiBoldWeight), // Example mapping
  titleMedium: AppTextStyles.bodyLarge.copyWith(fontWeight: semiBoldWeight), // Example mapping
  titleSmall: AppTextStyles.body.copyWith(fontWeight: semiBoldWeight), // Example mapping

  // Body styles (Standard text)
  bodyLarge: AppTextStyles.bodyLarge,
  bodyMedium: AppTextStyles.body,
  bodySmall: AppTextStyles.bodySmall,

  // Label styles (Often used for buttons, captions)
  labelLarge: AppTextStyles.buttonMedium, // Map button styles to labels
  labelMedium: AppTextStyles.buttonSmall,
  labelSmall: AppTextStyles.caption,
);

// TODO: Implement responsive scaling logic if needed, potentially as extensions
// on BuildContext or helper functions that adjust font sizes based on MediaQuery.
// Example (Conceptual):
// extension ResponsiveTextTheme on BuildContext {
//   TextTheme get responsiveTextTheme {
//     final width = MediaQuery.of(this).size.width;
//     final scaleFactor = width / 375.0; // Example baseline
//     // Apply scaleFactor to base zinappTextTheme sizes (with constraints)
//     // ... implementation ...
//     return scaledTextTheme;
//   }
// }
