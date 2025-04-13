import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/theme/color_zones.dart';

/// Utility class for enforcing accessibility rules in the app.
///
/// This class provides methods to ensure proper contrast and color usage
/// according to WCAG guidelines and ZinApp's color zone system.
class AccessibilityUtils {
  /// Minimum contrast ratio for normal text (WCAG AA)
  static const double minContrastRatioNormalText = 4.5;

  /// Minimum contrast ratio for large text (WCAG AA)
  static const double minContrastRatioLargeText = 3.0;

  /// Checks if a color is light (high luminance)
  static bool isLightColor(Color color) {
    return color.computeLuminance() > 0.5;
  }

  /// Checks if a color is cream or very close to cream
  static bool isCreamColor(Color color) {
    // Check if the color is in the cream family (close to our canvasLight)
    final creamHue = HSLColor.fromColor(AppColors.canvasLight).hue;
    final colorHue = HSLColor.fromColor(color).hue;
    final hueDifference = (creamHue - colorHue).abs();

    // If the color is light and has a similar hue to our cream, consider it cream
    // Check if the color is in the cream family
    return isLightColor(color) &&
           (hueDifference < 30 || hueDifference > 330) &&
           color.r > 240 && color.g > 230 && color.b > 210; // Cream color range
  }

  /// Gets the appropriate text color for a background to ensure proper contrast
  static Color getTextColorForBackground(Color backgroundColor) {
    if (isLightColor(backgroundColor)) {
      return AppColors.textInverted;
    } else {
      return AppColors.textPrimary;
    }
  }

  /// Gets the appropriate secondary text color for a background
  static Color getSecondaryTextColorForBackground(Color backgroundColor) {
    if (isLightColor(backgroundColor)) {
      return AppColors.textInvertedSecondary;
    } else {
      return AppColors.textSecondary;
    }
  }

  /// Gets the appropriate action color for a background
  static Color getActionColorForBackground(Color backgroundColor) {
    if (isCreamColor(backgroundColor)) {
      // On cream backgrounds, always use the darkest variant of our primary color
      return AppColors.primaryHighlightDarker;
    } else if (isLightColor(backgroundColor)) {
      // On other light backgrounds, use the dark variant
      return AppColors.primaryHighlightDark;
    } else {
      // On dark backgrounds, use the standard neon
      return AppColors.primaryHighlight;
    }
  }

  /// Gets the appropriate color zone for a background color
  static dynamic getColorZoneForBackground(Color backgroundColor) {
    if (isCreamColor(backgroundColor)) {
      return ColorZones.contentZone;
    } else if (backgroundColor == AppColors.baseDark ||
               backgroundColor == AppColors.baseDarkAlt) {
      return ColorZones.interactiveZone;
    } else if (_isAccentZoneColor(backgroundColor)) {
      return ColorZones.accentZone;
    } else {
      // Default to interactive zone for unknown backgrounds
      return ColorZones.interactiveZone;
    }
  }

  /// Calculates the contrast ratio between two colors
  static double calculateContrastRatio(Color foreground, Color background) {
    // Calculate relative luminance for both colors
    final double luminance1 = foreground.computeLuminance();
    final double luminance2 = background.computeLuminance();

    // Calculate contrast ratio according to WCAG formula
    final double lighter = math.max(luminance1, luminance2);
    final double darker = math.min(luminance1, luminance2);

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Checks if a color combination meets WCAG AA contrast requirements for normal text
  static bool hasAdequateContrastForNormalText(Color foreground, Color background) {
    return calculateContrastRatio(foreground, background) >= minContrastRatioNormalText;
  }

  /// Checks if a color combination meets WCAG AA contrast requirements for large text
  static bool hasAdequateContrastForLargeText(Color foreground, Color background) {
    return calculateContrastRatio(foreground, background) >= minContrastRatioLargeText;
  }

  /// Darkens a color until it meets contrast requirements with the background
  /// Helper method to check if a color is from the accent zone
  static bool _isAccentZoneColor(Color color) {
    // Check if the color is similar to our accent zone colors
    final coolBlueAccent = const Color.fromRGBO(140, 186, 205, 0.15);
    final coralAccent = const Color.fromRGBO(244, 128, 93, 0.15);
    final jadeLightAccent = const Color.fromRGBO(195, 255, 194, 0.15);

    // Compare RGB components with some tolerance
    const tolerance = 5;

    return _colorsAreSimilar(color, coolBlueAccent, tolerance) ||
           _colorsAreSimilar(color, coralAccent, tolerance) ||
           _colorsAreSimilar(color, jadeLightAccent, tolerance);
  }

  /// Helper method to check if two colors are similar within a tolerance
  static bool _colorsAreSimilar(Color a, Color b, int tolerance) {
    // Calculate color distance using RGB components
    final double rDiff = (a.r - b.r).abs();
    final double gDiff = (a.g - b.g).abs();
    final double bDiff = (a.b - b.b).abs();

    // Check if all components are within tolerance
    return rDiff <= tolerance && gDiff <= tolerance && bDiff <= tolerance;
  }

  static Color ensureContrastWithBackground(
    Color foreground,
    Color background,
    {bool isLargeText = false,}
  ) {
    // If contrast is already adequate, return the original color
    final double requiredContrast = isLargeText
        ? minContrastRatioLargeText
        : minContrastRatioNormalText;

    if (calculateContrastRatio(foreground, background) >= requiredContrast) {
      return foreground;
    }

    // Convert to HSL for easier manipulation
    final HSLColor hslColor = HSLColor.fromColor(foreground);

    // If background is light, darken the foreground
    if (isLightColor(background)) {
      // Start with the original color and gradually darken it
      double lightness = hslColor.lightness;
      HSLColor adjustedColor = hslColor;

      // Gradually darken until we meet contrast requirements or reach black
      while (lightness > 0.05 &&
             calculateContrastRatio(adjustedColor.toColor(), background) < requiredContrast) {
        lightness -= 0.05;
        adjustedColor = HSLColor.fromAHSL(
          hslColor.alpha,
          hslColor.hue,
          hslColor.saturation,
          lightness,
        );
      }

      return adjustedColor.toColor();
    }
    // If background is dark, lighten the foreground
    else {
      // Start with the original color and gradually lighten it
      double lightness = hslColor.lightness;
      HSLColor adjustedColor = hslColor;

      // Gradually lighten until we meet contrast requirements or reach white
      while (lightness < 0.95 &&
             calculateContrastRatio(adjustedColor.toColor(), background) < requiredContrast) {
        lightness += 0.05;
        adjustedColor = HSLColor.fromAHSL(
          hslColor.alpha,
          hslColor.hue,
          hslColor.saturation,
          lightness,
        );
      }

      return adjustedColor.toColor();
    }
  }
}
