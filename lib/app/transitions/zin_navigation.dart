import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/app/transitions/zin_route.dart';
import 'package:zinapp_v2/widgets/zin_background.dart';

/// A utility class for ZinApp navigation.
///
/// Provides helper methods for navigating with custom ZinApp transitions.
class ZinNavigation {
  /// Navigates to a new screen with a ZinApp branded transition.
  ///
  /// This method creates a custom [ZinRoute] with the specified parameters
  /// and pushes it onto the navigation stack.
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page, {
    ZinBackgroundPattern backgroundPattern = ZinBackgroundPattern.minimal,
    Color? backgroundColor,
    String? routeName,
  }) {
    return Navigator.of(context).push<T>(
      ZinRoute<T>(
        settings: RouteSettings(name: routeName),
        backgroundPattern: backgroundPattern,
        backgroundColor: backgroundColor,
        builder: (context) => page,
      ),
    );
  }

  /// Replaces the current screen with a new one using a ZinApp branded transition.
  ///
  /// This method creates a custom [ZinRoute] with the specified parameters
  /// and replaces the current route with it.
  static Future<T?> replace<T extends Object?>(
    BuildContext context,
    Widget page, {
    ZinBackgroundPattern backgroundPattern = ZinBackgroundPattern.minimal,
    Color? backgroundColor,
    String? routeName,
  }) {
    return Navigator.of(context).pushReplacement<T, dynamic>(
      ZinRoute<T>(
        settings: RouteSettings(name: routeName),
        backgroundPattern: backgroundPattern,
        backgroundColor: backgroundColor,
        builder: (context) => page,
      ),
    );
  }

  /// Pops all routes and pushes a new one with a ZinApp branded transition.
  ///
  /// This method is useful for resetting the navigation stack, such as
  /// when logging out or completing a flow.
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page, {
    ZinBackgroundPattern backgroundPattern = ZinBackgroundPattern.minimal,
    Color? backgroundColor,
    String? routeName,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      ZinRoute<T>(
        settings: RouteSettings(name: routeName),
        backgroundPattern: backgroundPattern,
        backgroundColor: backgroundColor,
        builder: (context) => page,
      ),
      predicate ?? (route) => false,
    );
  }

  /// Creates a custom page for use with GoRouter.
  ///
  /// This method creates a custom [Page] that uses ZinApp branded transitions
  /// when used with GoRouter.
  static Page<T> createGoRouterPage<T>({
    required Widget child,
    required String name,
    Object? arguments,
    ZinBackgroundPattern backgroundPattern = ZinBackgroundPattern.minimal,
    Color? backgroundColor,
  }) {
    return CustomTransitionPage<T>(
      child: child,
      name: name,
      arguments: arguments,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Create curved animations
        final Animation<double> primaryAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
          reverseCurve: Curves.fastOutSlowIn.flipped,
        );

        // Determine if we're pushing or popping
        final bool isPush = animation.status == AnimationStatus.forward || 
                          animation.status == AnimationStatus.completed;

        // For pushing a new route
        if (isPush) {
          return Stack(
            children: [
              // Background with pattern
              FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: primaryAnimation,
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
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(primaryAnimation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.25, 0.0),
                    end: Offset.zero,
                  ).animate(primaryAnimation),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.92, end: 1.0).animate(primaryAnimation),
                    child: child,
                  ),
                ),
              ),
            ],
          );
        } 
        // For popping a route
        else {
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
      },
    );
  }
}
