import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/feed/widgets/post_card.dart';
import 'package:zinapp_v2/features/home/widgets/action_hub_section.dart';
import 'package:zinapp_v2/features/home/widgets/gamer_dashboard_section.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class EnhancedHomeScreen extends ConsumerStatefulWidget {
  const EnhancedHomeScreen({super.key});

  @override
  ConsumerState<EnhancedHomeScreen> createState() => _EnhancedHomeScreenState();
}

class _EnhancedHomeScreenState extends ConsumerState<EnhancedHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Load user profile, feed data, and stylist data
    Future.microtask(() {
      ref.read(userProfileProviderProvider.notifier).loadUserProfile();
      ref.read(feedProvider.notifier).loadPosts();
      ref.read(stylistProviderProvider.notifier).loadInitialData();
    });

    // Add scroll listener for scroll-to-top button
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset < 400 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final feedState = ref.watch(feedProvider);
    final user = authState.user;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gamer Dashboard
              GamerDashboardSection(
                user: user,
              ),

              // Action Hub
              Consumer(
                builder: (context, ref, child) {
                  final stylistState = ref.watch(stylistProviderProvider);
                  return ActionHubSection(
                    stylists: stylistState.featuredStylists,
                    isLoading: stylistState.isLoading,
                    errorMessage: stylistState.error,
                  );
                },
              ),

              // Social Feed
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feed',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Feed content
                    SizedBox(
                      height: size.height * 0.5, // Fixed height for feed
                      child: _buildFeedContent(feedState),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Scroll to top button (only shown when scrolled down)
          if (_showScrollToTopButton)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FloatingActionButton.small(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.primaryHighlight.withAlpha(204), // 0.8 opacity
                heroTag: 'scrollToTop',
                child: const Icon(Icons.arrow_upward, color: AppColors.baseDark),
              ),
            ),
          // Profile button
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton.small(
              onPressed: () {
                context.go(AppRoutes.profile);
              },
              backgroundColor: AppColors.primaryHighlight.withAlpha(204), // 0.8 opacity
              heroTag: 'profile',
              child: const Icon(Icons.person, color: AppColors.baseDark),
            ),
          ),
          // Logout button (temporary for testing)
          FloatingActionButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            backgroundColor: AppColors.primaryHighlight,
            heroTag: 'logout',
            child: const Icon(Icons.logout, color: AppColors.baseDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedContent(FeedState feedState) {
    if (feedState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (feedState.error != null) {
      return Center(
        child: Text(
          'Error: ${feedState.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (feedState.posts.isEmpty) {
      return const Center(
        child: Text('No posts available'),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: feedState.posts.length,
      itemBuilder: (context, index) {
        final post = feedState.posts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PostCard(
            post: post,
            username: 'User ${post.userId}', // We'll implement proper user lookup later
          ),
        );
      },
    );
  }
}
