import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  /// Primary button variant with high contrast yellow styling (default)
  primary,

  /// Secondary button variant with subtle slate styling
  secondary,

  /// Text button variant with minimal styling
  text,

  /// Outline button variant with border
  outline,

  /// Special styling for achievement/reward contexts
  reward,
}

/// Icon position options for buttons with icons
enum IconPosition {
  /// Icon appears before the text (default)
  leading,

  /// Icon appears after the text
  trailing,
}

/// A standardized button component for the ZinApp application.
///
/// ZinButton provides consistent styling and behavior for all interactive buttons
/// in the application, following the ZinApp design system.
///
/// Features:
/// - Multiple variants: primary, secondary, text, outline, reward
/// - Multiple sizes: small, medium, large
/// - Loading state support
/// - Icon support (leading and trailing)
/// - Responsive sizing
/// - Accessibility compliance
/// - Animation effects
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

  /// Button style variant
  final ZinButtonVariant variant;

  /// Button size
  final ZinButtonSize size;

  /// Optional icon to display alongside text
  final IconData? icon;

  /// Position of the icon (leading or trailing)
  final IconPosition iconPosition;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Whether the button should take full width
  final bool fullWidth;

  /// Custom border radius (defaults to 12)
  final double borderRadius;

  /// Custom padding (defaults to size-based padding)
  final EdgeInsetsGeometry? padding;

  /// Main constructor
  const ZinButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ZinButtonVariant.primary,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.fullWidth = false,
    this.borderRadius = 12,
    this.padding,
  });

  /// Factory constructor for creating a primary button
  factory ZinButton.primary({
    required String label,
    required VoidCallback? onPressed,
    ZinButtonSize size = ZinButtonSize.medium,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
    bool isLoading = false,
    bool fullWidth = false,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.primary,
      size: size,
      icon: icon,
      iconPosition: iconPosition,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Factory constructor for creating a secondary button
  factory ZinButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    ZinButtonSize size = ZinButtonSize.medium,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
    bool isLoading = false,
    bool fullWidth = false,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.secondary,
      size: size,
      icon: icon,
      iconPosition: iconPosition,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Factory constructor for creating a text button
  factory ZinButton.text({
    required String label,
    required VoidCallback? onPressed,
    ZinButtonSize size = ZinButtonSize.medium,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
    bool isLoading = false,
    bool fullWidth = false,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.text,
      size: size,
      icon: icon,
      iconPosition: iconPosition,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Factory constructor for creating an outline button
  factory ZinButton.outline({
    required String label,
    required VoidCallback? onPressed,
    ZinButtonSize size = ZinButtonSize.medium,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
    bool isLoading = false,
    bool fullWidth = false,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.outline,
      size: size,
      icon: icon,
      iconPosition: iconPosition,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Factory constructor for creating a reward button
  factory ZinButton.reward({
    required String label,
    required VoidCallback? onPressed,
    ZinButtonSize size = ZinButtonSize.medium,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
    bool isLoading = false,
    bool fullWidth = false,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.reward,
      size: size,
      icon: icon,
      iconPosition: iconPosition,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  @override
  State<ZinButton> createState() => _ZinButtonState();
}

class _ZinButtonState extends State<ZinButton> with SingleTickerProviderStateMixin {
  // Animation controllers
  late AnimationController _animationController;
  
  // Animations
  late Animation<double> _scaleAnimation;
  
  // Hover state
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    // Create scale animation for the press effect
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Handle mouse enter event for hover effect
  void _handleMouseEnter(PointerEnterEvent event) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() {
        _isHovered = true;
      });
    }
  }
  
  // Handle mouse exit event for hover effect
  void _handleMouseExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
  }
  
  // Handle tap down event for press effect
  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }
  
  // Handle tap up event for release effect
  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          _animationController.reverse();
        }
      });
    }
  }
  
  // Handle tap cancel event
  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.reverse();
    }
  }
  
  /// Get the appropriate padding based on button size
  EdgeInsetsGeometry _getPaddingForSize() {
    // Use widget padding if provided, otherwise use size-based padding
    if (widget.padding != null) {
      return widget.padding!;
    }
    
    switch (widget.size) {
      case ZinButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ZinButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ZinButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
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
    final foregroundColor = _getForegroundColor();
    
    switch (widget.size) {
      case ZinButtonSize.small:
        return textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
      case ZinButtonSize.medium:
        return textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
      case ZinButtonSize.large:
        return textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
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
  
  /// Get background color based on variant
  Color _getBackgroundColor() {
    final theme = Theme.of(context);
    
    switch (widget.variant) {
      case ZinButtonVariant.primary:
        return const Color(0xFFD2FF4D); // Primary yellow
      case ZinButtonVariant.secondary:
        return const Color(0xFF232D30); // Dark slate
      case ZinButtonVariant.text:
      case ZinButtonVariant.outline:
        return Colors.transparent;
      case ZinButtonVariant.reward:
        return const Color(0xFFFFC043); // Reward orange
    }
  }
  
  /// Get foreground color based on variant
  Color _getForegroundColor() {
    final theme = Theme.of(context);
    
    switch (widget.variant) {
      case ZinButtonVariant.primary:
        return const Color(0xFF232D30); // Dark slate
      case ZinButtonVariant.secondary:
        return Colors.white;
      case ZinButtonVariant.text:
      case ZinButtonVariant.outline:
        return const Color(0xFFD2FF4D); // Primary yellow
      case ZinButtonVariant.reward:
        return const Color(0xFF232D30); // Dark slate
    }
  }
  
  /// Get border side based on variant
  BorderSide? _getBorderSide() {
    switch (widget.variant) {
      case ZinButtonVariant.outline:
        return const BorderSide(color: Color(0xFFD2FF4D)); // Primary yellow
      case ZinButtonVariant.primary:
      case ZinButtonVariant.secondary:
      case ZinButtonVariant.text:
      case ZinButtonVariant.reward:
        return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = widget.isLoading ? null : widget.onPressed;
    final borderRadius = BorderRadius.circular(widget.borderRadius);
    
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
          color: _getForegroundColor(),
        ),
      );
    } else if (widget.icon != null) {
      // Show icon and label
      final icon = Icon(
        widget.icon!,
        size: widget.size == ZinButtonSize.small ? 16.0 : 20.0,
        color: _getForegroundColor(),
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
      case ZinButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: _getForegroundColor(),
            backgroundColor: _getBackgroundColor(),
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            minimumSize: Size(0, _getHeightForSize()),
          ),
          child: buttonContent,
        );
        break;
        
      case ZinButtonVariant.outline:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: _getForegroundColor(),
            backgroundColor: _getBackgroundColor(),
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            side: _getBorderSide(),
            minimumSize: Size(0, _getHeightForSize()),
          ),
          child: buttonContent,
        );
        break;
        
      case ZinButtonVariant.primary:
      case ZinButtonVariant.secondary:
      case ZinButtonVariant.reward:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: _getForegroundColor(),
            backgroundColor: _getBackgroundColor(),
            disabledBackgroundColor: const Color(0xFFE5E5E5), // Light gray
            disabledForegroundColor: const Color(0xFF9E9E9E), // Medium gray
            padding: _getPaddingForSize(),
            textStyle: _getTextStyleForSize(context),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: _getBorderSide() ?? BorderSide.none,
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: Size(0, _getHeightForSize()),
          ),
          child: buttonContent,
        );
        break;
    }
    
    // Apply animations
    Widget animatedButton = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
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
        behavior: HitTestBehavior.opaque,
        child: animatedButton,
      ),
    );
    
    // Apply full width if needed
    if (widget.fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: interactiveButton,
      );
    } else {
      return interactiveButton;
    }
  }
}
