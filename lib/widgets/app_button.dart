import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zinapp_v2/constants/app_animations.dart';
import 'package:zinapp_v2/theme/color_scheme.dart'; // Keep for loading indicator color logic

/// Button variants following the ZinApp V2 design system
enum AppButtonVariant { primary, secondary, text }

/// Button sizes following the ZinApp V2 design system
enum AppButtonSize { small, medium, large }

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
/// AppButton(
///   label: 'Get Started',
///   onPressed: () => navigateToOnboarding(),
/// );
/// ```
class AppButton extends StatefulWidget {
  /// The text displayed on the button
  final String label;

  /// Callback when button is pressed. Set to `null` to disable the button
  final VoidCallback? onPressed;

  /// Button style variant (primary, secondary, text)
  final AppButtonVariant variant;

  /// Button size (small, medium, large)
  final AppButtonSize size;

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

  // Corrected main constructor
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary, // Use renamed enum
    this.size = AppButtonSize.medium, // Use renamed enum
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  });

  /// Creates a primary button with the highlight color background
  const AppButton.primary({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = AppButtonVariant.primary;

  /// Creates a secondary button with outline style
  const AppButton.secondary({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = AppButtonVariant.secondary;

  /// Creates a text button with minimal styling
  const AppButton.text({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
  }) : variant = AppButtonVariant.text;


  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
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
    // Use widget padding if provided, otherwise rely on theme padding
    return widget.padding ?? EdgeInsets.zero; // Theme should handle default padding
  }

  /// Get the appropriate height based on button size
  double _getHeightForSize() {
    // Theme doesn't explicitly define height, so keep this for minimumSize
    switch (widget.size) {
      case AppButtonSize.small:
        return 36.0;
      case AppButtonSize.medium:
        return 48.0;
      case AppButtonSize.large:
        return 56.0;
    }
  }

  /// Get the appropriate text style based on button size
  TextStyle? _getTextStyleForSize(BuildContext context) {
    // Rely on theme text styles mapped in zinapp_theme.dart
    final textTheme = Theme.of(context).textTheme;

    switch (widget.size) {
      case AppButtonSize.small:
        return textTheme.labelMedium;
      case AppButtonSize.medium:
        return textTheme.labelLarge;
      case AppButtonSize.large:
        // Assuming labelLarge covers the large button text style adequately
        // If a distinct larger style is needed, define it in the theme (e.g., titleMedium)
        return textTheme.labelLarge?.copyWith(fontSize: 18); // Example override if needed
    }
  }

  /// Get the appropriate loading indicator size
  double _getLoadingIndicatorSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 16.0;
      case AppButtonSize.medium:
        return 20.0;
      case AppButtonSize.large:
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
          color: widget.variant == AppButtonVariant.primary
              ? AppColors.textOnHighlight // Color defined in AppColors
              : AppColors.primaryHighlight, // Color defined in AppColors
        ),
      );
    } else if (widget.icon != null) {
      // Show icon and label
      final icon = Icon(
        widget.icon!,
        size: widget.size == AppButtonSize.small ? 16.0 : 20.0,
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
    // Rely on the themes defined in zinapp_theme.dart for styling
    Widget button;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          // Style comes from elevatedButtonTheme in zinapp_theme.dart
          // Override minimumSize if needed based on size prop
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size(0, _getHeightForSize())),
                padding: WidgetStateProperty.all(_getPaddingForSize()), // Apply dynamic padding
                textStyle: WidgetStateProperty.all(_getTextStyleForSize(context)), // Apply dynamic text style
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)), // Apply dynamic border radius
              ),
          child: buttonContent,
        );
        break;

      case AppButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          // Style comes from outlinedButtonTheme in zinapp_theme.dart
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size(0, _getHeightForSize())),
                padding: WidgetStateProperty.all(_getPaddingForSize()),
                textStyle: WidgetStateProperty.all(_getTextStyleForSize(context)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
                // Side is defined in the theme, no need to override here unless specific cases arise
              ),
          child: buttonContent,
        );
        break;

      case AppButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          // Style comes from textButtonTheme in zinapp_theme.dart
          style: Theme.of(context).textButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size(0, _getHeightForSize())),
                padding: WidgetStateProperty.all(_getPaddingForSize()),
                textStyle: WidgetStateProperty.all(_getTextStyleForSize(context)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
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
