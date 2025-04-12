import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zinapp_v2/widgets/shapes/wave_clipper.dart';

/// A background with subtle organic shapes
class OrganicBackground extends StatelessWidget {
  /// The child widget
  final Widget child;
  
  /// Base background color
  final Color backgroundColor;
  
  /// Color for the organic shapes
  final Color shapeColor;
  
  /// Number of shapes to render
  final int numberOfShapes;
  
  /// Opacity of the shapes
  final double shapeOpacity;
  
  /// Random seed for consistent shape generation
  final int seed;
  
  /// Whether to animate the shapes
  final bool animate;
  
  /// Animation duration if animated
  final Duration animationDuration;

  /// Creates a background with subtle organic shapes
  ///
  /// The [child] is rendered on top of the background.
  /// [backgroundColor] is the base color of the background.
  /// [shapeColor] is the color of the organic shapes.
  /// [numberOfShapes] controls how many shapes are rendered.
  /// [shapeOpacity] controls the opacity of the shapes (0-1).
  /// [seed] provides a consistent random pattern.
  /// [animate] determines if shapes should subtly animate.
  /// [animationDuration] is the duration of the animation cycle.
  const OrganicBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.shapeColor,
    this.numberOfShapes = 5,
    this.shapeOpacity = 0.05,
    this.seed = 42,
    this.animate = false,
    this.animationDuration = const Duration(seconds: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(
          color: backgroundColor,
        ),
        
        // Organic shapes
        ...List.generate(numberOfShapes, (index) {
          return _buildOrganicShape(index);
        }),
        
        // Main content
        child,
      ],
    );
  }
  
  Widget _buildOrganicShape(int index) {
    // Use seed + index for consistent but varied shapes
    final random = Random(seed + index);
    
    // Randomize shape properties
    final shapeType = random.nextInt(3); // 0: blob, 1: wave, 2: curved
    final size = 100.0 + random.nextDouble() * 200; // Size between 100-300
    final posX = random.nextDouble() * 0.8 - 0.2; // Position -0.2 to 0.6 (normalized)
    final posY = random.nextDouble() * 0.8 - 0.2; // Position -0.2 to 0.6 (normalized)
    final rotation = random.nextDouble() * 2 * pi; // Rotation 0-2π
    final opacity = (0.3 + random.nextDouble() * 0.7) * shapeOpacity; // Varied opacity
    
    // Create the shape
    Widget shape;
    
    switch (shapeType) {
      case 0: // Blob
        shape = ClipPath(
          clipper: BlobClipper(
            numberOfPoints: 6 + random.nextInt(6), // 6-12 points
            randomness: 0.3 + random.nextDouble() * 0.4, // 0.3-0.7 randomness
            seed: seed + index * 10,
          ),
          child: Container(
            color: shapeColor.withOpacity(opacity),
          ),
        );
        break;
        
      case 1: // Wave
        shape = ClipPath(
          clipper: WaveBottomClipper(
            amplitude: 20 + random.nextDouble() * 30, // 20-50 amplitude
            frequency: 0.5 + random.nextDouble() * 2, // 0.5-2.5 frequency
            phase: random.nextDouble() * 2 * pi, // Random phase
          ),
          child: Container(
            color: shapeColor.withOpacity(opacity),
          ),
        );
        break;
        
      default: // Curved
        shape = ClipPath(
          clipper: CurvedBottomClipper(
            curveHeight: 30 + random.nextDouble() * 50, // 30-80 curve height
            controlPointRatio: 0.3 + random.nextDouble() * 0.4, // 0.3-0.7 control point
          ),
          child: Container(
            color: shapeColor.withOpacity(opacity),
          ),
        );
        break;
    }
    
    // Position and size the shape
    return Positioned(
      left: posX * 100, // Convert to percentage
      top: posY * 100, // Convert to percentage
      width: size,
      height: size,
      child: Transform.rotate(
        angle: rotation,
        child: animate 
          ? _AnimatedShape(
              child: shape,
              duration: animationDuration,
              seed: seed + index,
            )
          : shape,
      ),
    );
  }
}

/// A widget that subtly animates a shape
class _AnimatedShape extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int seed;

  const _AnimatedShape({
    required this.child,
    required this.duration,
    required this.seed,
  });

  @override
  State<_AnimatedShape> createState() => _AnimatedShapeState();
}

class _AnimatedShapeState extends State<_AnimatedShape> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Create a random instance with the seed
    final random = Random(widget.seed);
    
    // Create animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    // Create scale animation (subtle)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0 + (random.nextDouble() * 0.2), // Scale up to 20%
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    // Create rotation animation (very subtle)
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: (random.nextDouble() * 0.2) - 0.1, // -0.1 to 0.1 radians
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    // Start the animation with a delay based on seed
    Future.delayed(Duration(milliseconds: random.nextInt(2000)), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
