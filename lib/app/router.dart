import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';
import 'package:zinapp_v2/widgets/splash_screen.dart';
// TODO: Import additional screen files when they are created
// import 'package:zinapp_v2/features/auth/screens/login_screen.dart';
// import 'package:zinapp_v2/features/home/screens/home_screen.dart'; // Example home

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
  initialLocation: AppRoutes.landing, // Start at the landing screen
  // TODO: Add error handling/builder
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),

  routes: <RouteBase>[
    // --- Landing / Authentication Routes ---
    GoRoute(
      path: AppRoutes.landing,
      name: AppRoutes.landing,
      builder: (BuildContext context, GoRouterState state) {
        // Use the splash screen as the landing screen
        return ZinSplashScreen(
          showGetStartedButton: true,
          onGetStarted: () => context.go(AppRoutes.showcase),
        );
      },
    ),

    // --- Component Showcase (Development Only) ---
    GoRoute(
      path: AppRoutes.showcase,
      name: AppRoutes.showcase,
      builder: (BuildContext context, GoRouterState state) {
        return const ComponentShowcaseScreen();
      },
    ),

    // --- Main Application Routes (Example Structure) ---
    // TODO: Add ShellRoute for persistent navigation (like BottomNavBar) if needed
    GoRoute(
      path: AppRoutes.home, // Example: '/home'
      name: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
         // TODO: Replace with actual Home/Feed Screen
        return const PlaceholderScreen(title: 'Home Screen');
      },
      // TODO: Add nested routes for features accessible from home
      // routes: <RouteBase>[
      //   GoRoute(path: 'profile', name: AppRoutes.profile, builder: ...),
      //   GoRoute(path: 'stylists', name: AppRoutes.stylistList, builder: ...),
      // ]
    ),

    // TODO: Add other top-level routes as needed (e.g., stylist profile, booking flow)

  ],

  // TODO: Implement redirection logic for authentication
  // redirect: (BuildContext context, GoRouterState state) {
  //   // Read authentication state (e.g., from Riverpod provider)
  //   final bool loggedIn = ...; // Check auth status
  //   final bool loggingIn = state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.signup;

  //   // If not logged in and not trying to log in, redirect to landing/login
  //   if (!loggedIn && !loggingIn && state.matchedLocation != AppRoutes.landing) {
  //     return AppRoutes.landing;
  //   }
  //   // If logged in and on landing/login/signup, redirect to home
  //   if (loggedIn && (state.matchedLocation == AppRoutes.landing || loggingIn)) {
  //     return AppRoutes.home;
  //   }
  //   // Otherwise, allow navigation
  //   return null;
  // },
);

/// Defines named routes for cleaner navigation.
abstract class AppRoutes {
  static const String landing = '/';
  static const String showcase = '/showcase'; // Development route for component showcase
  static const String login = '/login'; // Example
  static const String signup = '/signup'; // Example
  static const String home = '/home'; // Example
  static const String profile = '/profile'; // Example
  static const String stylistList = '/stylists'; // Example
  // Add other route names here
}
