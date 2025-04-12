import 'package:flutter/material.dart';
import 'package:zinapp_v2/router/page_transitions.dart';

/// Enum defining the types of transitions available
enum TransitionType {
  fade,
  slide,
  scale,
  fadeSlide,
  fadeScale,
  game,
  dealCard,
  portal,
}

/// A custom page route that uses predefined transitions
class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;
  final TransitionType transitionType;
  final Duration duration;
  final Curve curve;
  final bool maintainStateValue;
  final bool fullscreenDialogValue;
  final Offset? slideOffset;

  CustomPageRoute({
    required this.child,
    this.transitionType = TransitionType.fadeSlide,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.maintainStateValue = true,
    this.fullscreenDialogValue = false,
    this.slideOffset,
    super.settings,
  });

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => maintainStateValue;

  @override
  bool get fullscreenDialog => fullscreenDialogValue;

  @override
  Duration get transitionDuration => this.duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create a curved animation based on the provided curve
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    // Apply the appropriate transition based on the transition type
    switch (transitionType) {
      case TransitionType.fade:
        return AppPageTransitions.fadeTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
      case TransitionType.slide:
        return AppPageTransitions.slideTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
          beginOffset: slideOffset ?? const Offset(1.0, 0.0),
        );
      case TransitionType.scale:
        return AppPageTransitions.scaleTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
      case TransitionType.fadeSlide:
        return AppPageTransitions.fadeSlideTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
          beginOffset: slideOffset ?? const Offset(0.0, 0.2),
        );
      case TransitionType.fadeScale:
        return AppPageTransitions.fadeScaleTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
      case TransitionType.game:
        return AppPageTransitions.gameTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
      case TransitionType.dealCard:
        return AppPageTransitions.dealCardTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
      case TransitionType.portal:
        return AppPageTransitions.portalTransition(
          context,
          curvedAnimation,
          secondaryAnimation,
          child,
        );
    }
  }
}

/// Extension on BuildContext to provide easy navigation methods with custom transitions
extension CustomNavigationExtension on BuildContext {
  /// Navigate to a new screen with a custom transition
  Future<T?> navigateWithTransition<T extends Object?>(
    Widget page, {
    TransitionType transitionType = TransitionType.fadeSlide,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool maintainState = true,
    bool fullscreenDialog = false,
    Offset? slideOffset,
    String? routeName,
  }) {
    return Navigator.of(this).push<T>(
      CustomPageRoute<T>(
        child: page,
        transitionType: transitionType,
        duration: duration,
        curve: curve,
        maintainStateValue: maintainState,
        fullscreenDialogValue: fullscreenDialog,
        slideOffset: slideOffset,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
      ),
    );
  }

  /// Replace the current screen with a new one using a custom transition
  Future<T?> replaceWithTransition<T extends Object?, TO extends Object?>(
    Widget page, {
    TransitionType transitionType = TransitionType.fadeSlide,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool maintainState = true,
    bool fullscreenDialog = false,
    Offset? slideOffset,
    String? routeName,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      CustomPageRoute<T>(
        child: page,
        transitionType: transitionType,
        duration: duration,
        curve: curve,
        maintainStateValue: maintainState,
        fullscreenDialogValue: fullscreenDialog,
        slideOffset: slideOffset,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
      ),
      result: result,
    );
  }

  /// Navigate to a new screen and remove all previous screens from the stack
  Future<T?> navigateAndRemoveUntilWithTransition<T extends Object?>(
    Widget page, {
    TransitionType transitionType = TransitionType.fadeSlide,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool maintainState = true,
    bool fullscreenDialog = false,
    Offset? slideOffset,
    String? routeName,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      CustomPageRoute<T>(
        child: page,
        transitionType: transitionType,
        duration: duration,
        curve: curve,
        maintainStateValue: maintainState,
        fullscreenDialogValue: fullscreenDialog,
        slideOffset: slideOffset,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
      ),
      predicate ?? (route) => false,
    );
  }
}
