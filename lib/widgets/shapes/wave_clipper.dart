import 'dart:math';
import 'package:flutter/material.dart';

/// A custom clipper that creates a wave effect at the bottom of a widget
class WaveBottomClipper extends CustomClipper<Path> {
  /// The height of the wave from peak to trough
  final double amplitude;
  
  /// The number of complete waves across the width
  final double frequency;
  
  /// Controls the phase of the wave (horizontal shift)
  final double phase;

  /// Creates a wave clipper for the bottom edge of a container
  ///
  /// [amplitude] controls the height of the wave
  /// [frequency] controls how many waves appear across the width
  /// [phase] shifts the wave horizontally (useful for animations)
  WaveBottomClipper({
    this.amplitude = 20.0,
    this.frequency = 1.5,
    this.phase = 0.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start at top left
    path.lineTo(0, size.height - amplitude);
    
    // Create wave pattern
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i, 
        size.height - amplitude * sin((i / size.width) * 2 * pi * frequency + phase)
      );
    }
    
    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// A custom clipper that creates a wave effect at the top of a widget
class WaveTopClipper extends CustomClipper<Path> {
  /// The height of the wave from peak to trough
  final double amplitude;
  
  /// The number of complete waves across the width
  final double frequency;
  
  /// Controls the phase of the wave (horizontal shift)
  final double phase;

  /// Creates a wave clipper for the top edge of a container
  ///
  /// [amplitude] controls the height of the wave
  /// [frequency] controls how many waves appear across the width
  /// [phase] shifts the wave horizontally (useful for animations)
  WaveTopClipper({
    this.amplitude = 20.0,
    this.frequency = 1.5,
    this.phase = 0.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start at bottom left
    path.moveTo(0, amplitude);
    
    // Create wave pattern for top edge
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i, 
        amplitude * sin((i / size.width) * 2 * pi * frequency + phase)
      );
    }
    
    // Complete the path
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// A custom clipper that creates a curved edge on the bottom of a widget
class CurvedBottomClipper extends CustomClipper<Path> {
  /// The height of the curve
  final double curveHeight;
  
  /// The control point offset ratio (0.5 = centered)
  final double controlPointRatio;

  /// Creates a curved clipper for the bottom edge of a container
  ///
  /// [curveHeight] controls the height of the curve
  /// [controlPointRatio] controls the shape of the curve (0.5 = symmetric)
  CurvedBottomClipper({
    this.curveHeight = 30.0,
    this.controlPointRatio = 0.5,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start at top left
    path.lineTo(0, size.height - curveHeight);
    
    // Create a quadratic bezier curve for the bottom
    path.quadraticBezierTo(
      size.width * controlPointRatio, 
      size.height, 
      size.width, 
      size.height - curveHeight
    );
    
    // Complete the path
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// A custom clipper that creates an asymmetric curved shape
class AsymmetricClipper extends CustomClipper<Path> {
  /// The height of the left curve
  final double leftCurveHeight;
  
  /// The height of the right curve
  final double rightCurveHeight;
  
  /// The control point offset ratio
  final double controlPointRatio;

  /// Creates an asymmetric clipper with different curves on each side
  ///
  /// [leftCurveHeight] controls the height of the left curve
  /// [rightCurveHeight] controls the height of the right curve
  /// [controlPointRatio] controls the shape of the curves
  AsymmetricClipper({
    this.leftCurveHeight = 30.0,
    this.rightCurveHeight = 50.0,
    this.controlPointRatio = 0.5,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start at top left
    path.lineTo(0, size.height - leftCurveHeight);
    
    // Create a quadratic bezier curve for the bottom
    path.quadraticBezierTo(
      size.width * controlPointRatio, 
      size.height, 
      size.width, 
      size.height - rightCurveHeight
    );
    
    // Complete the path
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// A custom clipper that creates a blob-like shape
class BlobClipper extends CustomClipper<Path> {
  /// The number of points to use for the blob
  final int numberOfPoints;
  
  /// The randomness factor (0 = circle, 1 = very random)
  final double randomness;
  
  /// Random seed for consistent shapes
  final int seed;

  /// Creates a blob-shaped clipper
  ///
  /// [numberOfPoints] controls the complexity of the blob
  /// [randomness] controls how irregular the blob is (0-1)
  /// [seed] provides a consistent random shape
  BlobClipper({
    this.numberOfPoints = 10,
    this.randomness = 0.5,
    this.seed = 42,
  });

  @override
  Path getClip(Size size) {
    final random = Random(seed);
    final path = Path();
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final minRadius = min(size.width, size.height) * 0.4;
    final maxRadius = min(size.width, size.height) * 0.5;
    
    // Create the first point
    final firstRadius = _getRandomRadius(random, minRadius, maxRadius);
    final firstX = centerX + firstRadius * cos(0);
    final firstY = centerY + firstRadius * sin(0);
    path.moveTo(firstX, firstY);
    
    // Create the blob with random points
    for (int i = 1; i <= numberOfPoints; i++) {
      final angle = 2 * pi * i / numberOfPoints;
      final radius = _getRandomRadius(random, minRadius, maxRadius);
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      
      final controlAngle1 = 2 * pi * (i - 0.5) / numberOfPoints;
      final controlRadius1 = _getRandomRadius(random, minRadius, maxRadius);
      final controlX1 = centerX + controlRadius1 * cos(controlAngle1);
      final controlY1 = centerY + controlRadius1 * sin(controlAngle1);
      
      path.quadraticBezierTo(controlX1, controlY1, x, y);
    }
    
    // Close the path
    path.close();
    return path;
  }
  
  double _getRandomRadius(Random random, double min, double max) {
    return min + (max - min) * (1 - randomness * random.nextDouble());
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
