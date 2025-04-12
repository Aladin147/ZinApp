import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Button sizes for the ZinButton widget
enum ZinButtonSize {
  /// Small button size
  small,

  /// Medium button size (default)
  medium,

  /// Large button size
  large,
}

/// Button variants for the ZinButton widget
enum ZinButtonVariant {
  /// Primary button variant (default)
  primary,

  /// Secondary button variant
  secondary,

  /// Outline button variant
  outline,

  /// Text button variant
  text,
}

/// A custom button widget for the ZinApp application
class ZinButton extends StatelessWidget {
  /// Function called when the button is pressed
  final VoidCallback? onPressed;

  /// Text displayed on the button
  final String text;

  /// Icon displayed before the text
  final IconData? icon;

  /// Size of the button
  final ZinButtonSize size;

  /// Variant of the button
  final ZinButtonVariant variant;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Whether the button takes the full width of its parent
  final bool fullWidth;

  /// Border radius of the button
  final double borderRadius;

  const ZinButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.size = ZinButtonSize.medium,
    this.variant = ZinButtonVariant.primary,
    this.isLoading = false,
    this.fullWidth = true,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine button styling based on variant
    Color backgroundColor;
    Color foregroundColor;
    // Overlay color is not used directly in ElevatedButton.styleFrom
    // but we keep it for documentation purposes
    BorderSide? side;

    switch (variant) {
      case ZinButtonVariant.primary:
        backgroundColor = AppColors.primaryHighlight;
        foregroundColor = Colors.black;
        // overlayColor would be Colors.white.withAlpha(0.2);
        side = null;
        break;
      case ZinButtonVariant.secondary:
        backgroundColor = theme.colorScheme.secondary;
        foregroundColor = theme.colorScheme.onSecondary;
        // No overlay color needed
        side = null;
        break;
      case ZinButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.primaryHighlight;
        // overlayColor would be AppColors.primaryHighlight.withAlpha(0.1);
        side = const BorderSide(color: AppColors.primaryHighlight);
        break;
      case ZinButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.primaryHighlight;
        // overlayColor would be AppColors.primaryHighlight.withAlpha(0.1);
        side = null;
        break;
    }

    // Determine padding based on size
    EdgeInsetsGeometry padding;
    double? height;
    TextStyle? textStyle;

    switch (size) {
      case ZinButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        height = 36;
        textStyle = theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
        break;
      case ZinButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
        height = 48;
        textStyle = theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
        break;
      case ZinButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
        height = 56;
        textStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
        break;
    }

    // Build the button content
    Widget buttonContent;

    if (isLoading) {
      // Loading indicator
      buttonContent = SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    } else if (icon != null) {
      // Icon and text
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: textStyle?.fontSize ?? 16),
          const SizedBox(width: 8),
          Text(text, style: textStyle),
        ],
      );
    } else {
      // Text only
      buttonContent = Text(text, style: textStyle);
    }

    // Build the button
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        padding: padding,
        elevation: variant == ZinButtonVariant.text ? 0 : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: side ?? BorderSide.none,
        ),
        minimumSize: Size(0, height),
        maximumSize: Size(fullWidth ? double.infinity : double.maxFinite, height),
      ),
      child: buttonContent,
    );

    // Apply full width if needed
    return fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
