import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/home/widgets/recommended_stylists_card.dart';
import 'package:zinapp_v2/features/home/widgets/social_feed_preview_card.dart';
import 'package:zinapp_v2/features/home/widgets/trending_styles_card.dart';
import 'package:zinapp_v2/features/home/widgets/upcoming_bookings_card.dart';
import 'package:zinapp_v2/features/home/widgets/user_status_card.dart';
import 'package:zinapp_v2/models/booking.dart';
import 'package:zinapp_v2/features/home/models/dashboard_post.dart';
import 'package:zinapp_v2/models/style.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/widgets/dashboard/dashboard_container.dart';

/// A dashboard for the home screen
/// Displays user status, upcoming bookings, trending styles, and more
class HomeDashboard extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;

  /// List of upcoming bookings
  final List<Booking> upcomingBookings;

  /// List of trending styles
  final List<Style> trendingStyles;

  /// List of recommended stylists
  final List<Stylist> recommendedStylists;

  /// List of recent posts
  final List<DashboardPost> recentPosts;

  /// Scroll controller for the dashboard
  final ScrollController? scrollController;

  /// Creates a home dashboard
  const HomeDashboard({
    super.key,
    required this.user,
    required this.upcomingBookings,
    required this.trendingStyles,
    required this.recommendedStylists,
    required this.recentPosts,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      controller: scrollController,
      children: [
        // User status card
        UserStatusCard(
          user: user,
          onLevelTap: () => context.go(AppRoutes.profile),
          onTokensTap: () => context.go(AppRoutes.rewardsHub),
        ),

        // Upcoming bookings card
        UpcomingBookingsCard(
          bookings: upcomingBookings,
          onBookingTap: (booking) {
            // TODO: Navigate to booking details
          },
          onViewAllTap: () => context.go(AppRoutes.bookingHistory),
          onBookNowTap: () => context.go(AppRoutes.booking),
        ),

        // Trending styles card
        TrendingStylesCard(
          styles: trendingStyles,
          onStyleTap: (style) {
            // TODO: Navigate to style details
          },
          onViewAllTap: () {
            // TODO: Navigate to styles list
          },
        ),

        // Recommended stylists card
        RecommendedStylistsCard(
          stylists: recommendedStylists,
          onStylistTap: (stylist) {
            context.go('${AppRoutes.stylistDetail.replaceAll(':id', '')}${stylist.id}');
          },
          onViewAllTap: () => context.go(AppRoutes.stylistList),
        ),

        // Social feed preview card
        SocialFeedPreviewCard(
          posts: recentPosts,
          onPostTap: (post) {
            context.go('${AppRoutes.postDetail.replaceAll(':id', '')}${post.id}');
          },
          onViewAllTap: () => context.go(AppRoutes.feed),
          onCreatePostTap: () => context.go(AppRoutes.createPost),
        ),
      ],
    );
  }
}
