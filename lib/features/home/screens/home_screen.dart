import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/app/features/feed/widgets/post_card.dart';
import 'package:zinapp_v2/app/features/stylist/widgets/stylist_carousel.dart';
import 'package:zinapp_v2/app/providers/auth_provider.dart';
import 'package:zinapp_v2/app/providers/feed_provider.dart';
import 'package:zinapp_v2/app/providers/stylist_provider.dart';
import 'package:zinapp_v2/app/providers/user_profile_provider.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load user profile, stylist data, and feed data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context, listen: false).loadUserProfile();
      Provider.of<StylistProvider>(context, listen: false).loadInitialData();
      Provider.of<FeedProvider>(context, listen: false).loadPosts();
    });
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

    // Calculate section heights
    final hudHeight = size.height * 0.2;
    final actionZoneHeight = size.height * 0.3;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HUD Dashboard (20% of screen height)
            Container(
              height: hudHeight,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.baseDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: User info and tokens
                  Row(
                    children: [
                      // User avatar and info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: user?.profilePictureUrl != null
                                ? AssetImage(user!.profilePictureUrl!)
                                : null,
                            child: user?.profilePictureUrl == null
                                ? const Icon(Icons.person)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.username ?? 'User',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user?.rank ?? 'Novice',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Token display
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryHighlight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.token,
                              color: AppColors.primaryHighlight,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${user?.tokens ?? 0}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppColors.primaryHighlight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // XP progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Level ${user?.level ?? 1}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${user?.xp ?? 0} XP',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.7, // TODO: Calculate actual progress
                          backgroundColor:
                              AppColors.primaryHighlight.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryHighlight),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action & Discovery Zone (30% of screen height)
            Container(
              height: actionZoneHeight,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.baseDark.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Stylists
                  Expanded(
                    child: StylistCarousel(
                      title: 'Featured Stylists',
                      stylists: stylistProvider.featuredStylists,
                      isLoading: stylistProvider.isLoading,
                      errorMessage: stylistProvider.error,
                      onStylistTap: (stylist) {
                        // Navigate to stylist detail
                      },
                      onSeeAllTap: () {
                        // Navigate to all stylists
                      },
                    ),
                  ),

                  // Quick action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.search,
                          label: 'Find',
                          onTap: () {},
                        ),
                        _buildActionButton(
                          context,
                          icon: Icons.calendar_today,
                          label: 'Book',
                          onTap: () {},
                        ),
                        _buildActionButton(
                          context,
                          icon: Icons.camera_alt,
                          label: 'Share',
                          onTap: () {},
                        ),
                        _buildActionButton(
                          context,
                          icon: Icons.star,
                          label: 'Quests',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Social Feed (50% of screen height - remaining space)
            Expanded(
              child: Container(
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
                    Expanded(
                      child: _buildFeedContent(context, feedProvider),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Logout button (temporary for testing)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AuthProvider>(context, listen: false).logout();
        },
        backgroundColor: AppColors.primaryHighlight,
        child: const Icon(Icons.logout, color: AppColors.baseDark),
      ),
    );
  }

  Widget _buildFeedContent(BuildContext context, FeedProvider feedProvider) {
    if (feedProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (feedProvider.error != null) {
      return Center(
        child: Text(
          feedProvider.error!,
          style: TextStyle(
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (feedProvider.posts.isEmpty) {
      return Center(
        child: Text(
          'No posts found',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: feedProvider.posts.length,
      itemBuilder: (context, index) {
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
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.primaryHighlight,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
