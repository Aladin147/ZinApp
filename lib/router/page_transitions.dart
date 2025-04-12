import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/animations.dart';

/// A class that provides custom page transitions for the app
class AppPageTransitions {
  // Private constructor to prevent instantiation
  AppPageTransitions._();

  /// Creates a fade transition between pages
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimationBuilders.fade(
      animation: animation,
      child: child,
    );
  }

  /// Creates a slide transition between pages
  static Widget slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child, {
    Offset beginOffset = const Offset(1.0, 0.0),
    Offset endOffset = Offset.zero,
  }) {
    return AnimationBuilders.slide(
      animation: animation,
      beginOffset: beginOffset,
      endOffset: endOffset,
      child: child,
    );
  }

  /// Creates a scale transition between pages
  static Widget scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimationBuilders.scale(
      animation: animation,
      child: child,
    );
  }

  /// Creates a combined fade and slide transition between pages
  static Widget fadeSlideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child, {
    Offset beginOffset = const Offset(0.0, 0.2),
    Offset endOffset = Offset.zero,
  }) {
    return AnimationBuilders.fadeSlide(
      animation: animation,
      beginOffset: beginOffset,
      endOffset: endOffset,
      child: child,
    );
  }

  /// Creates a combined fade and scale transition between pages
  static Widget fadeScaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimationBuilders.fadeScale(
      animation: animation,
      child: child,
    );
  }

  /// Creates a game-like transition with a dramatic scale and fade effect
  static Widget gameTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create a curved animation for more dramatic effect
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: AppAnimations.dramaticCurve,
    );

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
  }

  /// Creates a transition that simulates a card being dealt onto the screen
  static Widget dealCardTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create a curved animation for more dramatic effect
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutBack,
    );

    // Create a rotation animation
    final rotationAnimation = Tween<double>(
      begin: 0.1,
      end: 0.0,
    ).animate(curvedAnimation);

    // Create a scale animation
    final scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(curvedAnimation);

    // Create a slide animation
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.5),
      end: Offset.zero,
    ).animate(curvedAnimation);

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
  }

  /// Creates a transition that simulates a portal opening
  static Widget portalTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create a curved animation for more dramatic effect
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCirc,
    );

    // Create a scale animation that starts from a small point
    final scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // Create a rotation animation for a swirl effect
    final rotationAnimation = Tween<double>(
      begin: 0.5,
      end: 0.0,
    ).animate(curvedAnimation);

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
}
