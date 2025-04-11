import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/constants/app_animations.dart';

/// Background pattern variants for ZinApp
enum ZinBackgroundVariant {
  /// Subtle pattern with brand elements
  subtle,

  /// More prominent pattern for feature screens
  featured,

  /// Minimal pattern for content-heavy screens
  minimal,

  /// Special pattern for splash and onboarding
  special,
}

/// A customizable background component that reinforces the ZinApp brand identity.
///
/// This component creates subtle, animated patterns derived from the ZinApp logo
/// to create a distinctive, premium feel while maintaining readability of content.
class ZinBackground extends StatefulWidget {
  /// The child widget to display on top of the background
  final Widget child;

  /// The background pattern variant
  final ZinBackgroundVariant variant;

  /// Whether the background should be animated
  final bool animated;

  /// The background color (defaults to baseDark)
  final Color? backgroundColor;

  /// The pattern color (defaults to a subtle variant of primaryHighlight)
  final Color? patternColor;

  /// The opacity of the pattern (0.0 to 1.0)
  final double patternOpacity;

  /// The density of the pattern elements (0.0 to 1.0)
  final double patternDensity;

  const ZinBackground({
    super.key,
    required this.child,
    this.variant = ZinBackgroundVariant.subtle,
    this.animated = true,
    this.backgroundColor,
    this.patternColor,
    this.patternOpacity = 0.05,
    this.patternDensity = 0.5,
  });

  @override
  State<ZinBackground> createState() => _ZinBackgroundState();
}

class _ZinBackgroundState extends State<ZinBackground> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000), // Slow, subtle animation
    );

    // Create pulse animation
    _pulseAnimation = TweenSequence<double>(
      AppAnimations.getZinPulseSequence(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animation if enabled
    if (widget.animated) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ZinBackground oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation state if animated property changes
    if (widget.animated != oldWidget.animated) {
      if (widget.animated) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = widget.backgroundColor ?? AppColors.baseDark;
    final Color effectivePatternColor = widget.patternColor ??
        Color.fromRGBO(
          AppColors.primaryHighlight.r.toInt(),
          AppColors.primaryHighlight.g.toInt(),
          AppColors.primaryHighlight.b.toInt(),
          widget.patternOpacity,
        );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: _ZinPatternPainter(
                    variant: widget.variant,
                    patternColor: effectivePatternColor,
                    animationValue: widget.animated ? _animationController.value : 0,
                    pulseValue: widget.animated ? _pulseAnimation.value : 1.0,
                    density: widget.patternDensity,
                  ),
                ),
              ),

              // Content
              child!,
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Custom painter for ZinApp background patterns
class _ZinPatternPainter extends CustomPainter {
  final ZinBackgroundVariant variant;
  final Color patternColor;
  final double animationValue;
  final double pulseValue;
  final double density;

  _ZinPatternPainter({
    required this.variant,
    required this.patternColor,
    required this.animationValue,
    required this.pulseValue,
    required this.density,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (variant) {
      case ZinBackgroundVariant.subtle:
        _paintSubtlePattern(canvas, size);
        break;
      case ZinBackgroundVariant.featured:
        _paintFeaturedPattern(canvas, size);
        break;
      case ZinBackgroundVariant.minimal:
        _paintMinimalPattern(canvas, size);
        break;
      case ZinBackgroundVariant.special:
        _paintSpecialPattern(canvas, size);
        break;
    }
  }

  /// Paints a subtle pattern with small brand elements
  void _paintSubtlePattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.fill;

    // Calculate pattern parameters
    final elementSize = size.width * 0.05 * pulseValue;
    final spacing = size.width * 0.2 / density;

    // Create a slight offset based on animation
    final offsetX = animationValue * spacing * 0.2;
    final offsetY = animationValue * spacing * 0.1;

    // Draw pattern elements
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        // Add some randomness to positions
        final randomX = x + (math.sin(y * 0.1) * spacing * 0.2) + offsetX;
        final randomY = y + (math.cos(x * 0.1) * spacing * 0.2) + offsetY;

        // Draw a simplified "Z" shape (from ZinApp logo)
        final path = Path()
          ..moveTo(randomX, randomY)
          ..lineTo(randomX + elementSize, randomY)
          ..lineTo(randomX, randomY + elementSize)
          ..lineTo(randomX + elementSize, randomY + elementSize);

        canvas.drawPath(path, paint);
      }
    }
  }

  /// Paints a more prominent pattern for feature screens
  void _paintFeaturedPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Calculate pattern parameters
    final elementSize = size.width * 0.15 * pulseValue;
    final spacing = size.width * 0.4 / density;

    // Create a slight offset based on animation
    final offsetX = animationValue * spacing * 0.3;
    final offsetY = animationValue * spacing * 0.2;

    // Draw larger pattern elements
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        // Add some randomness to positions
        final randomX = x + (math.sin(y * 0.05) * spacing * 0.3) + offsetX;
        final randomY = y + (math.cos(x * 0.05) * spacing * 0.3) + offsetY;

        // Draw a stylized logo-inspired shape
        final path = Path()
          ..moveTo(randomX, randomY)
          ..lineTo(randomX + elementSize, randomY)
          ..lineTo(randomX + elementSize * 0.5, randomY + elementSize * 0.5)
          ..lineTo(randomX + elementSize, randomY + elementSize)
          ..lineTo(randomX, randomY + elementSize)
          ..lineTo(randomX + elementSize * 0.5, randomY + elementSize * 0.5)
          ..close();

        canvas.drawPath(path, paint);
      }
    }
  }

  /// Paints a minimal pattern for content-heavy screens
  void _paintMinimalPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.fill;

    // Calculate pattern parameters
    final dotSize = size.width * 0.01 * pulseValue;
    final spacing = size.width * 0.1 / density;

    // Create a slight offset based on animation
    final offsetX = animationValue * spacing * 0.1;
    final offsetY = animationValue * spacing * 0.1;

    // Draw small dots
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        // Add some randomness to positions
        final randomX = x + (math.sin(y * 0.2) * spacing * 0.1) + offsetX;
        final randomY = y + (math.cos(x * 0.2) * spacing * 0.1) + offsetY;

        // Draw a small dot
        canvas.drawCircle(Offset(randomX, randomY), dotSize, paint);
      }
    }
  }

  /// Paints a special pattern for splash and onboarding screens
  void _paintSpecialPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Calculate pattern parameters
    final elementSize = size.width * 0.2 * pulseValue;

    // Create a radial pattern emanating from the center
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.5;

    // Draw concentric shapes
    for (int i = 1; i <= 5; i++) {
      final radius = i * elementSize * (1 + animationValue * 0.1);

      // Draw a stylized shape
      final path = Path();

      // Create a shape with 6 points
      for (int j = 0; j < 6; j++) {
        final angle = (j * 60 + animationValue * 30) * math.pi / 180;
        final x = centerX + radius * math.cos(angle);
        final y = centerY + radius * math.sin(angle);

        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_ZinPatternPainter oldDelegate) {
    return oldDelegate.variant != variant ||
           oldDelegate.patternColor != patternColor ||
           oldDelegate.animationValue != animationValue ||
           oldDelegate.pulseValue != pulseValue ||
           oldDelegate.density != density;
  }
}
