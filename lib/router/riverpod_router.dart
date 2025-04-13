import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/error_screen.dart';
import 'package:zinapp_v2/router/custom_go_router.dart';
import 'package:zinapp_v2/router/custom_page_route.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/auth_screen.dart';
import 'package:zinapp_v2/features/auth/widgets/riverpod/auth_wrapper.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/forgot_password_screen.dart';
import 'package:zinapp_v2/features/feed/screens/riverpod/feed_screen.dart';
import 'package:zinapp_v2/features/home/screens/riverpod/dashboard_home_screen.dart';
import 'package:zinapp_v2/features/profile/screens/riverpod/profile_edit_screen.dart';
import 'package:zinapp_v2/features/profile/screens/riverpod/dashboard_profile_screen.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';
import 'package:zinapp_v2/features/showcase/screens/riverpod_test_screen.dart';
import 'package:zinapp_v2/features/booking/screens/riverpod/booking_confirmation_screen.dart';
import 'package:zinapp_v2/features/booking/screens/riverpod/booking_screen.dart';
import 'package:zinapp_v2/features/booking/screens/riverpod/booking_history_screen.dart';
import 'package:zinapp_v2/features/rewards/screens/challenges_screen.dart';
import 'package:zinapp_v2/features/rewards/screens/daily_rewards_screen.dart';
import 'package:zinapp_v2/features/rewards/screens/rewards_hub_screen.dart';
import 'package:zinapp_v2/features/rewards/screens/token_shop_screen.dart';
import 'package:zinapp_v2/features/stylist/screens/riverpod/stylist_discovery_screen.dart';
import 'package:zinapp_v2/features/stylist/screens/riverpod/stylist_profile_screen.dart';
import 'package:zinapp_v2/navigation/main_layout.dart';
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
GoRouter riverpodRouter(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    // Add error handling
    errorBuilder: (context, state) => ErrorScreen(error: state.error!),
    // Use custom page transitions
    // Default error page builder is already set above

    routes: <RouteBase>[
      // Main route with auth wrapper
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: MainLayout(
                showBottomNav: true,
                child: DashboardHomeScreen(),
              ),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.home,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Component Showcase (Development Only)
      GoRoute(
        path: AppRoutes.showcase,
        name: AppRoutes.showcase,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const ComponentShowcaseScreen(),
            name: AppRoutes.showcase,
            transitionType: TransitionType.dealCard,
          );
        },
      ),

      // Riverpod Test Screen (Development Only)
      GoRoute(
        path: AppRoutes.riverpodTest,
        name: AppRoutes.riverpodTest,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodTestScreen(),
            name: AppRoutes.riverpodTest,
            transitionType: TransitionType.portal,
          );
        },
      ),

      // Forgot Password Screen
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: AppRoutes.forgotPassword,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const ForgotPasswordScreen(),
            name: AppRoutes.forgotPassword,
            transitionType: TransitionType.fadeSlide,
          );
        },
      ),

      // Profile route (protected)
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profile,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: MainLayout(
                showBottomNav: true,
                child: DashboardProfileScreen(),
              ),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.profile,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Profile Edit route (protected)
      GoRoute(
        path: AppRoutes.profileEdit,
        name: AppRoutes.profileEdit,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: RiverpodProfileEditScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.profileEdit,
            transitionType: TransitionType.fadeSlide,
          );
        },
      ),

      // Feed route (protected)
      GoRoute(
        path: AppRoutes.feed,
        name: AppRoutes.feed,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: RiverpodFeedScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.feed,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Post Detail route (protected)
      GoRoute(
        path: AppRoutes.postDetail,
        name: AppRoutes.postDetail,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final postId = state.pathParameters['id'] ?? '';
          return CustomGoRouter.customPage(
            child: RiverpodAuthWrapper(
              authenticatedChild: PlaceholderScreen(title: 'Post Detail: $postId'),
              unauthenticatedChild: const RiverpodAuthScreen(),
            ),
            name: AppRoutes.postDetail,
            transitionType: TransitionType.fadeSlide,
          );
        },
      ),

      // Stylist list route (protected)
      GoRoute(
        path: AppRoutes.stylistList,
        name: AppRoutes.stylistList,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: MainLayout(
                showBottomNav: true,
                child: StylistDiscoveryScreen(),
              ),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.stylistList,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Stylist detail route (protected)
      GoRoute(
        path: AppRoutes.stylistDetail,
        name: AppRoutes.stylistDetail,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final stylistId = state.pathParameters['id'] ?? '';
          return CustomGoRouter.customPage(
            child: RiverpodAuthWrapper(
              authenticatedChild: StylistProfileScreen(stylistId: stylistId),
              unauthenticatedChild: const RiverpodAuthScreen(),
            ),
            name: AppRoutes.stylistDetail,
            transitionType: TransitionType.dealCard,
          );
        },
      ),

      // Booking route (protected)
      GoRoute(
        path: AppRoutes.booking,
        name: AppRoutes.booking,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: BookingScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.booking,
            transitionType: TransitionType.game,
          );
        },
      ),

      // Booking confirmation route (protected)
      GoRoute(
        path: AppRoutes.bookingConfirmation,
        name: AppRoutes.bookingConfirmation,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: BookingConfirmationScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.bookingConfirmation,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Booking history route (protected)
      GoRoute(
        path: AppRoutes.bookingHistory,
        name: AppRoutes.bookingHistory,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: MainLayout(
                showBottomNav: true,
                child: BookingHistoryScreen(),
              ),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.bookingHistory,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Rewards hub route (protected)
      GoRoute(
        path: AppRoutes.rewardsHub,
        name: AppRoutes.rewardsHub,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: MainLayout(
                showBottomNav: true,
                child: RewardsHubScreen(),
              ),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.rewardsHub,
            transitionType: TransitionType.fadeScale,
          );
        },
      ),

      // Daily rewards route (protected)
      GoRoute(
        path: AppRoutes.dailyRewards,
        name: AppRoutes.dailyRewards,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: DailyRewardsScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.dailyRewards,
            transitionType: TransitionType.dealCard,
          );
        },
      ),

      // Challenges route (protected)
      GoRoute(
        path: AppRoutes.challenges,
        name: AppRoutes.challenges,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: ChallengesScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.challenges,
            transitionType: TransitionType.game,
          );
        },
      ),

      // Token shop route (protected)
      GoRoute(
        path: AppRoutes.tokenShop,
        name: AppRoutes.tokenShop,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomGoRouter.customPage(
            child: const RiverpodAuthWrapper(
              authenticatedChild: TokenShopScreen(),
              unauthenticatedChild: RiverpodAuthScreen(),
            ),
            name: AppRoutes.tokenShop,
            transitionType: TransitionType.portal,
          );
        },
      ),

      // Messages route (protected)
      GoRoute(
        path: AppRoutes.messages,
        name: AppRoutes.messages,
        builder: (BuildContext context, GoRouterState state) {
          return const RiverpodAuthWrapper(
            authenticatedChild: PlaceholderScreen(title: 'Messages'),
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
