import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/features/profile/widgets/achievement_card.dart';
import 'package:zinapp_v2/features/profile/widgets/level_progress_card.dart';
import 'package:zinapp_v2/features/profile/widgets/token_balance_card.dart';
import 'package:zinapp_v2/features/profile/widgets/token_transaction_item.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user.dart';
import 'package:zinapp_v2/models/user_profile.dart' as models;
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A game-inspired user profile screen that showcases the user's achievements,
/// tokens, level, and other gamification elements.
class GameProfileScreen extends ConsumerStatefulWidget {
  const GameProfileScreen({super.key});

  @override
  ConsumerState<GameProfileScreen> createState() => _GameProfileScreenState();
}

class _GameProfileScreenState extends ConsumerState<GameProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);

    // Load user profile and token history
    Future.microtask(() {
      ref.read(userProfileProviderProvider.notifier).loadUserProfile();
      ref.read(userProfileProviderProvider.notifier).loadTokenHistory();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Show app bar title when scrolled past the header
    final showTitle = _scrollController.offset > 150;
    if (showTitle != _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = showTitle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(userProfileProviderProvider);
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
          await ref.read(userProfileProviderProvider.notifier).loadUserProfile();
          await ref.read(userProfileProviderProvider.notifier).loadTokenHistory();
        },
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // App Bar
              SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.baseDark,
                title: _showAppBarTitle ? Text(user.username) : null,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.baseDark,
                          AppColors.baseDark.withAlpha(230), // 0.9 opacity
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Avatar with level indicator
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Level indicator ring
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: SweepGradient(
                                      startAngle: 0,
                                      endAngle: 2 * 3.14 * 0.7, // 70% progress
                                      colors: [
                                        AppColors.primaryHighlight,
                                        AppColors.primaryHighlight.withAlpha(77), // 0.3 opacity
                                      ],
                                    ),
                                    border: Border.all(
                                      color: AppColors.baseDark,
                                      width: 4,
                                    ),
                                  ),
                                ),

                                // Avatar
                                ZinAvatar(
                                  size: ZinAvatarSize.large,
                                  imageUrl: user.profilePictureUrl,
                                  initials: user.username.isNotEmpty ? user.username[0] : '?',
                                ),

                                // Level badge
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryHighlight,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(77), // 0.3 opacity
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'LVL ${user.level}',
                                      style: const TextStyle(
                                        color: AppColors.baseDark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                color: Colors.white.withAlpha(204), // 0.8 opacity
                              ),
                            ),

                            // XP Progress bar
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${user.xp} XP',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '/ ${(user.level + 1) * 1000}', // Simple level calculation
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withAlpha(153), // 0.6 opacity
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (user.xp % 1000) / 1000, // Simple progress calculation
                                backgroundColor: Colors.white.withAlpha(77), // 0.3 opacity
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryHighlight,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      context.go(AppRoutes.profileEdit);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // TODO: Navigate to settings
                    },
                  ),
                ],
              ),

              // Stats Bar
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26), // 0.1 opacity
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        context,
                        icon: Icons.token,
                        value: user.tokens.toString(),
                        label: 'Tokens',
                        color: Colors.amber,
                      ),
                      _buildStatItem(
                        context,
                        icon: Icons.emoji_events,
                        value: user.achievements.length.toString(),
                        label: 'Achievements',
                        color: Colors.purple,
                      ),
                      _buildStatItem(
                        context,
                        icon: Icons.calendar_today,
                        value: user.bookingsCount.toString(),
                        label: 'Bookings',
                        color: Colors.green,
                      ),
                      _buildStatItem(
                        context,
                        icon: Icons.people,
                        value: user.followersCount.toString(),
                        label: 'Followers',
                        color: Colors.blue,
                      ),
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
                    unselectedLabelColor: theme.colorScheme.onSurface.withAlpha(179), // 0.7 opacity
                    indicatorColor: theme.colorScheme.primary,
                    tabs: const [
                      Tab(text: 'Character'),
                      Tab(text: 'Achievements'),
                      Tab(text: 'Tokens'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // Character Tab
              _buildCharacterTab(context, user),

              // Achievements Tab
              _buildAchievementsTab(context, user),

              // Tokens Tab
              _buildTokensTab(context, profileState.tokenHistory ?? []),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(179), // 0.7 opacity
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterTab(BuildContext context, models.UserProfile user) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Level Progress Card
        LevelProgressCard(
          currentLevel: user.level,
          nextLevel: user.level + 1,
          currentXp: user.xp,
          xpToNextLevel: (user.level + 1) * 1000,
          rewards: [
            'New Avatar Frame',
            '+100 Token Bonus',
            'Exclusive Style Access',
          ],
        ),
        const SizedBox(height: 24),

        // Token Balance Card
        TokenBalanceCard(
          tokenBalance: user.tokens,
          onManagePressed: () {
            _tabController.animateTo(2); // Switch to Tokens tab
          },
        ),
        const SizedBox(height: 24),

        // Bio
        if (user.bio != null && user.bio!.isNotEmpty) ...[
          Text(
            'About Me',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26), // 0.1 opacity
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              user.bio!,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
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
                backgroundColor: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                labelStyle: TextStyle(
                  color: AppColors.primaryHighlight.withAlpha(230), // 0.9 opacity
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Stylist Profile (if applicable)
        if (user.userType == UserType.stylist && user.stylistProfile != null) ...[
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

  Widget _buildAchievementsTab(BuildContext context, models.UserProfile user) {
    final theme = Theme.of(context);

    // Group achievements by category (this would be more sophisticated in a real app)
    final unlockedAchievements = user.achievements;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Unlocked Achievements',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Achievement grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: unlockedAchievements.length + 3, // Add some locked placeholders
          itemBuilder: (context, index) {
            final hasAchievement = index < unlockedAchievements.length;

            return AchievementCard(
              title: hasAchievement ? 'Achievement ${index + 1}' : 'Locked',
              iconData: hasAchievement
                ? _getAchievementIcon(unlockedAchievements[index])
                : Icons.lock,
              isUnlocked: hasAchievement,
              rarity: hasAchievement ? 'Common' : 'Unknown',
              onTap: () {
                if (hasAchievement) {
                  _showAchievementDetails(context, unlockedAchievements[index]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Keep playing to unlock this achievement!'),
                    ),
                  );
                }
              },
            );
          },
        ),

        const SizedBox(height: 24),

        // Achievement progress
        Text(
          'Achievement Progress',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26), // 0.1 opacity
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Achievements',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    '${unlockedAchievements.length}/20',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: unlockedAchievements.length / 20,
                  backgroundColor: Colors.grey.withAlpha(51), // 0.2 opacity
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primaryHighlight,
                  ),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTokensTab(BuildContext context, List<TokenTransaction> transactions) {
    final theme = Theme.of(context);
    final user = ref.watch(authProvider).user;

    if (user == null) {
      return const Center(child: Text('User not found'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Token Balance
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryHighlight,
                AppColors.primaryHighlight.withAlpha(204), // 0.8 opacity
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryHighlight.withAlpha(77), // 0.3 opacity
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Balance',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withAlpha(230), // 0.9 opacity
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.token,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${user.tokens}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement token earning opportunities
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Earn more tokens feature coming soon!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryHighlight,
                    ),
                    child: const Text('Earn More'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Tokens expire after 6 months of inactivity',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withAlpha(204), // 0.8 opacity
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Transaction History
        Text(
          'Transaction History',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        if (transactions.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 48,
                    color: theme.colorScheme.onSurface.withAlpha(128), // 0.5 opacity
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(179), // 0.7 opacity
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete activities to earn tokens',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(128), // 0.5 opacity
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TokenTransactionItem(transaction: transaction);
            },
          ),
      ],
    );
  }

  Widget _buildStylistProfileSection(BuildContext context, dynamic stylistProfile) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26), // 0.1 opacity
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Specialties
          if (stylistProfile.specialties.isNotEmpty) ...[
            Text(
              'Specialties',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: stylistProfile.specialties.map((specialty) {
                return Chip(
                  label: Text(specialty),
                  backgroundColor: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                  labelStyle: TextStyle(
                    color: AppColors.primaryHighlight.withAlpha(230), // 0.9 opacity
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Experience
          Row(
            children: [
              const Icon(Icons.work, size: 16),
              const SizedBox(width: 8),
              Text(
                'Experience: ${stylistProfile.yearsOfExperience} years',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                'Rating: ${stylistProfile.rating.toStringAsFixed(1)}/5.0',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAchievementDetails(BuildContext context, String achievementId) {
    // In a real app, we would fetch the achievement details from a service
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Achievement: $achievementId'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getAchievementIcon(achievementId),
              size: 48,
              color: AppColors.primaryHighlight,
            ),
            const SizedBox(height: 16),
            const Text('Congratulations on unlocking this achievement!'),
            const SizedBox(height: 8),
            const Text('Rewards: +100 XP, +50 Tokens'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement sharing
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing coming soon!'),
                ),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  IconData _getAchievementIcon(String achievementId) {
    // In a real app, this would be based on the achievement type
    final icons = [
      Icons.emoji_events,
      Icons.star,
      Icons.favorite,
      Icons.bolt,
      Icons.local_fire_department,
      Icons.psychology,
      Icons.public,
      Icons.military_tech,
    ];

    // Use the achievement ID to deterministically select an icon
    final hashCode = achievementId.hashCode.abs();
    return icons[hashCode % icons.length];
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
