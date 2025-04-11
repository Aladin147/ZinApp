import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/constants/app_animations.dart';
import 'package:zinapp_v2/widgets/zin_background.dart';

/// A custom route that adds ZinApp branding to page transitions.
///
/// This route enhances the standard page transitions with branded
/// background patterns and premium animation effects.
class ZinRoute<T> extends PageRoute<T> {
  /// Creates a ZinApp branded route.
  ZinRoute({
    required this.builder,
    this.transitionDuration = AppAnimations.screenTransitionDuration,
    this.reverseTransitionDuration = AppAnimations.screenTransitionDuration,
    this.backgroundPattern = ZinBackgroundPattern.minimal,
    this.backgroundColor,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.settings,
  });

  /// The widget builder for this route.
  final WidgetBuilder builder;

  /// The background pattern to use during the transition.
  final ZinBackgroundPattern backgroundPattern;

  /// The background color to use during the transition.
  final Color? backgroundColor;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool maintainState;

  @override
  final bool fullscreenDialog;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Don't animate on the first route
    if (isFirst) {
      return child;
    }

    // Create curved animations
    final Animation<double> primaryAnimation = CurvedAnimation(
      parent: animation,
      curve: AppAnimations.screenTransitionCurve,
      reverseCurve: AppAnimations.screenTransitionCurve.flipped,
    );

    final Animation<double> secondAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: AppAnimations.screenTransitionCurve,
      reverseCurve: AppAnimations.screenTransitionCurve.flipped,
    );

    // Determine if we're pushing or popping
    final bool isPush = animation.status == AnimationStatus.forward || 
                        animation.status == AnimationStatus.completed;

    return _ZinTransitionOverlay(
      animation: primaryAnimation,
      secondaryAnimation: secondAnimation,
      backgroundColor: backgroundColor ?? AppColors.baseDark,
      backgroundPattern: backgroundPattern,
      isPush: isPush,
      child: child,
    );
  }

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => true;
}

/// A custom transition overlay that adds ZinApp branding elements.
class _ZinTransitionOverlay extends StatelessWidget {
  const _ZinTransitionOverlay({
    required this.child,
    required this.animation,
    required this.secondaryAnimation,
    required this.backgroundColor,
    required this.backgroundPattern,
    required this.isPush,
  });

  final Widget child;
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Color backgroundColor;
  final ZinBackgroundPattern backgroundPattern;
  final bool isPush;

  @override
  Widget build(BuildContext context) {
    // For pushing a new route
    if (isPush) {
      return _buildPushTransition();
    } 
    // For popping a route
    else {
      return _buildPopTransition();
    }
  }

  /// Builds the transition for pushing a new route.
  Widget _buildPushTransition() {
    return Stack(
      children: [
        // Background with pattern
        FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
            ),
          ),
          child: ZinBackground(
            backgroundColor: backgroundColor,
            pattern: backgroundPattern,
            patternOpacity: 0.1,
            animated: true,
          ),
        ),
        
        // Content with slide and scale
        FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.25, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the transition for popping a route.
  Widget _buildPopTransition() {
    return Stack(
      children: [
        // Background with pattern (for the route being revealed)
        FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: secondaryAnimation,
              curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
            ),
          ),
          child: ZinBackground(
            backgroundColor: backgroundColor,
            pattern: backgroundPattern,
            patternOpacity: 0.1,
            animated: true,
          ),
        ),
        
        // Content with slide and scale
        FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.25, 0.0),
            ).animate(secondaryAnimation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.92).animate(secondaryAnimation),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
