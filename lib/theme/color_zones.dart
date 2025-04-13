import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Defines the color zone system for ZinApp.
///
/// The color zone system divides the app into distinct visual areas with specific
/// color rules to maintain both brand identity and accessibility.
abstract class ColorZones {
  /// Interactive Zone: Dark backgrounds with neon accents
  ///
  /// Used for: Navigation, action-focused screens, dashboards, interactive elements
  /// Color Rules:
  /// - Dark backgrounds (baseDark)
  /// - Neon green for primary actions and highlights
  /// - High contrast text (textPrimary, textSecondary)
  static const interactiveZone = _InteractiveZoneColors();

  /// Content Zone: Light cream backgrounds with dark text
  ///
  /// Used for: Reading-focused screens, articles, profiles, settings
  /// Color Rules:
  /// - Cream backgrounds (canvasLight)
  /// - Dark text for high readability (textInverted)
  /// - NO neon green elements directly on cream
  /// - Use darker green variants when needed (primaryHighlightDarker)
  static const contentZone = _ContentZoneColors();

  /// Accent Zone: Colored backgrounds for special sections
  ///
  /// Used for: Featured content, promotions, special sections
  /// Color Rules:
  /// - Accent color backgrounds (coolBlue, coral, etc.)
  /// - White or dark text depending on background
  /// - Limited use of neon green
  static const accentZone = _AccentZoneColors();

  /// Brand Zone: High-impact brand presence
  ///
  /// Used for: Splash screen, onboarding, about screens
  /// Color Rules:
  /// - Prominent use of brand colors
  /// - Can combine neon and cream with proper separation
  /// - Focus on brand identity over content density
  static const brandZone = _BrandZoneColors();
}

/// Colors for the Interactive Zone
class _InteractiveZoneColors {
  /// Primary background color for interactive zone
  final Color background = AppColors.baseDark;

  /// Secondary background color for layering
  final Color backgroundAlt = AppColors.baseDarkAlt;

  /// Primary action color
  final Color action = AppColors.primaryHighlight;

  /// Primary text color
  final Color textPrimary = AppColors.textPrimary;

  /// Secondary text color
  final Color textSecondary = AppColors.textSecondary;

  /// Card background color
  final Color cardBackground = AppColors.baseDarkAlt;

  /// Accent color for highlights
  final Color accent = AppColors.coolBlue;

  const _InteractiveZoneColors();
}

/// Colors for the Content Zone
class _ContentZoneColors {
  /// Primary background color for content zone
  final Color background = AppColors.canvasLight;

  /// Secondary background color for layering
  final Color backgroundAlt = AppColors.canvasLightAlt;

  /// Primary action color (darker variant for accessibility)
  final Color action = AppColors.primaryHighlightDarker;

  /// Primary text color
  final Color textPrimary = AppColors.textInverted;

  /// Secondary text color
  final Color textSecondary = AppColors.textInvertedSecondary;

  /// Card background color
  final Color cardBackground = AppColors.canvasLightAlt;

  /// Accent color for highlights (darker variant for accessibility)
  final Color accent = AppColors.coolBlueDark;

  const _ContentZoneColors();
}

/// Colors for the Accent Zone
class _AccentZoneColors {
  /// Cool blue background
  final Color coolBackground = const Color.fromRGBO(140, 186, 205, 0.15);

  /// Coral background
  final Color coralBackground = const Color.fromRGBO(244, 128, 93, 0.15);

  /// Jade background
  final Color jadeBackground = const Color.fromRGBO(195, 255, 194, 0.15);

  /// Text on cool background
  final Color textOnCool = AppColors.coolBlueDark;

  /// Text on coral background
  final Color textOnCoral = AppColors.coralDark;

  /// Text on jade background
  final Color textOnJade = AppColors.jadeDark;

  /// Action color on cool background
  final Color actionOnCool = AppColors.coolBlueDark;

  /// Action color on coral background
  final Color actionOnCoral = AppColors.coralDark;

  /// Action color on jade background
  final Color actionOnJade = AppColors.jadeDark;

  const _AccentZoneColors();
}

/// Colors for the Brand Zone
class _BrandZoneColors {
  /// Primary background color for brand zone
  final Color background = AppColors.baseDark;

  /// Secondary background for layering
  final Color backgroundAlt = AppColors.baseDarkAlt;

  /// Primary brand color
  final Color brandPrimary = AppColors.primaryHighlight;

  /// Secondary brand color
  final Color brandSecondary = AppColors.coolBlue;

  /// Text on dark background
  final Color textOnDark = AppColors.textPrimary;

  /// Text on light elements
  final Color textOnLight = AppColors.textOnHighlight;

  /// Accent color
  final Color accent = AppColors.coral;

  const _BrandZoneColors();
}

/// Extension to provide color zone context to widgets
extension ColorZoneContext on BuildContext {
  /// Returns the appropriate text color based on the background color
  Color getTextColorForBackground(Color backgroundColor) {
    // Calculate relative luminance
    final luminance = backgroundColor.computeLuminance();

    // Use dark text on light backgrounds, light text on dark backgrounds
    if (luminance > 0.5) {
      return AppColors.textInverted;
    } else {
      return AppColors.textPrimary;
    }
  }

  /// Returns the appropriate action color based on the background color
  Color getActionColorForBackground(Color backgroundColor) {
    // Calculate relative luminance
    final luminance = backgroundColor.computeLuminance();

    // Use darker action color on light backgrounds
    if (luminance > 0.5) {
      return AppColors.primaryHighlightDarker;
    } else {
      return AppColors.primaryHighlight;
    }
  }
}
