import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zinapp_v2/features/feed/widgets/post_card.dart';
import 'package:zinapp_v2/features/home/widgets/action_hub_section.dart';
import 'package:zinapp_v2/features/home/widgets/gamer_dashboard_section.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
// import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart'; // This provider might not be needed directly here
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/models/user_profile.dart'; // Ensure correct UserProfile model is imported
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/backgrounds/organic_background.dart';
import 'package:zinapp_v2/widgets/containers/organic_container.dart';

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
      // TODO: Re-evaluate if loading profile here is necessary, AuthProvider might handle it
      // ref.read(userProfileProviderProvider.notifier).loadUserProfile();
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
    // Get the current screen size
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: OrganicBackground(
        backgroundColor: AppColors.baseDarkDeeper,
        shapeColor: AppColors.baseDarkAccent,
        numberOfShapes: 5,
        shapeOpacity: 0.1,
        animate: true,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              // Refresh all data
              // TODO: Re-evaluate if loading profile here is necessary
              // await ref.read(userProfileProviderProvider.notifier).loadUserProfile();
              await ref.read(feedProvider.notifier).loadPosts();
              await ref.read(stylistProviderProvider.notifier).loadInitialData();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Gamer Dashboard
                SliverToBoxAdapter(
                  child: GamerDashboardSection(
                    user: user,
                  ),
                ),

                // Action Hub
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final stylistState = ref.watch(stylistProviderProvider);
                      return ActionHubSection(
                        stylists: stylistState.featuredStylists,
                        isLoading: stylistState.isLoading,
                        errorMessage: stylistState.error,
                      );
                    },
                  ),
                ),

                // Social Feed Header
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'Feed',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {
                            // TODO: Implement feed filtering
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feed filtering coming soon!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Social Feed Content
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverToBoxAdapter(
                    child: FloatingOrganicCard(
                      color: AppColors.baseDarkAlt,
                      borderRadius: 28,
                      elevation: 6,
                      enhancedShadow: true,
                      padding: const EdgeInsets.all(16),
                      child: _buildFeedContent(feedState),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),),
      // We'll use the bottom nav bar instead of floating action buttons
      floatingActionButton: _showScrollToTopButton ? FloatingActionButton.small(
        onPressed: _scrollToTop,
        backgroundColor: AppColors.primaryHighlight.withAlpha(204), // 0.8 opacity
        heroTag: 'scrollToTop',
        child: const Icon(Icons.arrow_upward, color: AppColors.baseDark),
      ) : null,
    );
  }

  Widget _buildFeedContent(FeedState feedState) {
    if (feedState.isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (feedState.error != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Error: ${feedState.error}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (feedState.posts.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No posts available')),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        padding: EdgeInsets.zero,
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
      ),
    );
  }
}
