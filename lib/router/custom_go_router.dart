import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/router/custom_page_route.dart';

/// A class that provides custom GoRouter page builders
class CustomGoRouter {
  // Private constructor to prevent instantiation
  CustomGoRouter._();

  /// Creates a custom page for GoRouter with the specified transition
  static Page<dynamic> customPage<T>({
    required Widget child,
    required String name,
    TransitionType transitionType = TransitionType.fadeSlide,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Object? arguments,
    String? restorationId,
    Offset? slideOffset,
  }) {
    return CustomTransitionPage<T>(
      child: child,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Create a curved animation based on the provided curve
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        // Apply the appropriate transition based on the transition type
        switch (transitionType) {
          case TransitionType.fade:
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: slideOffset ?? const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: curvedAnimation,
              child: child,
            );
          case TransitionType.fadeSlide:
            final slideAnimation = Tween<Offset>(
              begin: slideOffset ?? const Offset(0.0, 0.2),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.7, curve: curve),
            ));

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.7, curve: curve),
            ));

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            );
          case TransitionType.fadeScale:
            final scaleAnimation = Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.5, curve: curve),
            ));

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Interval(0.3, 1.0, curve: curve),
            ));

            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            );
          case TransitionType.game:
            // Create a scale animation that starts slightly larger and settles to normal size
            final scaleAnimation = Tween<double>(
              begin: 1.1,
              end: 1.0,
            ).animate(curvedAnimation);

            // Create a fade animation
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation);

            // Combine the animations
            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            );
          case TransitionType.dealCard:
            // Create a rotation animation
            final rotationAnimation = Tween<double>(
              begin: 0.1,
              end: 0.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ));

            // Create a scale animation
            final scaleAnimation = Tween<double>(
              begin: 0.8,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ));

            // Create a slide animation
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0.0, -0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ));

            // Create a fade animation
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
            ));

            // Combine the animations
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Transform.rotate(
                    angle: rotationAnimation.value,
                    child: child,
                  ),
                ),
              ),
            );
          case TransitionType.portal:
            // Create a scale animation that starts from a small point
            final scaleAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCirc,
            ));

            // Create a rotation animation for a swirl effect
            final rotationAnimation = Tween<double>(
              begin: 0.5,
              end: 0.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCirc,
            ));

            // Create a fade animation
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            ));

            // Combine the animations
            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Transform.rotate(
                  angle: rotationAnimation.value,
                  child: child,
                ),
              ),
            );
        }
      },
      transitionDuration: duration,
    );
  }
}
