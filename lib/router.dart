import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/error_screen.dart';
import 'package:zinapp_v2/features/auth/screens/auth_screen.dart';
import 'package:zinapp_v2/features/auth/widgets/auth_wrapper.dart';
import 'package:zinapp_v2/features/home/screens/enhanced_home_screen.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';

// Placeholder widget for screens not yet created
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title - Coming Soon!')),
    );
  }
}


/// Defines the application's routes using go_router.
final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  // Add error handling
  errorBuilder: (context, state) => ErrorScreen(error: state.error!),

  routes: <RouteBase>[
    // Main route with auth wrapper
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper(
          authenticatedChild: EnhancedHomeScreen(),
          unauthenticatedChild: AuthScreen(),
        );
      },
    ),

    // Component Showcase (Development Only)
    GoRoute(
      path: AppRoutes.showcase,
      name: AppRoutes.showcase,
      builder: (BuildContext context, GoRouterState state) {
        return const ComponentShowcaseScreen();
      },
    ),

    // Profile route (protected)
    GoRoute(
      path: AppRoutes.profile,
      name: AppRoutes.profile,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper(
          authenticatedChild: PlaceholderScreen(title: 'Profile'),
          unauthenticatedChild: AuthScreen(),
        );
      },
    ),

    // Stylist list route (protected)
    GoRoute(
      path: AppRoutes.stylistList,
      name: AppRoutes.stylistList,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper(
          authenticatedChild: PlaceholderScreen(title: 'Stylists'),
          unauthenticatedChild: AuthScreen(),
        );
      },
    ),

    // Stylist detail route (protected)
    GoRoute(
      path: AppRoutes.stylistDetail,
      name: AppRoutes.stylistDetail,
      builder: (BuildContext context, GoRouterState state) {
        final stylistId = state.pathParameters['id'] ?? '';
        return AuthWrapper(
          authenticatedChild: PlaceholderScreen(title: 'Stylist $stylistId'),
          unauthenticatedChild: const AuthScreen(),
        );
      },
    ),

    // Booking route (protected)
    GoRoute(
      path: AppRoutes.booking,
      name: AppRoutes.booking,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper(
          authenticatedChild: PlaceholderScreen(title: 'Booking'),
          unauthenticatedChild: AuthScreen(),
        );
      },
    ),
  ],

  // Redirect based on authentication state
  redirect: (BuildContext context, GoRouterState state) {
    // Skip redirection during auth check
    if (state.matchedLocation == AppRoutes.home) {
      return null;
    }

    // Check authentication state
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isAuthenticated = authProvider.isAuthenticated;

    // If not authenticated and trying to access protected route, redirect to home
    if (!isAuthenticated &&
        state.matchedLocation != AppRoutes.home &&
        state.matchedLocation != AppRoutes.showcase) {
      return AppRoutes.home;
    }

    // Allow navigation
    return null;
  },
);

/// Defines named routes for cleaner navigation.
abstract class AppRoutes {
  // Main app routes
  static const String home = '/';
  static const String profile = '/profile';
  static const String stylistList = '/stylists';
  static const String stylistDetail = '/stylists/:id';
  static const String booking = '/booking';
  static const String bookingConfirmation = '/booking/confirmation';
  static const String messages = '/messages';
  static const String messageDetail = '/messages/:id';

  // Development routes
  static const String showcase = '/showcase'; // Component showcase
}
