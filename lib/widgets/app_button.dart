import 'package:flutter/material.dart';
import 'package:zinapp_v2/constants/app_animations.dart'; // Assuming constants path

enum AppButtonVariant { primary, secondary, text }

/// A standardized button component for the ZinApp V2 application.
///
/// Uses styles defined in the application's [ThemeData].
class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final AppButtonVariant variant;
  final Widget? icon; // Optional icon
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true, // Default to full width as per memo suggestion
  });

  // Convenience constructors for variants
  const AppButton.primary({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
  }) : variant = AppButtonVariant.secondary;

    const AppButton.text({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = false, // Text buttons usually not full width
  }) : variant = AppButtonVariant.text;


  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimations.buttonPressDuration, // Use constant
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.buttonPressCurve, // Use constant
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
     if (!widget.isDisabled && !widget.isLoading) {
       Future.delayed(const Duration(milliseconds: 50), () { // Slight delay before reversing
         if (mounted) {
           _animationController.reverse();
         }
       });
     }
  }

   void _handleTapCancel() {
     if (!widget.isDisabled && !widget.isLoading) {
       _animationController.reverse();
     }
   }


  @override
  Widget build(BuildContext context) {
    final bool effectiveDisabled = widget.isDisabled || widget.isLoading;
    final VoidCallback? effectiveOnPressed = effectiveDisabled ? null : widget.onPressed;

    Widget buttonContent = widget.isLoading
        ? SizedBox(
            height: 20, // Adjust size as needed
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              // Use theme color for indicator based on variant
              color: widget.variant == AppButtonVariant.primary
                  ? Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})
                  : Theme.of(context).colorScheme.primary,
            ),
          )
        : Text(widget.label);

    if (widget.icon != null && !widget.isLoading) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon!,
          const SizedBox(width: 8.0), // Spacing between icon and label
          Text(widget.label),
        ],
      );
    }

    Widget button;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          child: buttonContent,
        );
        break;
    }

    Widget animatedButton = ScaleTransition(
       scale: _scaleAnimation,
       child: button,
     );

    // Apply GestureDetector for custom animation trigger
     Widget gestureButton = GestureDetector(
       onTapDown: _handleTapDown,
       onTapUp: _handleTapUp,
       onTapCancel: _handleTapCancel,
       onTap: effectiveOnPressed, // Still need this for actual action
       child: animatedButton,
     );


    if (widget.fullWidth && widget.variant != AppButtonVariant.text) {
      return SizedBox(
        width: double.infinity,
        child: gestureButton,
      );
    } else {
      return gestureButton;
    }
  }
}
