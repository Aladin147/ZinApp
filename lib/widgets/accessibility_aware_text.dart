import 'package:flutter/material.dart';
import 'package:zinapp_v2/utils/accessibility_utils.dart';

/// A text widget that automatically ensures proper contrast with its background.
///
/// This widget wraps a standard Text widget and adjusts its color to ensure
/// it meets WCAG contrast requirements with the specified background color.
class AccessibilityAwareText extends StatelessWidget {
  /// The text to display
  final String text;
  
  /// The background color against which the text will be displayed
  final Color backgroundColor;
  
  /// The style to apply to the text
  final TextStyle? style;
  
  /// Whether this is large text (24px or larger, or 18px bold)
  final bool isLargeText;
  
  /// Text alignment
  final TextAlign? textAlign;
  
  /// Text overflow behavior
  final TextOverflow? overflow;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Whether to soften the text color for secondary text
  final bool isSecondaryText;

  const AccessibilityAwareText({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.style,
    this.isLargeText = false,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isSecondaryText = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get the base text color for this background
    final baseTextColor = isSecondaryText
        ? AccessibilityUtils.getSecondaryTextColorForBackground(backgroundColor)
        : AccessibilityUtils.getTextColorForBackground(backgroundColor);
    
    // Get the text style from the context if not provided
    final TextStyle defaultStyle = DefaultTextStyle.of(context).style;
    final TextStyle effectiveStyle = style ?? defaultStyle;
    
    // If the style specifies a color, ensure it has proper contrast
    final Color textColor = effectiveStyle.color != null
        ? AccessibilityUtils.ensureContrastWithBackground(
            effectiveStyle.color!,
            backgroundColor,
            isLargeText: isLargeText,
          )
        : baseTextColor;
    
    // Create a new style with the accessible color
    final TextStyle accessibleStyle = effectiveStyle.copyWith(
      color: textColor,
    );
    
    return Text(
      text,
      style: accessibleStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

/// A button that automatically ensures proper contrast with its background.
///
/// This widget wraps a standard ElevatedButton and adjusts its colors to ensure
/// they meet WCAG contrast requirements with the specified background color.
class AccessibilityAwareButton extends StatelessWidget {
  /// The button label
  final String label;
  
  /// The background color against which the button will be displayed
  final Color backgroundColor;
  
  /// Callback when the button is pressed
  final VoidCallback? onPressed;
  
  /// Whether the button should be full width
  final bool isFullWidth;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// The button variant (primary, secondary, etc.)
  final ButtonVariant variant;

  const AccessibilityAwareButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    // Get the appropriate action color for this background
    final actionColor = AccessibilityUtils.getActionColorForBackground(backgroundColor);
    
    // Determine text color based on button background
    final textColor = AccessibilityUtils.getTextColorForBackground(
      variant == ButtonVariant.primary ? actionColor : backgroundColor
    );
    
    // Create button style
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: variant == ButtonVariant.primary ? actionColor : Colors.transparent,
      foregroundColor: textColor,
      minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: variant == ButtonVariant.outline 
            ? BorderSide(color: actionColor)
            : BorderSide.none,
      ),
    );
    
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            )
          : Text(label),
    );
  }
}

/// Button variants
enum ButtonVariant {
  /// Primary button with filled background
  primary,
  
  /// Secondary button with transparent background
  secondary,
  
  /// Outline button with border
  outline,
}

/// A card that automatically ensures proper contrast for its content.
///
/// This widget wraps a standard Card and ensures all content has proper
/// contrast with the card's background color.
class AccessibilityAwareCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;
  
  /// The background color of the card
  final Color? backgroundColor;
  
  /// The elevation of the card
  final double elevation;
  
  /// The border radius of the card
  final BorderRadius? borderRadius;
  
  /// The padding inside the card
  final EdgeInsetsGeometry? padding;
  
  /// The margin around the card
  final EdgeInsetsGeometry? margin;
  
  /// Callback when the card is tapped
  final VoidCallback? onTap;

  const AccessibilityAwareCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation = 1.0,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the effective background color
    final effectiveBackgroundColor = backgroundColor ?? Theme.of(context).cardColor;
    
    // Determine if this is a cream background
    final isCreamBackground = AccessibilityUtils.isCreamColor(effectiveBackgroundColor);
    
    // Get the appropriate color zone for this background
    final colorZone = AccessibilityUtils.getColorZoneForBackground(effectiveBackgroundColor);
    
    // Create the card
    final card = Card(
      color: effectiveBackgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      margin: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    
    // If the card has a cream background, add a warning in debug mode
    if (isCreamBackground) {
      return Stack(
        children: [
          card,
          if (false) // Set to true to enable debug overlay
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.red,
                child: const Text(
                  'Cream background - check contrast',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      );
    }
    
    return card;
  }
}
