import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';

/// Card variants following the ZinApp V2 design system
enum ZinCardVariant {
  /// Standard card with dark background (default)
  standard,

  /// Elevated card with higher elevation
  elevated,

  /// Outlined card with border
  outlined,

  /// Light card with light background
  light
}

/// A standardized card component for the ZinApp V2 application.
///
/// ZinCard provides consistent styling and behavior for all content containers
/// in the application, following the ZinApp V2 design system.
///
/// Features:
/// - Multiple variants: standard, elevated, outlined, light
/// - Consistent styling with the design system
/// - Support for tap interactions
/// - Customizable content padding and margin
///
/// Example usage:
/// ```dart
/// ZinCard(
///   title: 'Card Title',
///   child: Text('Card content goes here'),
///   onTap: () => handleCardTap(),
/// );
/// ```
class ZinCard extends StatelessWidget {
  /// The main content to display within the card
  final Widget child;

  /// Optional title to display at the top of the card
  final String? title;

  /// Optional subtitle to display below the title
  final String? subtitle;

  /// Optional trailing widget to display in the header (e.g., an icon button)
  final Widget? trailing;

  /// Optional footer widget to display at the bottom of the card
  final Widget? footer;

  /// Card style variant
  final ZinCardVariant variant;

  /// Optional padding inside the card content
  final EdgeInsetsGeometry? padding;

  /// Optional margin around the card
  final EdgeInsetsGeometry? margin;

  /// Optional background color (overrides the variant default)
  final Color? backgroundColor;

  /// Optional border radius (overrides the theme default)
  final BorderRadius? borderRadius;

  /// Optional elevation (overrides the variant default)
  final double? elevation;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to show a divider between header and content
  final bool showHeaderDivider;

  /// Whether to show a divider between content and footer
  final bool showFooterDivider;

  const ZinCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.footer,
    this.variant = ZinCardVariant.standard,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
  });

  /// Creates a standard card with dark background
  const ZinCard.standard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.footer,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
  }) : variant = ZinCardVariant.standard;

  /// Creates an elevated card with higher elevation
  const ZinCard.elevated({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.footer,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
  }) : variant = ZinCardVariant.elevated;

  /// Creates an outlined card with border
  const ZinCard.outlined({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.footer,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
  }) : variant = ZinCardVariant.outlined;

  /// Creates a light card with light background
  const ZinCard.light({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.footer,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
  }) : variant = ZinCardVariant.light;

  @override
  Widget build(BuildContext context) {

    // Determine card properties based on variant
    final Color effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor(variant);
    final double effectiveElevation = elevation ?? _getElevation(variant);
    final BorderRadius effectiveBorderRadius = borderRadius ?? BorderRadius.circular(16.0);
    final EdgeInsetsGeometry effectiveMargin = margin ?? const EdgeInsets.all(8.0);
    final EdgeInsetsGeometry effectiveContentPadding = padding ?? const EdgeInsets.all(16.0);

    // Build card content
    Widget cardContent = _buildCardContent(
      context,
      effectiveContentPadding,
    );

    // Apply InkWell for tap effect if onTap is provided
    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
        ),
        child: cardContent,
      );
    }

    // Build the card with appropriate styling
    return Card(
      margin: effectiveMargin,
      color: effectiveBackgroundColor,
      elevation: effectiveElevation,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: variant == ZinCardVariant.outlined
            ? const BorderSide(color: AppColors.textDisabled, width: 1.0)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias, // Ensure content respects rounded corners
      child: cardContent,
    );
  }

  /// Builds the complete card content including header, body, and footer
  Widget _buildCardContent(
    BuildContext context,
    EdgeInsetsGeometry contentPadding,
  ) {
    final hasHeader = title != null || subtitle != null || trailing != null;
    final hasFooter = footer != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section (if any)
        if (hasHeader) _buildHeader(context),

        // Header divider (if enabled and has header)
        if (hasHeader && showHeaderDivider) _buildDivider(),

        // Main content
        Padding(
          padding: contentPadding,
          child: child,
        ),

        // Footer divider (if enabled and has footer)
        if (hasFooter && showFooterDivider) _buildDivider(),

        // Footer section (if any)
        if (hasFooter) footer!,
      ],
    );
  }

  /// Builds the card header with title, subtitle, and trailing widget
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and subtitle
          if (title != null || subtitle != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: _getTextColor(variant),
                      ),
                    ),
                  if (title != null && subtitle != null)
                    const SizedBox(height: 4.0),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _getSubtitleColor(variant),
                      ),
                    ),
                ],
              ),
            ),

          // Trailing widget
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  /// Builds a divider with appropriate styling
  Widget _buildDivider() {
    return const Divider(
      height: 1.0,
      thickness: 1.0,
      color: Color(0x337A848C), // AppColors.textDisabled with 20% opacity
    );
  }

  /// Gets the appropriate background color based on variant
  Color _getBackgroundColor(ZinCardVariant variant) {
    switch (variant) {
      case ZinCardVariant.standard:
        return AppColors.baseDark;
      case ZinCardVariant.elevated:
        return AppColors.baseDark;
      case ZinCardVariant.outlined:
        return AppColors.baseDark;
      case ZinCardVariant.light:
        return AppColors.canvasLight;
    }
  }

  /// Gets the appropriate elevation based on variant
  double _getElevation(ZinCardVariant variant) {
    switch (variant) {
      case ZinCardVariant.standard:
        return 2.0;
      case ZinCardVariant.elevated:
        return 8.0;
      case ZinCardVariant.outlined:
        return 0.0;
      case ZinCardVariant.light:
        return 1.0;
    }
  }

  /// Gets the appropriate text color based on variant
  Color _getTextColor(ZinCardVariant variant) {
    switch (variant) {
      case ZinCardVariant.light:
        return AppColors.textInverted;
      default:
        return AppColors.textPrimary;
    }
  }

  /// Gets the appropriate subtitle color based on variant
  Color _getSubtitleColor(ZinCardVariant variant) {
    switch (variant) {
      case ZinCardVariant.light:
        return AppColors.textInvertedSecondary; // Use the new dedicated color for secondary text on light backgrounds
      default:
        return AppColors.textSecondary;
    }
  }
}
