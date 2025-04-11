import 'package:flutter/material.dart';

/// A navigation observer for ZinApp that tracks route transitions.
///
/// This observer can be used to track navigation events for analytics,
/// logging, or other purposes.
class ZinNavigationObserver extends NavigatorObserver {
  /// Creates a ZinApp navigation observer.
  ZinNavigationObserver({
    this.onRouteChange,
    this.enableLogging = false,
  });

  /// Callback that is called when a route is pushed or popped.
  final void Function(Route<dynamic>? route, Route<dynamic>? previousRoute)? onRouteChange;

  /// Whether to log navigation events to the console.
  final bool enableLogging;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logRouteChange('PUSH', route, previousRoute);
    onRouteChange?.call(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logRouteChange('POP', previousRoute, route);
    onRouteChange?.call(previousRoute, route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logRouteChange('REMOVE', previousRoute, route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logRouteChange('REPLACE', newRoute, oldRoute);
    onRouteChange?.call(newRoute, oldRoute);
  }

  /// Logs route changes if logging is enabled.
  void _logRouteChange(
    String action,
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  ) {
    if (!enableLogging) return;

    final String newRouteName = newRoute?.settings.name ?? 'Unknown';
    final String oldRouteName = oldRoute?.settings.name ?? 'Unknown';
    
    debugPrint('ZinNavigationObserver: $action - From: $oldRouteName To: $newRouteName');
  }
}
