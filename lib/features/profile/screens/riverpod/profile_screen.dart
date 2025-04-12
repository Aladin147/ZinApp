import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

class RiverpodProfileScreen extends ConsumerStatefulWidget {
  const RiverpodProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverpodProfileScreen> createState() => _RiverpodProfileScreenState();
}

class _RiverpodProfileScreenState extends ConsumerState<RiverpodProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Load user profile and token history
    Future.microtask(() {
      ref.read(userProfileProvider.notifier).loadUserProfile();
      ref.read(userProfileProvider.notifier).loadTokenHistory();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(userProfileProvider);
    final user = authState.user;
    final theme = Theme.of(context);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userProfileProvider.notifier).loadUserProfile();
          await ref.read(userProfileProvider.notifier).loadTokenHistory();
        },
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryHighlight,
                        AppColors.primaryHighlight.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar
                          ZinAvatar(
                            size: ZinAvatarSize.large,
                            imageUrl: user.profilePictureUrl,
                            initials: user.username.isNotEmpty ? user.username[0] : '?',
                          ),
                          const SizedBox(height: 8),
                          
                          // Username and rank
                          Text(
                            user.username,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.rank,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          
                          // Level and XP
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Level ${user.level}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${user.xp} XP',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          
                          // XP Progress bar
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.7, // TODO: Calculate actual progress
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Stats
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, user.tokens.toString(), 'Tokens'),
                    _buildStatItem(context, user.postsCount.toString(), 'Posts'),
                    _buildStatItem(context, user.followersCount.toString(), 'Followers'),
                    _buildStatItem(context, user.followingCount.toString(), 'Following'),
                  ],
                ),
              ),
            ),
            
            // Tab Bar
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
                  indicatorColor: theme.colorScheme.primary,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Achievements'),
                    Tab(text: 'Tokens'),
                  ],
                ),
              ),
              pinned: true,
            ),
            
            // Tab Content
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // About Tab
                  _buildAboutTab(context, user),
                  
                  // Achievements Tab
                  _buildAchievementsTab(context, user),
                  
                  // Tokens Tab
                  _buildTokensTab(context, profileState.tokenHistory),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutTab(BuildContext context, UserProfile user) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Bio
        if (user.bio != null && user.bio!.isNotEmpty) ...[
          Text(
            'Bio',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.bio!,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],
        
        // Location
        if (user.location != null && user.location!.isNotEmpty) ...[
          Text(
            'Location',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                user.location!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        
        // Favorite Styles
        if (user.favoriteStyles != null && user.favoriteStyles!.isNotEmpty) ...[
          Text(
            'Favorite Styles',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: user.favoriteStyles!.map((style) {
              return Chip(
                label: Text(style),
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                labelStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
        
        // Stylist Profile (if applicable)
        if (user.userType == UserType.stylist && user.stylistProfile != null) ...[
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Stylist Profile',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildStylistProfileSection(context, user.stylistProfile!),
        ],
      ],
    );
  }

  Widget _buildStylistProfileSection(BuildContext context, StylistProfile profile) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Specialization
        Text(
          'Specialization',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.specialization,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        
        // Services
        Text(
          'Services',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: profile.services.map((service) {
            return Chip(
              label: Text(service),
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
              labelStyle: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        
        // Rating
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '${profile.rating} (${profile.reviewCount} reviews)',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Business Info
        if (profile.businessName != null) ...[
          Text(
            'Business',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.businessName!,
            style: theme.textTheme.bodyMedium,
          ),
          if (profile.businessAddress != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    profile.businessAddress!,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ],
        
        // Stats
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStylistStatItem(context, profile.completedBookings.toString(), 'Bookings'),
            _buildStylistStatItem(context, profile.clientCount.toString(), 'Clients'),
            _buildStylistStatItem(
              context, 
              profile.isAvailable ? 'Available' : 'Unavailable',
              'Status',
              color: profile.isAvailable ? Colors.green : Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStylistStatItem(BuildContext context, String value, String label, {Color? color}) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsTab(BuildContext context, UserProfile user) {
    final theme = Theme.of(context);
    
    if (user.achievements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No achievements yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete actions to earn achievements',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: user.achievements.length,
      itemBuilder: (context, index) {
        final achievement = user.achievements[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 48, color: Colors.amber),
                const SizedBox(height: 8),
                Text(
                  achievement,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTokensTab(BuildContext context, List<TokenTransaction>? transactions) {
    final theme = Theme.of(context);
    
    if (transactions == null || transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.token_outlined,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No token transactions yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Earn and spend tokens to see your history here',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: _getTransactionIcon(transaction.type),
            title: Text(
              transaction.description ?? _getTransactionTypeLabel(transaction.type),
              style: theme.textTheme.titleSmall,
            ),
            subtitle: Text(
              _formatDate(transaction.timestamp),
              style: theme.textTheme.bodySmall,
            ),
            trailing: Text(
              _formatAmount(transaction.amount, transaction.type),
              style: theme.textTheme.titleMedium?.copyWith(
                color: _getAmountColor(transaction.type, theme),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getTransactionIcon(TokenTransactionType type) {
    IconData iconData;
    Color iconColor;
    
    switch (type) {
      case TokenTransactionType.earned:
        iconData = Icons.add_circle_outline;
        iconColor = Colors.green;
        break;
      case TokenTransactionType.spent:
        iconData = Icons.remove_circle_outline;
        iconColor = Colors.red;
        break;
      case TokenTransactionType.received:
        iconData = Icons.arrow_downward;
        iconColor = Colors.blue;
        break;
      case TokenTransactionType.sent:
        iconData = Icons.arrow_upward;
        iconColor = Colors.orange;
        break;
      case TokenTransactionType.system:
        iconData = Icons.settings;
        iconColor = Colors.purple;
        break;
    }
    
    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.1),
      child: Icon(iconData, color: iconColor),
    );
  }

  String _getTransactionTypeLabel(TokenTransactionType type) {
    switch (type) {
      case TokenTransactionType.earned:
        return 'Tokens Earned';
      case TokenTransactionType.spent:
        return 'Tokens Spent';
      case TokenTransactionType.received:
        return 'Tokens Received';
      case TokenTransactionType.sent:
        return 'Tokens Sent';
      case TokenTransactionType.system:
        return 'System Transaction';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatAmount(int amount, TokenTransactionType type) {
    switch (type) {
      case TokenTransactionType.earned:
      case TokenTransactionType.received:
        return '+$amount';
      case TokenTransactionType.spent:
      case TokenTransactionType.sent:
        return '-$amount';
      case TokenTransactionType.system:
        return amount >= 0 ? '+$amount' : '$amount';
    }
  }

  Color _getAmountColor(TokenTransactionType type, ThemeData theme) {
    switch (type) {
      case TokenTransactionType.earned:
      case TokenTransactionType.received:
        return Colors.green;
      case TokenTransactionType.spent:
      case TokenTransactionType.sent:
        return Colors.red;
      case TokenTransactionType.system:
        return theme.colorScheme.primary;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
