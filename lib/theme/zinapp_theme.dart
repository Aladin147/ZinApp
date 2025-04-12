import 'package:flutter/material.dart';
// Assuming these files exist in the same directory or are imported correctly
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/app/theme/text_theme.dart';
import 'package:zinapp_v2/app/transitions/zin_page_transitions.dart';

// Define the main application theme
final ThemeData zinappTheme = ThemeData(
  brightness: Brightness.dark, // Base theme brightness
  colorScheme: zinappColorScheme, // Use the defined V2 color scheme
  textTheme: zinappTextTheme, // Use the defined V2 text theme
  fontFamily: 'Urbanist', // Use Urbanist font (ensure google_fonts is imported/setup)

  // Apply base background color globally
  scaffoldBackgroundColor: AppColors.baseDark,
  // Use baseDark for general card/dialog backgrounds unless overridden
  cardColor: AppColors.baseDark,

  // Use custom page transitions
  pageTransitionsTheme: const ZinPageTransitions(),

  // --- Component Theme Overrides (Examples) ---

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.baseDark, // Match scaffold background
    foregroundColor: AppColors.textPrimary, // Title/icon color
    elevation: 0, // Flat app bar
    centerTitle: true, // Example preference
    titleTextStyle: zinappTextTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
  ),

  // ElevatedButton Theme (Primary Button Style)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: zinappColorScheme.primary, // D2FF4D
      foregroundColor: zinappColorScheme.onPrimary, // 232D30 (textOnHighlight)
      textStyle: zinappTextTheme.labelLarge, // ButtonMedium style
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Example padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Standard rounding
      ),
      elevation: 2, // Subtle elevation
    ),
  ),

  // OutlinedButton Theme (Secondary Button Style)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: zinappColorScheme.primary, // Highlight color for text/border
      side: const BorderSide(color: AppColors.primaryHighlight, width: 1.5),
      textStyle: zinappTextTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),

  // TextButton Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: zinappColorScheme.primary, // Highlight color for text
      textStyle: zinappTextTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Smaller padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Slightly less rounding maybe
      ),
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: AppColors.baseDark, // Default card color
    elevation: 4, // Example default elevation for cards
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Example margin
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0), // Standard card rounding
      // Potentially add a subtle border if needed for contrast on dark bg
      // side: BorderSide(color: zinappColorScheme.outlineVariant, width: 0.5),
    ),
  ),

  // Input Decoration Theme (for TextFields)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: zinappColorScheme.surfaceContainerHighest, // Slightly lighter dark bg for input
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: zinappTextTheme.bodyMedium?.copyWith(color: AppColors.textDisabled),
    labelStyle: zinappTextTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
    floatingLabelStyle: zinappTextTheme.bodyMedium?.copyWith(color: zinappColorScheme.primary), // Highlight on focus
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none, // No border by default
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppColors.primaryHighlight, width: 1.5), // Highlight border on focus
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppColors.coral, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppColors.coral, width: 2.0),
    ),
    errorStyle: zinappTextTheme.bodySmall?.copyWith(color: zinappColorScheme.error),
  ),

  // Dialog Theme
  dialogTheme: const DialogThemeData(
    backgroundColor: AppColors.baseDark,
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
  ),

  // Add other component themes as needed (ChipTheme, DialogTheme, etc.)

  // Define custom theme extensions if created (e.g., for semantic colors, spacing)
  // extensions: const <ThemeExtension<dynamic>>[
  //   zinappSemanticColors,
  //   // zinappSpacingTokens, // Example
  // ],
);
