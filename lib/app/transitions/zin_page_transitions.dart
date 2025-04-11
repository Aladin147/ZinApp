import 'package:flutter/material.dart';
import 'package:zinapp_v2/constants/app_animations.dart';

/// Defines custom page transitions for ZinApp.
///
/// These transitions are designed to create a premium, branded navigation
/// experience that reinforces the ZinApp identity.
class ZinPageTransitions extends PageTransitionsTheme {
  /// Creates the ZinApp page transitions theme.
  const ZinPageTransitions()
      : super(
          builders: const {
            TargetPlatform.android: ZinPageTransitionsBuilder(),
            TargetPlatform.iOS: ZinPageTransitionsBuilder(),
            TargetPlatform.macOS: ZinPageTransitionsBuilder(),
            TargetPlatform.windows: ZinPageTransitionsBuilder(),
            TargetPlatform.linux: ZinPageTransitionsBuilder(),
            TargetPlatform.fuchsia: ZinPageTransitionsBuilder(),
          },
        );
}

/// Custom page transitions builder for ZinApp.
///
/// Creates smooth, premium transitions between pages that reinforce
/// the ZinApp brand identity.
class ZinPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates a ZinApp page transitions builder.
  const ZinPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Don't animate on the first route
    if (route.isFirst) {
      return child;
    }

    // Use different transitions based on whether we're pushing or popping
    final bool isPush = animation.status == AnimationStatus.forward || 
                        animation.status == AnimationStatus.completed;

    return ZinPageTransition(
      isPush: isPush,
      routeAnimation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

/// A custom page transition widget for ZinApp.
///
/// Creates a premium transition effect with combined fade, scale, and slide animations.
class ZinPageTransition extends StatelessWidget {
  /// Creates a ZinApp page transition.
  const ZinPageTransition({
    super.key,
    required this.child,
    required this.routeAnimation,
    required this.secondaryAnimation,
    required this.isPush,
  });

  /// The widget to animate.
  final Widget child;

  /// The primary animation (for the incoming route).
  final Animation<double> routeAnimation;

  /// The secondary animation (for the outgoing route).
  final Animation<double> secondaryAnimation;

  /// Whether this is a push (true) or pop (false) transition.
  final bool isPush;

  @override
  Widget build(BuildContext context) {
    // Create curved animations
    final Animation<double> primaryAnimation = CurvedAnimation(
      parent: routeAnimation,
      curve: AppAnimations.screenTransitionCurve,
      reverseCurve: AppAnimations.screenTransitionCurve.flipped,
    );

    final Animation<double> secondAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: AppAnimations.screenTransitionCurve,
      reverseCurve: AppAnimations.screenTransitionCurve.flipped,
    );

    // For incoming route (pushing)
    if (isPush) {
      return _buildPushTransition(primaryAnimation, secondAnimation);
    } 
    // For outgoing route (popping)
    else {
      return _buildPopTransition(primaryAnimation, secondAnimation);
    }
  }

  /// Builds the transition for pushing a new route.
  Widget _buildPushTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // Fade in the new page
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      // Slide in from the right with a slight scale effect
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.25, 0.0),
          end: Offset.zero,
        ).animate(animation),
        // Add a subtle scale effect
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
          child: child,
        ),
      ),
    );
  }

  /// Builds the transition for popping a route.
  Widget _buildPopTransition(
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // Fade out the current page
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
      // Slide out to the right
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.25, 0.0),
        ).animate(secondaryAnimation),
        // Add a subtle scale effect
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 0.92).animate(secondaryAnimation),
          child: child,
        ),
      ),
    );
  }
}
