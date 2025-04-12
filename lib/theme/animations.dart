import 'package:flutter/material.dart';

/// A class that defines the animation constants and durations used throughout the app
class AppAnimations {
  // Private constructor to prevent instantiation
  AppAnimations._();

  /// Duration for micro-animations (button presses, small UI changes)
  static const microDuration = Duration(milliseconds: 150);
  
  /// Duration for standard animations (card expansions, transitions)
  static const standardDuration = Duration(milliseconds: 300);
  
  /// Duration for elaborate animations (page transitions, celebrations)
  static const elaborateDuration = Duration(milliseconds: 500);
  
  /// Duration for long animations (onboarding, splash)
  static const longDuration = Duration(milliseconds: 800);

  /// Standard curve for most animations
  static const standardCurve = Curves.easeInOut;
  
  /// Curve for bouncy animations (achievements, rewards)
  static const bouncyCurve = Curves.elasticOut;
  
  /// Curve for quick animations (button presses)
  static const quickCurve = Curves.easeOutQuad;
  
  /// Curve for dramatic animations (page transitions)
  static const dramaticCurve = Curves.easeInOutCubic;

  /// Scale factor for press animations
  static const pressScale = 0.95;
  
  /// Scale factor for emphasis animations
  static const emphasisScale = 1.05;
}

/// A class that provides reusable animation builders
class AnimationBuilders {
  // Private constructor to prevent instantiation
  AnimationBuilders._();

  /// Creates a scale transition animation
  static Widget scale({
    required Widget child,
    required Animation<double> animation,
    Alignment alignment = Alignment.center,
  }) {
    return ScaleTransition(
      scale: animation,
      alignment: alignment,
      child: child,
    );
  }

  /// Creates a fade transition animation
  static Widget fade({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Creates a slide transition animation
  static Widget slide({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(0.0, 0.2),
    Offset endOffset = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: endOffset,
      ).animate(animation),
      child: child,
    );
  }

  /// Creates a combined fade and scale transition
  static Widget fadeScale({
    required Widget child,
    required Animation<double> animation,
    double beginScale = 0.95,
    double endScale = 1.0,
  }) {
    final scaleAnimation = Tween<double>(
      begin: beginScale,
      end: endScale,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Interval(0.0, 0.5, curve: AppAnimations.standardCurve),
    ));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Interval(0.3, 1.0, curve: AppAnimations.standardCurve),
    ));

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }

  /// Creates a combined fade and slide transition
  static Widget fadeSlide({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(0.0, 0.2),
    Offset endOffset = Offset.zero,
  }) {
    final slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Interval(0.0, 0.7, curve: AppAnimations.standardCurve),
    ));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Interval(0.0, 0.7, curve: AppAnimations.standardCurve),
    ));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }
}

/// A widget that adds a press animation to its child
class PressableAnimationWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final Curve curve;
  final double pressScale;

  const PressableAnimationWidget({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.pressScale = 0.95,
  });

  @override
  State<PressableAnimationWidget> createState() => _PressableAnimationWidgetState();
}

class _PressableAnimationWidgetState extends State<PressableAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

/// A widget that adds a pulse animation to its child
class PulseAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;
  final bool repeat;
  final double minScale;
  final double maxScale;

  const PulseAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
    this.repeat = true,
    this.minScale = 0.97,
    this.maxScale = 1.03,
  });

  @override
  State<PulseAnimationWidget> createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    if (widget.autoPlay) {
      if (widget.repeat) {
        _controller.repeat(reverse: true);
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}

/// A widget that adds a shimmer loading animation to its child
class ShimmerLoadingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;
  final bool enabled;

  const ShimmerLoadingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    required this.baseColor,
    required this.highlightColor,
    this.enabled = true,
  });

  @override
  State<ShimmerLoadingWidget> createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ShimmerLoadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: _SlidingGradientTransform(
                slidePercent: _animation.value,
              ),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * slidePercent,
      0.0,
      0.0,
    );
  }
}

/// A widget that adds a bounce animation to its child
class BounceAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const BounceAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.elasticOut,
    this.autoPlay = true,
    this.onComplete,
  });

  @override
  State<BounceAnimationWidget> createState() => _BounceAnimationWidgetState();
}

class _BounceAnimationWidgetState extends State<BounceAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    if (widget.autoPlay) {
      _controller.forward().then((_) {
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
