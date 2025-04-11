import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zinapp_v2/constants/app_animations.dart';

/// An animated card component that responds to hover and tap interactions.
///
/// This component wraps a standard Card widget with animations for hover and tap effects,
/// creating a more interactive and engaging user experience.
class AnimatedCard extends StatefulWidget {
  /// The child widget to display inside the card
  final Widget child;

  /// The background color of the card
  final Color? color;

  /// The elevation of the card when not hovered
  final double elevation;

  /// The shape of the card
  final ShapeBorder? shape;

  /// The border radius of the card
  final BorderRadius? borderRadius;

  /// The margin around the card
  final EdgeInsetsGeometry? margin;

  /// The padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to clip the card's content to its rounded corners
  final Clip clipBehavior;

  const AnimatedCard({
    super.key,
    required this.child,
    this.color,
    this.elevation = 1.0,
    this.shape,
    this.borderRadius,
    this.margin,
    this.padding,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  // Animation controller for hover/press effects
  late AnimationController _animationController;
  
  // Animations
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  
  // State tracking
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimations.cardHoverDuration,
    );
    
    // Scale animation
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.cardHoverCurve,
      ),
    );
    
    // Elevation animation
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.cardHoverCurve,
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Handle mouse enter event
  void _handleMouseEnter(PointerEnterEvent event) {
    if (widget.onTap != null) {
      setState(() {
        _isHovered = true;
      });
      _animationController.forward();
    }
  }
  
  // Handle mouse exit event
  void _handleMouseExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
    _animationController.reverse();
  }
  
  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = widget.borderRadius ?? BorderRadius.circular(16.0);
    final effectiveShape = widget.shape ?? RoundedRectangleBorder(borderRadius: effectiveBorderRadius);
    
    // Create the card content
    Widget cardContent = widget.padding != null
        ? Padding(padding: widget.padding!, child: widget.child)
        : widget.child;
    
    // Create the animated card
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Calculate the current elevation with animation
        final currentElevation = widget.elevation + (_isHovered ? _elevationAnimation.value : 0);
        
        // Create the card with current styling
        return Transform.scale(
          scale: _isHovered ? _scaleAnimation.value : 1.0,
          child: Card(
            margin: widget.margin,
            color: widget.color,
            elevation: currentElevation,
            shape: effectiveShape,
            clipBehavior: widget.clipBehavior,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: _handleMouseEnter,
        onExit: _handleMouseExit,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: effectiveBorderRadius,
          child: cardContent,
        ),
      ),
    );
  }
}
