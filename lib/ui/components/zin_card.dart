import 'package:flutter/material.dart';

/// A card component for the ZinApp UI system following the three-layer architecture.
///
/// ZinCard provides a consistent card interface throughout the application
/// with various styles and configurations available through factory constructors.
class ZinCard extends StatelessWidget {
  /// The card title, displayed in the header
  final String? title;
  
  /// Optional subtitle displayed below the title
  final String? subtitle;
  
  /// Optional widget to display at the end of the header
  final Widget? trailing;
  
  /// Main content of the card
  final Widget child;
  
  /// Optional footer content
  final Widget? footer;
  
  /// Callback triggered when the card is tapped
  final VoidCallback? onTap;
  
  /// Whether to show a divider between header and content
  final bool showHeaderDivider;
  
  /// Whether to show a divider between content and footer
  final bool showFooterDivider;
  
  /// Card elevation
  final double elevation;
  
  /// Card background color
  final Color? backgroundColor;
  
  /// Card border color (used in outlined variant)
  final Color? borderColor;
  
  /// Card border width (used in outlined variant)
  final double borderWidth;
  
  /// Card border radius
  final BorderRadius borderRadius;

  /// Creates a standard card with a medium elevation
  ZinCard({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    required this.child,
    this.footer,
    this.onTap,
    this.showHeaderDivider = false,
    this.showFooterDivider = false,
    this.elevation = 2.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(16.0);
  
  /// Creates an elevated card with higher elevation
  factory ZinCard.elevated({
    Key? key,
    String? title,
    String? subtitle,
    Widget? trailing,
    required Widget child,
    Widget? footer,
    VoidCallback? onTap,
    bool showHeaderDivider = false,
    bool showFooterDivider = false,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return ZinCard(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: child,
      footer: footer,
      onTap: onTap,
      showHeaderDivider: showHeaderDivider,
      showFooterDivider: showFooterDivider,
      elevation: 4.0, // Higher elevation
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
    );
  }
  
  /// Creates an outlined card with border and no elevation
  factory ZinCard.outlined({
    Key? key,
    String? title,
    String? subtitle,
    Widget? trailing,
    required Widget child,
    Widget? footer,
    VoidCallback? onTap,
    bool showHeaderDivider = false,
    bool showFooterDivider = false,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
    BorderRadius? borderRadius,
  }) {
    return ZinCard(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: child,
      footer: footer,
      onTap: onTap,
      showHeaderDivider: showHeaderDivider,
      showFooterDivider: showFooterDivider,
      elevation: 0.0, // No elevation for outlined cards
      backgroundColor: backgroundColor,
      borderColor: borderColor ?? const Color(0xFFE0E0E0),
      borderWidth: borderWidth,
      borderRadius: borderRadius,
    );
  }
  
  /// Creates a lighter, more subtle card variant
  factory ZinCard.light({
    Key? key,
    String? title,
    String? subtitle,
    Widget? trailing,
    required Widget child,
    Widget? footer,
    VoidCallback? onTap,
    bool showHeaderDivider = false,
    bool showFooterDivider = false,
    BorderRadius? borderRadius,
  }) {
    return ZinCard(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: child,
      footer: footer,
      onTap: onTap,
      showHeaderDivider: showHeaderDivider,
      showFooterDivider: showFooterDivider,
      elevation: 1.0, // Subtle elevation
      backgroundColor: const Color(0xFFF8F3ED), // Light cream color
      borderRadius: borderRadius,
    );
  }
  
  /// Creates a special card variant for rewards and achievements
  factory ZinCard.reward({
    Key? key,
    String? title,
    String? subtitle,
    Widget? trailing,
    required Widget child,
    Widget? footer,
    VoidCallback? onTap,
    bool showHeaderDivider = false,
    bool showFooterDivider = false,
    BorderRadius? borderRadius,
  }) {
    return ZinCard(
      key: key,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: child,
      footer: footer,
      onTap: onTap,
      showHeaderDivider: showHeaderDivider,
      showFooterDivider: showFooterDivider,
      elevation: 2.0,
      backgroundColor: const Color(0xFF232D30), // Dark background
      borderColor: const Color(0xFFD2FF4D), // Highlight with brand color
      borderWidth: 1.0,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = backgroundColor ?? theme.cardColor;
    
    // Build the card content
    Widget cardContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section
        if (title != null || subtitle != null || trailing != null)
          _buildHeader(theme),
        
        // Header divider
        if (showHeaderDivider && (title != null || subtitle != null || trailing != null))
          const Divider(height: 1),
        
        // Main content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
        
        // Footer divider
        if (showFooterDivider && footer != null)
          const Divider(height: 1),
        
        // Footer section
        if (footer != null)
          footer!,
      ],
    );
    
    // Wrap in a Material for elevation and ink effects
    cardContent = Material(
      color: cardColor,
      elevation: elevation,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: borderColor != null && borderWidth > 0
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor!,
                  width: borderWidth,
                ),
                borderRadius: borderRadius,
              ),
              child: cardContent,
            )
          : cardContent,
    );
    
    // Add tap functionality if provided
    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: cardContent,
      );
    }
    
    return cardContent;
  }
  
  /// Builds the card header with title, subtitle and trailing widget
  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: backgroundColor != null && backgroundColor!.computeLuminance() < 0.5
                          ? Colors.white
                          : null,
                    ),
                  ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: backgroundColor != null && backgroundColor!.computeLuminance() < 0.5
                            ? Colors.white70
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null)
            trailing!,
        ],
      ),
    );
  }
}
