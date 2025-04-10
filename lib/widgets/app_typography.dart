import 'package:flutter/material.dart';

/// Helper class to provide easy access to themed text styles.
/// Ensures consistency and reduces direct Theme.of(context).textTheme lookups.
class AppTypography {
  // Prevent instantiation
  AppTypography._();

  // --- Accessing Styles via BuildContext ---
  // Use these methods within widget build methods

  static TextStyle? displayLarge(BuildContext context) => Theme.of(context).textTheme.displayLarge;
  static TextStyle? displayMedium(BuildContext context) => Theme.of(context).textTheme.displayMedium;
  static TextStyle? displaySmall(BuildContext context) => Theme.of(context).textTheme.displaySmall;

  static TextStyle? headlineLarge(BuildContext context) => Theme.of(context).textTheme.headlineLarge;
  static TextStyle? headlineMedium(BuildContext context) => Theme.of(context).textTheme.headlineMedium;
  static TextStyle? headlineSmall(BuildContext context) => Theme.of(context).textTheme.headlineSmall;

  static TextStyle? titleLarge(BuildContext context) => Theme.of(context).textTheme.titleLarge;
  static TextStyle? titleMedium(BuildContext context) => Theme.of(context).textTheme.titleMedium;
  static TextStyle? titleSmall(BuildContext context) => Theme.of(context).textTheme.titleSmall;

  static TextStyle? bodyLarge(BuildContext context) => Theme.of(context).textTheme.bodyLarge;
  static TextStyle? bodyMedium(BuildContext context) => Theme.of(context).textTheme.bodyMedium;
  static TextStyle? bodySmall(BuildContext context) => Theme.of(context).textTheme.bodySmall;

  static TextStyle? labelLarge(BuildContext context) => Theme.of(context).textTheme.labelLarge;
  static TextStyle? labelMedium(BuildContext context) => Theme.of(context).textTheme.labelMedium;
  static TextStyle? labelSmall(BuildContext context) => Theme.of(context).textTheme.labelSmall;

  // --- Convenience Methods for Specific Use Cases (Optional) ---
  // Could add methods that return styles with specific colors if needed frequently

  // Example: Get bodyMedium style but with the link color
  // static TextStyle? linkStyle(BuildContext context) =>
  //     Theme.of(context).textTheme.bodyMedium?.copyWith(
  //           color: Theme.of(context).colorScheme.secondary, // Assuming link color is secondary
  //           // Add decoration if needed:
  //           // decoration: TextDecoration.underline,
  //           // decorationColor: Theme.of(context).colorScheme.secondary,
  //         );

  // Example: Get bodyMedium style but with the token color
  // static TextStyle? tokenStyle(BuildContext context) =>
  //     Theme.of(context).textTheme.bodyMedium?.copyWith(
  //           color: Theme.of(context).colorScheme.primary, // Assuming token color is primary
  //           fontWeight: FontWeight.w800, // Make it bold
  //         );
}

/*
  Example Usage in a Widget:

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Screen Title', style: AppTypography.headlineLarge(context)),
        Text('Some body text.', style: AppTypography.bodyMedium(context)),
        Text('A caption.', style: AppTypography.labelSmall(context)),
      ],
    );
  }

*/
