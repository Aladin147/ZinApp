import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/rewards/screens/challenges_screen.dart';
import 'package:zinapp_v2/providers/gamification/gamification_provider.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays active challenges
class ChallengesCard extends ConsumerWidget {
  const ChallengesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gamificationState = ref.watch(gamificationNotifierProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return ExpandableDashboardCard(
      title: 'Challenges',
      icon: Icons.emoji_events,
      accentColor: Colors.orange,
      onViewAllTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChallengesScreen(),
          ),
        );
      },
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final theme = Theme.of(context);

    // Mock data - in a real app, this would come from a provider
    const completedChallenges = 2;
    const totalChallenges = 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$completedChallenges of $totalChallenges challenges completed',
          style: theme.textTheme.bodyMedium,
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChallengeItem(
          context,
          title: 'Social Butterfly',
          description: 'Like 5 posts from stylists you follow',
          xpReward: 10,
          tokenReward: 5,
          progress: 2,
          maxProgress: 5,
          icon: Icons.thumb_up,
        ),
        const SizedBox(height: 12),

        _buildChallengeItem(
          context,
          title: 'Style Explorer',
          description: 'View 3 different hairstyle categories',
          xpReward: 15,
          tokenReward: 7,
          progress: 1,
          maxProgress: 3,
          icon: Icons.style,
        ),
        const SizedBox(height: 12),

        _buildChallengeItem(
          context,
          title: 'Community Contributor',
          description: 'Leave a comment on a post',
          xpReward: 20,
          tokenReward: 10,
          progress: 0,
          maxProgress: 1,
          icon: Icons.comment,
        ),

        const SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () {
              // Navigate to challenges screen
            },
            icon: const Icon(Icons.view_list),
            label: const Text('View All Challenges'),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeItem(
    BuildContext context, {
    required String title,
    required String description,
    required int xpReward,
    required int tokenReward,
    required int progress,
    required int maxProgress,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final isCompleted = progress >= maxProgress;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withOpacity(0.5)
              : theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.2)
                      : theme.colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted ? Icons.check : icon,
                  color: isCompleted ? Colors.green : theme.colorScheme.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.token,
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                '+$tokenReward',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.bolt,
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                '+$xpReward',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$progress/$maxProgress',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress / maxProgress,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                isCompleted ? Colors.green : theme.colorScheme.primary,
              ),
              minHeight: 4,
            ),
          ),
          if (isCompleted) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _claimReward(context, title, xpReward, tokenReward),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: const Size(0, 32),
                  textStyle: theme.textTheme.labelSmall,
                ),
                child: const Text('Claim'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _claimReward(BuildContext context, String challengeName, int xpReward, int tokenReward) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$challengeName reward claimed! +$tokenReward Tokens, +$xpReward XP'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
