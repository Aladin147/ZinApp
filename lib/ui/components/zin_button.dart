import 'package:flutter/material.dart';

/// Button variant determines the styling and animation of the button
enum ZinButtonVariant {
  /// Primary action button with high contrast yellow styling
  primary,
  
  /// Secondary action button with subtle slate styling
  secondary,
  
  /// Special styling for achievement/reward contexts
  reward,
  
  /// Disabled state button
  disabled,
}

/// A customized button component for ZinApp that follows the brand guidelines
/// and includes animation effects.
///
/// The ZinButton encapsulates all styling and interaction animation,
/// presenting a consistent button experience throughout the app.
class ZinButton extends StatefulWidget {
  /// The text to display on the button
  final String label;
  
  /// Function to execute when the button is pressed
  final VoidCallback? onPressed;
  
  /// The styling variant for the button (primary, secondary, reward, disabled)
  final ZinButtonVariant variant;
  
  /// Optional icon to display before the text
  final IconData? icon;
  
  /// Whether the button should expand to fill available width
  final bool fullWidth;
  
  const ZinButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = ZinButtonVariant.primary,
    this.icon,
    this.fullWidth = false,
  }) : super(key: key);
  
  /// Factory constructor for creating a primary button
  factory ZinButton.primary({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.primary,
      icon: icon,
      fullWidth: fullWidth,
    );
  }
  
  /// Factory constructor for creating a secondary button
  factory ZinButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.secondary,
      icon: icon,
      fullWidth: fullWidth,
    );
  }
  
  /// Factory constructor for creating a reward button
  factory ZinButton.reward({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return ZinButton(
      label: label,
      onPressed: onPressed,
      variant: ZinButtonVariant.reward,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  @override
  State<ZinButton> createState() => _ZinButtonState();
}

class _ZinButtonState extends State<ZinButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
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
  
  // Get button colors based on variant
  ButtonStyle _getButtonStyle() {
    final isDisabled = widget.onPressed == null || widget.variant == ZinButtonVariant.disabled;
    
    // Default values will be overridden by theme
    Color backgroundColor;
    Color foregroundColor;
    Color overlayColor;
    
    switch (widget.variant) {
      case ZinButtonVariant.primary:
        backgroundColor = const Color(0xFFD2FF4D); // Primary yellow
        foregroundColor = const Color(0xFF232D30); // Dark slate
        overlayColor = const Color(0xFFBFE03D);    // Slightly darker yellow
        break;
      case ZinButtonVariant.secondary:
        backgroundColor = const Color(0xFF232D30); // Dark slate
        foregroundColor = Colors.white;
        overlayColor = const Color(0xFF384046);    // Lighter slate
        break;
      case ZinButtonVariant.reward:
        backgroundColor = const Color(0xFFFFC043); // Reward orange
        foregroundColor = const Color(0xFF232D30); // Dark slate
        overlayColor = const Color(0xFFEDAD32);    // Darker orange
        break;
      case ZinButtonVariant.disabled:
        backgroundColor = const Color(0xFFE5E5E5); // Light gray
        foregroundColor = const Color(0xFF9E9E9E); // Medium gray
        overlayColor = Colors.transparent;
        break;
    }
    
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled) || isDisabled) {
          return const Color(0xFFE5E5E5); // Light gray
        }
        return backgroundColor;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled) || isDisabled) {
          return const Color(0xFF9E9E9E); // Medium gray
        }
        return foregroundColor;
      }),
      overlayColor: MaterialStateProperty.all(overlayColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null) {
          _animationController.forward();
        }
      },
      onTapUp: (_) {
        if (widget.onPressed != null) {
          _animationController.reverse();
        }
      },
      onTapCancel: () {
        if (widget.onPressed != null) {
          _animationController.reverse();
        }
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: widget.fullWidth ? double.infinity : null,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: _getButtonStyle(),
            child: Row(
              mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18),
                  const SizedBox(width: 8),
                ],
                Text(widget.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
