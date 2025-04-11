import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zinapp_v2/constants/app_animations.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';

/// Button variants following the ZinApp V2 design system
enum ZinButtonVariant { primary, secondary, text }

/// Button sizes following the ZinApp V2 design system
enum ZinButtonSize { small, medium, large }

/// Icon position options for buttons with icons
enum IconPosition { leading, trailing }

/// A standardized button component for the ZinApp V2 application.
///
/// ZinButton provides consistent styling and behavior for all interactive buttons
/// in the application, following the ZinApp V2 design system.
///
/// Features:
/// - Multiple variants: primary, secondary, text
/// - Multiple sizes: small, medium, large
/// - Loading state support
/// - Icon support (leading and trailing)
/// - Responsive sizing
/// - Accessibility compliance
///
/// Example usage:
/// ```dart
/// ZinButton(
///   label: 'Get Started',
///   onPressed: () => navigateToOnboarding(),
/// );
/// ```
class ZinButton extends StatefulWidget {
  /// The text displayed on the button
  final String label;

  /// Callback when button is pressed. Set to `null` to disable the button
  final VoidCallback? onPressed;

  /// Button style variant (primary, secondary, text)
  final ZinButtonVariant variant;

  /// Button size (small, medium, large)
  final ZinButtonSize size;

  /// Optional icon to display alongside text
  final IconData? icon;

  /// Position of the icon (leading or trailing)
  final IconPosition iconPosition;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Whether the button should take full width
  final bool isFullWidth;

  /// Custom border radius (defaults to theme value)
  final BorderRadius? borderRadius;

  /// Custom padding (defaults to theme value)
  final EdgeInsetsGeometry? padding;

  const ZinButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = ZinButtonVariant.primary,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  });

  /// Creates a primary button with the highlight color background
  const ZinButton.primary({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = ZinButtonVariant.primary;

  /// Creates a secondary button with outline style
  const ZinButton.secondary({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = ZinButtonVariant.secondary;

  /// Creates a text button with minimal styling
  const ZinButton.text({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = ZinButtonVariant.text;


  @override
  State<ZinButton> createState() => _ZinButtonState();
}

class _ZinButtonState extends State<ZinButton> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _pressAnimationController;
  late AnimationController _hoverAnimationController;

  // Animations
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Offset> _moveAnimation;

  // Hover state
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Press animation controller
    _pressAnimationController = AnimationController(
      vsync: this,
      duration: AppAnimations.buttonPressDuration,
    );

    // Hover animation controller
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: AppAnimations.buttonHoverDuration,
    );

    // Scale animation (ZinPress pattern)
    _scaleAnimation = TweenSequence<double>(
      AppAnimations.getZinPressSequence(),
    ).animate(_pressAnimationController);

    // Elevation animation for hover effect
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _hoverAnimationController,
        curve: AppAnimations.buttonHoverCurve,
      ),
    );

    // Subtle upward movement on hover (ZinRise pattern)
    _moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2.0),
    ).animate(
      CurvedAnimation(
        parent: _hoverAnimationController,
        curve: AppAnimations.buttonHoverCurve,
      ),
    );
  }

  @override
  void dispose() {
    _pressAnimationController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  // Handle mouse enter event for hover effect
  void _handleMouseEnter(PointerEnterEvent event) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() {
        _isHovered = true;
      });
      _hoverAnimationController.forward();
    }
  }

  // Handle mouse exit event for hover effect
  void _handleMouseExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
    _hoverAnimationController.reverse();
  }

  // Handle tap down event for press effect
  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _pressAnimationController.forward();
    }
  }

  // Handle tap up event for release effect
  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          _pressAnimationController.reverse();
        }
      });
    }
  }

  // Handle tap cancel event
  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _pressAnimationController.reverse();
    }
  }

  /// Get the appropriate padding based on button size
  EdgeInsetsGeometry _getPaddingForSize() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ZinButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ZinButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ZinButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  /// Get the appropriate height based on button size
  double _getHeightForSize() {
    switch (widget.size) {
      case ZinButtonSize.small:
        return 36.0;
      case ZinButtonSize.medium:
        return 48.0;
      case ZinButtonSize.large:
        return 56.0;
    }
  }

  /// Get the appropriate text style based on button size
  TextStyle? _getTextStyleForSize(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (widget.size) {
      case ZinButtonSize.small:
        return textTheme.labelMedium; // buttonSmall
      case ZinButtonSize.medium:
        return textTheme.labelLarge; // buttonMedium
      case ZinButtonSize.large:
        return textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ); // buttonLarge
    }
  }

  /// Get the appropriate loading indicator size
  double _getLoadingIndicatorSize() {
    switch (widget.size) {
      case ZinButtonSize.small:
        return 16.0;
      case ZinButtonSize.medium:
        return 20.0;
      case ZinButtonSize.large:
        return 24.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = widget.isLoading ? null : widget.onPressed;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(12.0);

    // Create the button content with icon and label
    Widget buttonContent;

    if (widget.isLoading) {
      // Show loading indicator
      buttonContent = SizedBox(
        height: _getLoadingIndicatorSize(),
        width: _getLoadingIndicatorSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          // Use appropriate color based on variant
          color: widget.variant == ZinButtonVariant.primary
              ? AppColors.textOnHighlight
              : AppColors.primaryHighlight,
        ),
      );
    } else if (widget.icon != null) {
      // Show icon and label
      final icon = Icon(
        widget.icon!,
        size: widget.size == ZinButtonSize.small ? 16.0 : 20.0,
      );

      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.iconPosition == IconPosition.leading
            ? [
                icon,
                const SizedBox(width: 8.0),
                Text(widget.label),
              ]
            : [
                Text(widget.label),
                const SizedBox(width: 8.0),
                icon,
              ],
      );
    } else {
      // Show just the label
      buttonContent = Text(widget.label);
    }

    // Create the appropriate button based on variant
    Widget button;
    switch (widget.variant) {
      case ZinButtonVariant.primary:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            minimumSize: Size(0, _getHeightForSize()),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: buttonContent,
        );
        break;

      case ZinButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            minimumSize: Size(0, _getHeightForSize()),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: const BorderSide(color: AppColors.primaryHighlight, width: 1.5),
          ),
          child: buttonContent,
        );
        break;

      case ZinButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            minimumSize: Size(0, _getHeightForSize()),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: buttonContent,
        );
        break;
    }

    // Apply animations in sequence
    Widget animatedButton = AnimatedBuilder(
      animation: Listenable.merge([_pressAnimationController, _hoverAnimationController]),
      builder: (context, child) {
        return Transform.translate(
          offset: _moveAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: _isHovered ? [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    blurRadius: 4.0 + _elevationAnimation.value * 2,
                    spreadRadius: _elevationAnimation.value,
                    offset: Offset(0, 1.0 + _elevationAnimation.value * 0.5),
                  ),
                ] : null,
              ),
              child: child,
            ),
          ),
        );
      },
      child: button,
    );

    // Apply mouse region and gesture detector for animations
    Widget interactiveButton = MouseRegion(
      onEnter: _handleMouseEnter,
      onExit: _handleMouseExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: effectiveOnPressed,
        child: animatedButton,
      ),
    );

    // Apply full width if needed
    if (widget.isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: interactiveButton,
      );
    } else {
      return interactiveButton;
    }
  }
}
