import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/features/feed/widgets/post_card.dart';
import 'package:zinapp_v2/features/home/widgets/action_hub_section.dart';
import 'package:zinapp_v2/features/home/widgets/gamer_dashboard_section.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/feed_provider.dart';
import 'package:zinapp_v2/features/stylist/providers/stylist_provider.dart';
import 'package:zinapp_v2/features/profile/providers/user_profile_provider.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class EnhancedHomeScreen extends StatefulWidget {
  const EnhancedHomeScreen({Key? key}) : super(key: key);

  @override
  State<EnhancedHomeScreen> createState() => _EnhancedHomeScreenState();
}

class _EnhancedHomeScreenState extends State<EnhancedHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Load user profile, stylist data, and feed data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context, listen: false).loadUserProfile();
      Provider.of<StylistProvider>(context, listen: false).loadInitialData();
      Provider.of<FeedProvider>(context, listen: false).loadPosts();
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
    final authProvider = Provider.of<AuthProvider>(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final stylistProvider = Provider.of<StylistProvider>(context);
    final feedProvider = Provider.of<FeedProvider>(context);
    final user = authProvider.user;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Gamer Dashboard Section
            SliverToBoxAdapter(
              child: GamerDashboardSection(user: user),
            ),

            // Action Hub Section
            SliverToBoxAdapter(
              child: ActionHubSection(
                stylists: stylistProvider.featuredStylists,
                isLoading: stylistProvider.isLoading,
                errorMessage: stylistProvider.error,
              ),
            ),

            // Feed Section Header
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Feed',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      // Feed filter options
                      DropdownButton<String>(
                        value: 'All',
                        icon: const Icon(Icons.filter_list),
                        underline: Container(),
                        onChanged: (String? newValue) {
                          // TODO: Implement feed filtering
                        },
                        items: <String>['All', 'Following', 'Trending', 'Local']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Feed Content
            _buildFeedContent(context, feedProvider),
          ],
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
                backgroundColor: AppColors.primaryHighlight.withOpacity(0.8),
                child: const Icon(Icons.arrow_upward, color: AppColors.baseDark),
              ),
            ),
          // Logout button (temporary for testing)
          FloatingActionButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            backgroundColor: AppColors.primaryHighlight,
            child: const Icon(Icons.logout, color: AppColors.baseDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedContent(BuildContext context, FeedProvider feedProvider) {
    if (feedProvider.isLoading) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (feedProvider.error != null) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            feedProvider.error!,
            style: TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (feedProvider.posts.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            'No posts found',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final post = feedProvider.posts[index];
          final user = feedProvider.getUserForPost(post.userId);

          return PostCard(
            post: post,
            username: user?.username ?? 'Unknown User',
            userProfilePictureUrl: user?.profilePictureUrl,
            onLikeTap: () => feedProvider.likePost(post.id),
            onCommentTap: () {},
            onShareTap: () {},
            onUserTap: () {},
          );
        },
        childCount: feedProvider.posts.length,
      ),
    );
  }
}

// Helper class for SliverPersistentHeader
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
