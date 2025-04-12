import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/services/providers/gamification_provider.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A screen that displays challenges and quests for earning tokens and XP
class ChallengesScreen extends ConsumerStatefulWidget {
  const ChallengesScreen({super.key});

  @override
  ConsumerState<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends ConsumerState<ChallengesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize gamification provider
    Future.microtask(() {
      ref.read(gamificationProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gamificationState = ref.watch(gamificationProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges & Quests'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Special'),
          ],
        ),
      ),
      body: gamificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Daily challenges
                _buildDailyChallenges(context),

                // Weekly challenges
                _buildWeeklyChallenges(context),

                // Special challenges
                _buildSpecialChallenges(context),
              ],
            ),
    );
  }

  Widget _buildDailyChallenges(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildChallengeCard(
          context,
          title: 'Social Butterfly',
          description: 'Like 5 posts from stylists you follow',
          xpReward: 10,
          tokenReward: 5,
          progress: 2,
          maxProgress: 5,
          icon: Icons.thumb_up,
          actionText: 'Go to Feed',
          onAction: () {
            // TODO: Navigate to feed
          },
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'Style Explorer',
          description: 'View 3 different hairstyle categories',
          xpReward: 15,
          tokenReward: 7,
          progress: 1,
          maxProgress: 3,
          icon: Icons.style,
          actionText: 'Browse Styles',
          onAction: () {
            // TODO: Navigate to styles
          },
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'Community Contributor',
          description: 'Leave a comment on a post',
          xpReward: 20,
          tokenReward: 10,
          progress: 0,
          maxProgress: 1,
          icon: Icons.comment,
          actionText: 'Go to Feed',
          onAction: () {
            // TODO: Navigate to feed
          },
        ),
      ],
    );
  }

  Widget _buildWeeklyChallenges(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildChallengeCard(
          context,
          title: 'Booking Master',
          description: 'Book an appointment with a new stylist',
          xpReward: 50,
          tokenReward: 25,
          progress: 0,
          maxProgress: 1,
          icon: Icons.calendar_today,
          actionText: 'Find Stylists',
          onAction: () {
            // TODO: Navigate to stylist discovery
          },
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'Style Showcase',
          description: 'Share a photo of your new hairstyle',
          xpReward: 40,
          tokenReward: 20,
          progress: 0,
          maxProgress: 1,
          icon: Icons.photo_camera,
          actionText: 'Take Photo',
          onAction: () {
            // TODO: Navigate to camera
          },
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'Feedback Champion',
          description: 'Rate and review 3 stylists you\'ve visited',
          xpReward: 30,
          tokenReward: 15,
          progress: 1,
          maxProgress: 3,
          icon: Icons.star,
          actionText: 'View Bookings',
          onAction: () {
            // TODO: Navigate to bookings
          },
        ),
      ],
    );
  }

  Widget _buildSpecialChallenges(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildChallengeCard(
          context,
          title: 'Refer a Friend',
          description: 'Invite a friend to join ZinApp',
          xpReward: 100,
          tokenReward: 50,
          progress: 0,
          maxProgress: 1,
          icon: Icons.person_add,
          actionText: 'Invite Friends',
          onAction: () {
            // TODO: Show invite dialog
          },
          isSpecial: true,
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'Style Journey',
          description: 'Book 5 different types of hair services',
          xpReward: 200,
          tokenReward: 100,
          progress: 2,
          maxProgress: 5,
          icon: Icons.diversity_3,
          actionText: 'View Services',
          onAction: () {
            // TODO: Navigate to services
          },
          isSpecial: true,
        ),
        const SizedBox(height: 16),

        _buildChallengeCard(
          context,
          title: 'ZinApp Ambassador',
          description: 'Reach 10 followers and maintain a 5-star rating',
          xpReward: 500,
          tokenReward: 250,
          progress: 3,
          maxProgress: 10,
          icon: Icons.emoji_events,
          actionText: 'View Profile',
          onAction: () {
            // TODO: Navigate to profile
          },
          isSpecial: true,
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required String title,
    required String description,
    required int xpReward,
    required int tokenReward,
    required int progress,
    required int maxProgress,
    required IconData icon,
    required String actionText,
    required VoidCallback onAction,
    bool isSpecial = false,
  }) {
    final theme = Theme.of(context);
    final isCompleted = progress >= maxProgress;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: isSpecial
            ? Border.all(
                color: Colors.purple,
                width: 2,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSpecial ? Colors.purple.withOpacity(0.1) : null,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.withOpacity(0.2)
                        : isSpecial
                            ? Colors.purple.withOpacity(0.2)
                            : AppColors.primaryHighlight.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : icon,
                    color: isCompleted
                        ? Colors.green
                        : isSpecial
                            ? Colors.purple
                            : AppColors.primaryHighlight,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSpecial) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'SPECIAL',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          const Divider(height: 1),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rewards
                Row(
                  children: [
                    const Icon(
                      Icons.token,
                      color: AppColors.primaryHighlight,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+$tokenReward',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.bolt,
                      color: AppColors.primaryHighlight,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+$xpReward',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress / maxProgress,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted
                                ? Colors.green
                                : isSpecial
                                    ? Colors.purple
                                    : AppColors.primaryHighlight,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$progress/$maxProgress',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action button
                SizedBox(
                  width: double.infinity,
                  child: isCompleted
                      ? ElevatedButton(
                          onPressed: () => _claimReward(context, title, xpReward, tokenReward),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Claim Reward'),
                        )
                      : ElevatedButton(
                          onPressed: onAction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSpecial
                                ? Colors.purple
                                : AppColors.primaryHighlight,
                            foregroundColor: isSpecial ? Colors.white : Colors.black,
                          ),
                          child: Text(actionText),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _claimReward(BuildContext context, String challengeName, int xpReward, int tokenReward) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }

    // TODO: Implement challenge reward claiming
    // This would involve:
    // 1. Checking if the challenge is actually completed
    // 2. Awarding tokens and XP
    // 3. Marking the challenge as claimed

    // For now, just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$challengeName reward claimed! +$tokenReward Tokens, +$xpReward XP'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
