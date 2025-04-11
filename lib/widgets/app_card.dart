import 'package:flutter/material.dart';

/// A standardized card component for displaying content blocks.
///
/// Uses styling from the application's [ThemeData] (CardTheme).
class AppCard extends StatelessWidget {
  /// The content to display within the card.
  final Widget child;

  /// Optional padding inside the card. Defaults to theme's CardTheme margin
  /// if that's configured for padding, otherwise a default value.
  /// Note: CardTheme.margin is often used for *outer* spacing.
  /// We might need a custom theme extension for inner card padding.
  final EdgeInsetsGeometry? padding;

  /// Optional margin around the card. Defaults to theme's CardTheme margin.
  final EdgeInsetsGeometry? margin;

  /// Optional background color. Defaults to theme's CardTheme color.
  final Color? color;

  /// Optional elevation. Defaults to theme's CardTheme elevation.
  final double? elevation;

  /// Optional custom shape. Defaults to theme's CardTheme shape.
  final ShapeBorder? shape;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.shape,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;

    // Define default inner padding if not provided and not available via theme extension
    // TODO: Consider adding standard padding values to theme extensions later
    const defaultPadding = EdgeInsets.all(16.0);
    final effectivePadding = padding ?? defaultPadding;

    Widget cardContent = Padding(
      padding: effectivePadding,
      child: child,
    );

    // Use InkWell for tap effect if onTap is provided
    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        // Use card shape for InkWell splash radius if possible
        customBorder: shape ?? cardTheme.shape,
        child: cardContent,
      );
    }

    return Card(
      // Use values from CardTheme by default, allow overrides
      margin: margin ?? cardTheme.margin,
      color: color ?? cardTheme.color,
      elevation: elevation ?? cardTheme.elevation,
      shape: shape ?? cardTheme.shape,
      clipBehavior: Clip.antiAlias, // Ensure content respects rounded corners
      child: cardContent,
    );
  }
}

/*
  Example Usage:

  AppCard(
    onTap: () => print('Card tapped!'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Title', style: AppTypography.headlineSmall(context)),
        SizedBox(height: 8.0),
        Text(
          'This is some content inside the card.',
          style: AppTypography.bodyMedium(context),
        ),
      ],
    ),
  )
*/
