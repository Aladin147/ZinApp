import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/error_screen.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/auth_screen.dart';
import 'package:zinapp_v2/features/auth/widgets/riverpod/auth_wrapper.dart';
import 'package:zinapp_v2/features/feed/screens/riverpod/feed_screen.dart';
import 'package:zinapp_v2/features/home/screens/enhanced_home_screen.dart';
import 'package:zinapp_v2/features/profile/screens/riverpod/profile_edit_screen.dart';
import 'package:zinapp_v2/features/profile/screens/riverpod/profile_screen.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';
import 'package:zinapp_v2/features/showcase/screens/riverpod_test_screen.dart';
import 'package:zinapp_v2/router/app_routes.dart';

// Generate the provider code
part 'riverpod_router.g.dart';

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

/// Provider for the router configuration
@riverpod
GoRouter riverpodRouter(RiverpodRouterRef ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    // Add error handling
    errorBuilder: (context, state) => ErrorScreen(error: state.error!),

    routes: <RouteBase>[
      // Main route with auth wrapper
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: EnhancedHomeScreen(),
            unauthenticatedChild: RiverpodAuthScreen(),
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

      // Riverpod Test Screen (Development Only)
      GoRoute(
        path: AppRoutes.riverpodTest,
        name: AppRoutes.riverpodTest,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodTestScreen();
        },
      ),

      // Profile route (protected)
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: RiverpodProfileScreen(),
            unauthenticatedChild: RiverpodAuthScreen(),
          );
        },
      ),

      // Profile Edit route (protected)
      GoRoute(
        path: AppRoutes.profileEdit,
        name: AppRoutes.profileEdit,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: RiverpodProfileEditScreen(),
            unauthenticatedChild: RiverpodAuthScreen(),
          );
        },
      ),

      // Feed route (protected)
      GoRoute(
        path: AppRoutes.feed,
        name: AppRoutes.feed,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: RiverpodFeedScreen(),
            unauthenticatedChild: RiverpodAuthScreen(),
          );
        },
      ),

      // Post Detail route (protected)
      GoRoute(
        path: AppRoutes.postDetail,
        name: AppRoutes.postDetail,
        builder: (BuildContext context, GoRouterState state) {
          final postId = state.pathParameters['id'] ?? '';
          return RiverpodAuthWrapper(
            authenticatedChild: PlaceholderScreen(title: 'Post Detail: $postId'),
            unauthenticatedChild: const RiverpodAuthScreen(),
          );
        },
      ),

      // Stylist list route (protected)
      GoRoute(
        path: AppRoutes.stylistList,
        name: AppRoutes.stylistList,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: PlaceholderScreen(title: 'Stylists'),
            unauthenticatedChild: RiverpodAuthScreen(),
          );
        },
      ),

      // Stylist detail route (protected)
      GoRoute(
        path: AppRoutes.stylistDetail,
        name: AppRoutes.stylistDetail,
        builder: (BuildContext context, GoRouterState state) {
          final stylistId = state.pathParameters['id'] ?? '';
          return RiverpodAuthWrapper(
            authenticatedChild: PlaceholderScreen(title: 'Stylist $stylistId'),
            unauthenticatedChild: const RiverpodAuthScreen(),
          );
        },
      ),

      // Booking route (protected)
      GoRoute(
        path: AppRoutes.booking,
        name: AppRoutes.booking,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: PlaceholderScreen(title: 'Booking'),
            unauthenticatedChild: RiverpodAuthScreen(),
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
      final bool isAuthenticated = authState.isAuthenticated;

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
}
