import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Badge variants following the ZinApp V2 design system
enum ZinBadgeVariant {
  /// Primary badge with highlight color
  primary,

  /// Secondary badge with cool blue color
  secondary,

  /// Success badge with jade color
  success,

  /// Warning badge with amber color
  warning,

  /// Error badge with coral color
  error,

  /// Neutral badge with gray color
  neutral
}

/// Badge sizes following the ZinApp V2 design system
enum ZinBadgeSize {
  /// Small badge (16px height)
  small,

  /// Medium badge (20px height)
  medium,

  /// Large badge (24px height)
  large
}

/// A standardized badge component for the ZinApp V2 application.
///
/// ZinBadge provides consistent styling and behavior for all badges
/// in the application, following the ZinApp V2 design system.
///
/// Features:
/// - Multiple variants: primary, secondary, success, warning, error, neutral
/// - Different sizes: small, medium, large
/// - Support for text, icons, or counts
/// - Customizable appearance
///
/// Example usage:
/// ```dart
/// ZinBadge(
///   label: 'New',
///   variant: ZinBadgeVariant.primary,
/// );
/// ```
class ZinBadge extends StatelessWidget {
  /// Text to display in the badge
  final String? label;

  /// Count to display in the badge (alternative to label)
  final int? count;

  /// Maximum count to display before showing "+"
  final int maxCount;

  /// Icon to display in the badge
  final IconData? icon;

  /// Badge style variant
  final ZinBadgeVariant variant;

  /// Badge size
  final ZinBadgeSize size;

  /// Whether to use a filled style (solid background)
  final bool filled;

  /// Optional custom background color (overrides variant)
  final Color? backgroundColor;

  /// Optional custom text/icon color (overrides variant)
  final Color? foregroundColor;

  /// Optional callback when the badge is tapped
  final VoidCallback? onTap;

  const ZinBadge({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.variant = ZinBadgeVariant.primary,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates a primary badge with highlight color
  const ZinBadge.primary({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.primary,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates a secondary badge with cool blue color
  const ZinBadge.secondary({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.secondary,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates a success badge with jade color
  const ZinBadge.success({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.success,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates a warning badge with amber color
  const ZinBadge.warning({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.warning,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates an error badge with coral color
  const ZinBadge.error({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.error,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  /// Creates a neutral badge with gray color
  const ZinBadge.neutral({
    super.key,
    this.label,
    this.count,
    this.maxCount = 99,
    this.icon,
    this.size = ZinBadgeSize.medium,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  }) : variant = ZinBadgeVariant.neutral,
       assert(label != null || count != null || icon != null,
            'At least one of label, count, or icon must be provided');

  @override
  Widget build(BuildContext context) {
    // Determine badge properties
    final Color effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor(variant, filled);
    final Color effectiveForegroundColor = foregroundColor ?? _getForegroundColor(variant, filled);
    final double height = _getHeight(size);
    final double fontSize = _getFontSize(size);
    final double iconSize = _getIconSize(size);
    final double horizontalPadding = _getHorizontalPadding(size);

    // Determine badge content
    Widget content;
    if (count != null) {
      // Count badge
      final String displayCount = count! > maxCount ? '$maxCount+' : count.toString();
      content = Text(
        displayCount,
        style: TextStyle(
          color: effectiveForegroundColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (icon != null && label != null) {
      // Icon with label
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: effectiveForegroundColor,
          ),
          const SizedBox(width: 4.0),
          Text(
            label!,
            style: TextStyle(
              color: effectiveForegroundColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      // Icon only
      content = Icon(
        icon,
        size: iconSize,
        color: effectiveForegroundColor,
      );
    } else {
      // Label only
      content = Text(
        label!,
        style: TextStyle(
          color: effectiveForegroundColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // Build the badge
    Widget badge = Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
        border: !filled
            ? Border.all(
                color: _getBorderColor(variant),
                width: 1.0,
              )
            : null,
      ),
      child: Center(child: content),
    );

    // Add tap behavior if needed
    if (onTap != null) {
      badge = GestureDetector(
        onTap: onTap,
        child: badge,
      );
    }

    return badge;
  }

  /// Gets the appropriate background color based on variant and style
  Color _getBackgroundColor(ZinBadgeVariant variant, bool filled) {
    if (!filled) {
      return Colors.transparent;
    }

    switch (variant) {
      case ZinBadgeVariant.primary:
        return AppColors.primaryHighlight;
      case ZinBadgeVariant.secondary:
        return AppColors.coolBlue;
      case ZinBadgeVariant.success:
        return AppColors.jadeLight;
      case ZinBadgeVariant.warning:
        return const Color(0xFFFFB300); // Amber
      case ZinBadgeVariant.error:
        return AppColors.coral;
      case ZinBadgeVariant.neutral:
        return AppColors.textDisabled;
    }
  }

  /// Gets the appropriate foreground color based on variant and style
  Color _getForegroundColor(ZinBadgeVariant variant, bool filled) {
    if (!filled) {
      switch (variant) {
        case ZinBadgeVariant.primary:
          return AppColors.primaryHighlight;
        case ZinBadgeVariant.secondary:
          return AppColors.coolBlue;
        case ZinBadgeVariant.success:
          return AppColors.jadeLight;
        case ZinBadgeVariant.warning:
          return const Color(0xFFFFB300); // Amber
        case ZinBadgeVariant.error:
          return AppColors.coral;
        case ZinBadgeVariant.neutral:
          return AppColors.textDisabled;
      }
    }

    // For filled badges, use appropriate text color
    switch (variant) {
      case ZinBadgeVariant.primary:
        return AppColors.textOnHighlight;
      case ZinBadgeVariant.neutral:
        return AppColors.textPrimary;
      default:
        return AppColors.textInverted;
    }
  }

  /// Gets the appropriate border color for outlined badges
  Color _getBorderColor(ZinBadgeVariant variant) {
    switch (variant) {
      case ZinBadgeVariant.primary:
        return AppColors.primaryHighlight;
      case ZinBadgeVariant.secondary:
        return AppColors.coolBlue;
      case ZinBadgeVariant.success:
        return AppColors.jadeLight;
      case ZinBadgeVariant.warning:
        return const Color(0xFFFFB300); // Amber
      case ZinBadgeVariant.error:
        return AppColors.coral;
      case ZinBadgeVariant.neutral:
        return AppColors.textDisabled;
    }
  }

  /// Gets the appropriate height based on size
  double _getHeight(ZinBadgeSize size) {
    switch (size) {
      case ZinBadgeSize.small:
        return 16.0;
      case ZinBadgeSize.medium:
        return 20.0;
      case ZinBadgeSize.large:
        return 24.0;
    }
  }

  /// Gets the appropriate font size based on size
  double _getFontSize(ZinBadgeSize size) {
    switch (size) {
      case ZinBadgeSize.small:
        return 10.0;
      case ZinBadgeSize.medium:
        return 12.0;
      case ZinBadgeSize.large:
        return 14.0;
    }
  }

  /// Gets the appropriate icon size based on size
  double _getIconSize(ZinBadgeSize size) {
    switch (size) {
      case ZinBadgeSize.small:
        return 10.0;
      case ZinBadgeSize.medium:
        return 12.0;
      case ZinBadgeSize.large:
        return 14.0;
    }
  }

  /// Gets the appropriate horizontal padding based on size
  double _getHorizontalPadding(ZinBadgeSize size) {
    switch (size) {
      case ZinBadgeSize.small:
        return 4.0;
      case ZinBadgeSize.medium:
        return 6.0;
      case ZinBadgeSize.large:
        return 8.0;
    }
  }
}
