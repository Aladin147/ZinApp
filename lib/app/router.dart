import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/app/error_screen.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/app/transitions/zin_navigation.dart';
import 'package:zinapp_v2/app/transitions/zin_navigation_observer.dart';
import 'package:zinapp_v2/features/auth/screens/login_screen.dart';
import 'package:zinapp_v2/features/auth/screens/register_screen.dart';
import 'package:zinapp_v2/features/auth/screens/forgot_password_screen.dart';
import 'package:zinapp_v2/features/feed/screens/feed_screen.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';
import 'package:zinapp_v2/widgets/splash_screen.dart';
// Import ZinBackgroundVariant through zin_navigation.dart

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
  // Add navigation observer for analytics and logging
  observers: [ZinNavigationObserver(enableLogging: true)],
  // Add error handling
  errorBuilder: (context, state) => ErrorScreen(error: state.error!),

  routes: <RouteBase>[
    // --- Landing / Authentication Routes ---
    GoRoute(
      path: AppRoutes.landing,
      name: AppRoutes.landing,
      pageBuilder: (BuildContext context, GoRouterState state) {
        // Use the splash screen as the landing screen
        return ZinNavigation.createGoRouterPage(
          child: ZinSplashScreen(
            showGetStartedButton: true,
            onGetStarted: () => context.go(AppRoutes.login),
          ),
          name: AppRoutes.landing,
          backgroundVariant: ZinBackgroundVariant.featured,
        );
      },
    ),

    // Login Screen
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.login,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ZinNavigation.createGoRouterPage(
          child: const LoginScreen(),
          name: AppRoutes.login,
          backgroundVariant: ZinBackgroundVariant.featured,
        );
      },
    ),

    // Register Screen
    GoRoute(
      path: AppRoutes.register,
      name: AppRoutes.register,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ZinNavigation.createGoRouterPage(
          child: const RegisterScreen(),
          name: AppRoutes.register,
          backgroundVariant: ZinBackgroundVariant.featured,
        );
      },
    ),

    // Forgot Password Screen
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: AppRoutes.forgotPassword,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ZinNavigation.createGoRouterPage(
          child: const ForgotPasswordScreen(),
          name: AppRoutes.forgotPassword,
          backgroundVariant: ZinBackgroundVariant.featured,
        );
      },
    ),

    // --- Component Showcase (Development Only) ---
    GoRoute(
      path: AppRoutes.showcase,
      name: AppRoutes.showcase,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ZinNavigation.createGoRouterPage(
          child: const ComponentShowcaseScreen(),
          name: AppRoutes.showcase,
          backgroundVariant: ZinBackgroundVariant.minimal,
          backgroundColor: AppColors.baseDark,
        );
      },
    ),

    // --- Main Application Routes (Example Structure) ---
    // TODO: Add ShellRoute for persistent navigation (like BottomNavBar) if needed
    GoRoute(
      path: AppRoutes.home, // Example: '/home'
      name: AppRoutes.home,
      pageBuilder: (BuildContext context, GoRouterState state) {
        // Feed Screen implementation
        return ZinNavigation.createGoRouterPage(
          child: const FeedScreen(),
          name: AppRoutes.home,
          backgroundVariant: ZinBackgroundVariant.featured,
        );
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
  // Authentication routes
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main app routes
  static const String home = '/home';
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
