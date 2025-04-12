import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/app/router.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/features/feed/widgets/feed_header.dart';
import 'package:zinapp_v2/features/feed/widgets/post_card.dart';
import 'package:zinapp_v2/features/feed/widgets/stylist_card.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/mock_api_service.dart';
import 'package:zinapp_v2/widgets/zin_background.dart';

/// The main feed screen of the ZinApp application
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  final MockApiService _apiService = MockApiService();
  late TabController _tabController;

  List<Post> _posts = [];
  List<Stylist> _stylists = [];
  UserProfile? _currentUser;

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load current user
      final userProfile = await _apiService.getUserProfile('user123');

      // Load feed posts
      final posts = await _apiService.getFeedPosts('user123');

      // Load nearby stylists
      final stylists = await _apiService.getNearbyStylists(0, 0);

      // Update state
      setState(() {
        _currentUser = userProfile;
        _posts = posts;
        _stylists = stylists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load feed data: $e';
        _isLoading = false;
      });
    }
  }

  void _handleLike(Post post) {
    // In a real app, this would call the API to like/unlike the post
    print('Liked post: ${post.postId}');
  }

  void _handleComment(Post post) {
    // In a real app, this would navigate to the comments screen
    print('Comment on post: ${post.postId}');
  }

  void _handleShare(Post post) {
    // In a real app, this would show a share dialog
    print('Share post: ${post.postId}');
  }

  void _handlePostTap(Post post) {
    // In a real app, this would navigate to the post detail screen
    print('Tapped post: ${post.postId}');
  }

  void _handleUserTap(UserProfile user) {
    // In a real app, this would navigate to the user profile screen
    print('Tapped user: ${user.userId}');
  }

  void _handleStylistTap(Stylist stylist) {
    // In a real app, this would navigate to the stylist profile screen
    print('Tapped stylist: ${stylist.stylistId}');
  }

  void _handleBookStylist(Stylist stylist) {
    // In a real app, this would navigate to the booking screen
    print('Book stylist: ${stylist.stylistId}');
  }

  void _handleSearch() {
    // In a real app, this would navigate to the search screen
    print('Search tapped');
  }

  void _handleNotifications() {
    // In a real app, this would navigate to the notifications screen
    print('Notifications tapped');
  }

  void _handleProfileTap() {
    // In a real app, this would navigate to the profile screen
    print('Profile tapped');
  }

  void _navigateToComponentShowcase(BuildContext context) {
    context.go(AppRoutes.showcase);
  }

  void _handleRefresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ZinBackground(
      variant: ZinBackgroundVariant.featured,
      animated: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? _buildLoadingState()
            : _errorMessage != null
                ? _buildErrorState()
                : _buildContent(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryHighlight),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? 'An error occurred',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryHighlight,
              foregroundColor: Colors.black,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_currentUser == null) {
      return const Center(
        child: Text('User not found'),
      );
    }

    return Column(
      children: [
        // Safe area at the top
        SizedBox(height: MediaQuery.of(context).padding.top),

        // Header
        FeedHeader(
          user: _currentUser!,
          onSearch: _handleSearch,
          onNotifications: _handleNotifications,
          onProfileTap: _handleProfileTap,
        ),

        // Tab bar
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryHighlight,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryHighlight,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Discover'),
          ],
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // For You tab - Posts
              RefreshIndicator(
                onRefresh: () => _loadData(),
                color: AppColors.primaryHighlight,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];

                    // Find the user or stylist who created the post
                    UserProfile? postUser;
                    Stylist? postStylist;

                    if (post.userId != null) {
                      // For simplicity, we're just using the current user
                      // In a real app, we would fetch the user from the API
                      postUser = _currentUser;
                    } else if (post.stylistId != null) {
                      // Find the stylist in our list
                      postStylist = _stylists.firstWhere(
                        (s) => s.stylistId == post.stylistId,
                        orElse: () => _stylists.first,
                      );
                    }

                    return PostCard(
                      post: post,
                      user: postUser,
                      stylist: postStylist,
                      currentUser: _currentUser!,
                      onLike: _handleLike,
                      onComment: _handleComment,
                      onShare: _handleShare,
                      onTap: _handlePostTap,
                      onUserTap: _handleUserTap,
                      onStylistTap: _handleStylistTap,
                    );
                  },
                ),
              ),

              // Discover tab - Stylists
              RefreshIndicator(
                onRefresh: () => _loadData(),
                color: AppColors.primaryHighlight,
                child: ListView(
                  padding: const EdgeInsets.only(top: 16, bottom: 24),
                  children: [
                    // Nearby stylists section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'Nearby Stylists',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // In a real app, this would navigate to the stylists screen
                              print('View all stylists');
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Horizontal list of stylists
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: _stylists.length,
                        itemBuilder: (context, index) {
                          return StylistCard(
                            stylist: _stylists[index],
                            onTap: _handleStylistTap,
                            onBook: _handleBookStylist,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Featured section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Featured Styles',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Grid of featured styles
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 4, // Show 4 featured styles
                      itemBuilder: (context, index) {
                        return _buildFeaturedStyle(index);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedStyle(int index) {
    // Use placeholder colors instead of missing images
    final colors = [
      Colors.teal,
      Colors.purple,
      Colors.orange,
      Colors.indigo,
    ];

    final titles = [
      'Summer Fade',
      'Classic Waves',
      'Modern Crop',
      'Textured Layers',
    ];

    return GestureDetector(
      onTap: () {
        // In a real app, this would navigate to the style detail screen
        print('Tapped featured style: ${titles[index % titles.length]}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: colors[index % colors.length],
                // Use solid colors instead of missing images
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            titles[index % titles.length],
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          // Subtitle
          Text(
            'Trending now',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(179), // 70% opacity
            ),
          ),
        ],
      ),
    );
  }
}
