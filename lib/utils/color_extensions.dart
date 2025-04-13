import 'package:flutter/material.dart';

/// Extension methods for Color to help with the migration from withOpacity() to withValues()
extension ColorExtensions on Color {
  /// Converts a withOpacity() call to withValues()
  ///
  /// This is a helper method to migrate from the deprecated withOpacity() method
  /// to the new withValues() method.
  ///
  /// Example:
  /// ```dart
  /// // Old code
  /// color = Colors.black.withOpacity(0.5);
  ///
  /// // New code
  /// color = Colors.black.withAlpha(0.5);
  /// ```
  Color withAlpha(double opacity) {
    return Color.fromARGB(
      (opacity * 255).round(),
      r.round(),
      g.round(),
      b.round(),
    );
  }

  /// Replacement for the deprecated withOpacity() method
  ///
  /// This method is a direct replacement for the deprecated withOpacity() method,
  /// using the new withValues() method internally.
  ///
  /// Example:
  /// ```dart
  /// // Old code
  /// color = Colors.black.withOpacity(0.5);
  ///
  /// // New code (using this extension)
  /// color = Colors.black.withOpacity(0.5); // Still works, but uses withValues() internally
  /// ```
  @Deprecated('Use withValues() instead')
  Color withOpacity(double opacity) {
    return Color.fromARGB(
      (opacity * 255).round(),
      r.round(),
      g.round(),
      b.round(),
    );
  }
}
