import 'package:flutter/material.dart';
import 'package:zinapp_v2/widgets/shapes/wave_clipper.dart';

/// Defines the shape style for organic containers
enum OrganicShape {
  /// Standard rounded corners
  rounded,
  
  /// Wave pattern on the bottom edge
  waveBottom,
  
  /// Wave pattern on the top edge
  waveTop,
  
  /// Curved bottom edge
  curvedBottom,
  
  /// Asymmetric curved edges
  asymmetric,
  
  /// Blob-like organic shape
  blobby
}

/// A container with organic, flowing shapes instead of rigid rectangles
class OrganicContainer extends StatelessWidget {
  /// The child widget
  final Widget child;
  
  /// Background color of the container
  final Color? color;
  
  /// Gradient to use instead of solid color
  final Gradient? gradient;
  
  /// Padding inside the container
  final EdgeInsetsGeometry padding;
  
  /// Margin around the container
  final EdgeInsetsGeometry? margin;
  
  /// The organic shape to apply
  final OrganicShape shape;
  
  /// Border radius for rounded shape
  final double borderRadius;
  
  /// Elevation/shadow depth
  final double elevation;
  
  /// Wave amplitude for wave shapes
  final double waveAmplitude;
  
  /// Wave frequency for wave shapes
  final double waveFrequency;
  
  /// Phase shift for wave shapes
  final double wavePhase;
  
  /// Height of curve for curved shapes
  final double curveHeight;
  
  /// Whether to clip the child content to the shape
  final bool clipContent;
  
  /// Border to apply to the container
  final BoxBorder? border;
  
  /// Box shadow to apply
  final List<BoxShadow>? boxShadow;
  
  /// Width constraint
  final double? width;
  
  /// Height constraint
  final double? height;
  
  /// Alignment of the child within the container
  final Alignment? alignment;

  /// Creates an organic container with flowing shapes
  ///
  /// At least one of [color] or [gradient] must be provided.
  const OrganicContainer({
    super.key,
    required this.child,
    this.color,
    this.gradient,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.shape = OrganicShape.rounded,
    this.borderRadius = 24,
    this.elevation = 0,
    this.waveAmplitude = 20,
    this.waveFrequency = 1.5,
    this.wavePhase = 0,
    this.curveHeight = 30,
    this.clipContent = true,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
    this.alignment,
  }) : assert(color != null || gradient != null, 'Either color or gradient must be provided');

  @override
  Widget build(BuildContext context) {
    // Base container with styling
    final container = Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: shape == OrganicShape.rounded ? BorderRadius.circular(borderRadius) : null,
        border: border,
        boxShadow: boxShadow ?? (elevation > 0 ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1 + (elevation * 0.05)),
            blurRadius: elevation * 5,
            spreadRadius: elevation,
            offset: Offset(0, elevation * 2),
          ),
        ] : null),
      ),
      child: child,
    );
    
    // Apply margin if specified
    final marginContainer = margin != null 
      ? Container(margin: margin, child: container)
      : container;
    
    // Apply appropriate clipping based on shape
    switch (shape) {
      case OrganicShape.rounded:
        return marginContainer; // Already has borderRadius in BoxDecoration
        
      case OrganicShape.waveBottom:
        return ClipPath(
          clipper: WaveBottomClipper(
            amplitude: waveAmplitude,
            frequency: waveFrequency,
            phase: wavePhase,
          ),
          child: marginContainer,
        );
        
      case OrganicShape.waveTop:
        return ClipPath(
          clipper: WaveTopClipper(
            amplitude: waveAmplitude,
            frequency: waveFrequency,
            phase: wavePhase,
          ),
          child: marginContainer,
        );
        
      case OrganicShape.curvedBottom:
        return ClipPath(
          clipper: CurvedBottomClipper(
            curveHeight: curveHeight,
          ),
          child: marginContainer,
        );
        
      case OrganicShape.asymmetric:
        return ClipPath(
          clipper: AsymmetricClipper(
            leftCurveHeight: curveHeight * 0.7,
            rightCurveHeight: curveHeight,
          ),
          child: marginContainer,
        );
        
      case OrganicShape.blobby:
        return ClipPath(
          clipper: BlobClipper(
            randomness: 0.3, // Keep it subtle
          ),
          child: marginContainer,
        );
    }
  }
}

/// A floating card with organic styling and enhanced shadow effects
class FloatingOrganicCard extends StatelessWidget {
  /// The child widget
  final Widget child;
  
  /// Background color of the card
  final Color? color;
  
  /// Gradient to use instead of solid color
  final Gradient? gradient;
  
  /// Padding inside the card
  final EdgeInsetsGeometry padding;
  
  /// Margin around the card
  final EdgeInsetsGeometry? margin;
  
  /// Border radius for corners
  final double borderRadius;
  
  /// Elevation/shadow depth
  final double elevation;
  
  /// Whether to use enhanced shadow effect
  final bool enhancedShadow;
  
  /// Border to apply to the card
  final BoxBorder? border;
  
  /// Width constraint
  final double? width;
  
  /// Height constraint
  final double? height;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;
  
  /// Alignment of the child within the card
  final Alignment? alignment;

  /// Creates a floating card with organic styling and enhanced shadows
  ///
  /// At least one of [color] or [gradient] must be provided.
  const FloatingOrganicCard({
    super.key,
    required this.child,
    this.color,
    this.gradient,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 24,
    this.elevation = 4,
    this.enhancedShadow = true,
    this.border,
    this.width,
    this.height,
    this.onTap,
    this.alignment,
  }) : assert(color != null || gradient != null, 'Either color or gradient must be provided');

  @override
  Widget build(BuildContext context) {
    // Create shadow effects
    final List<BoxShadow> shadows = enhancedShadow ? [
      // Ambient shadow
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: elevation * 4,
        spreadRadius: elevation * 0.5,
        offset: Offset(0, elevation),
      ),
      // Directional shadow
      BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: elevation * 2,
        spreadRadius: 0,
        offset: Offset(0, elevation * 1.5),
      ),
      // Highlight glow (very subtle)
      BoxShadow(
        color: Colors.white.withOpacity(0.05),
        blurRadius: elevation * 2,
        spreadRadius: 0,
        offset: const Offset(0, -1),
      ),
    ] : [
      BoxShadow(
        color: Colors.black.withOpacity(0.1 + (elevation * 0.05)),
        blurRadius: elevation * 3,
        spreadRadius: elevation * 0.5,
        offset: Offset(0, elevation),
      ),
    ];
    
    // Create the card
    final card = Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: shadows,
      ),
      child: child,
    );
    
    // Apply margin if specified
    final marginCard = margin != null 
      ? Container(margin: margin, child: card)
      : card;
    
    // Make it tappable if onTap is provided
    return onTap != null
      ? Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: marginCard,
          ),
        )
      : marginCard;
  }
}
