import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays user achievements
class AchievementsCard extends ConsumerWidget {
  const AchievementsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return ExpandableDashboardCard(
      title: 'Achievements',
      icon: Icons.military_tech,
      accentColor: Colors.green,
      onViewAllTap: () {
        // Navigate to achievements screen or profile
      },
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final theme = Theme.of(context);

    // Mock data - in a real app, this would come from a provider
    const unlockedAchievements = 5;
    const totalAchievements = 20;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$unlockedAchievements of $totalAchievements achievements unlocked',
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
    final theme = Theme.of(context);

    // Mock achievement data
    final recentAchievements = [
      {
        'title': 'First Booking',
        'description': 'Book your first appointment with a stylist',
        'isUnlocked': true,
        'rarity': 'Common',
        'icon': Icons.calendar_today,
        'color': Colors.blue,
        'xpReward': 10,
        'tokenReward': 5,
      },
      {
        'title': 'Social Starter',
        'description': 'Make your first post in the community',
        'isUnlocked': true,
        'rarity': 'Common',
        'icon': Icons.post_add,
        'color': Colors.purple,
        'xpReward': 10,
        'tokenReward': 5,
      },
      {
        'title': 'Style Explorer',
        'description': 'Browse 10 different hairstyles',
        'isUnlocked': false,
        'rarity': 'Uncommon',
        'icon': Icons.style,
        'color': Colors.orange,
        'xpReward': 20,
        'tokenReward': 10,
        'progress': 7,
        'maxProgress': 10,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Achievements',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Recent achievements list
        ...recentAchievements.map((achievement) => _buildAchievementItem(
          context,
          title: achievement['title'] as String,
          description: achievement['description'] as String,
          isUnlocked: achievement['isUnlocked'] as bool,
          rarity: achievement['rarity'] as String,
          icon: achievement['icon'] as IconData,
          color: achievement['color'] as Color,
          xpReward: achievement['xpReward'] as int,
          tokenReward: achievement['tokenReward'] as int,
          progress: achievement['progress'] as int?,
          maxProgress: achievement['maxProgress'] as int?,
        )).toList(),

        const SizedBox(height: 16),

        // Achievement stats
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achievement Progress',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAchievementStat(
                context,
                label: 'Common',
                unlocked: 4,
                total: 8,
                color: Colors.green,
              ),
              const SizedBox(height: 4),
              _buildAchievementStat(
                context,
                label: 'Uncommon',
                unlocked: 1,
                total: 6,
                color: Colors.blue,
              ),
              const SizedBox(height: 4),
              _buildAchievementStat(
                context,
                label: 'Rare',
                unlocked: 0,
                total: 4,
                color: Colors.purple,
              ),
              const SizedBox(height: 4),
              _buildAchievementStat(
                context,
                label: 'Epic',
                unlocked: 0,
                total: 2,
                color: Colors.orange,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () {
              // Navigate to achievements screen
            },
            icon: const Icon(Icons.view_list),
            label: const Text('View All Achievements'),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(
    BuildContext context, {
    required String title,
    required String description,
    required bool isUnlocked,
    required String rarity,
    required IconData icon,
    required Color color,
    required int xpReward,
    required int tokenReward,
    int? progress,
    int? maxProgress,
  }) {
    final theme = Theme.of(context);
    final hasProgress = progress != null && maxProgress != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnlocked
              ? color.withOpacity(0.5)
              : theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? color.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isUnlocked ? color : Colors.grey,
                  size: 20,
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
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? theme.colorScheme.onSurface : Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getRarityColor(rarity).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            rarity,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getRarityColor(rarity),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isUnlocked
                            ? theme.colorScheme.onSurface.withOpacity(0.7)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Rewards
          Row(
            children: [
              const Icon(
                Icons.token,
                size: 14,
                color: Colors.amber,
              ),
              const SizedBox(width: 2),
              Text(
                '+$tokenReward',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.amber : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.bolt,
                size: 14,
                color: Colors.blue,
              ),
              const SizedBox(width: 2),
              Text(
                '+$xpReward',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),

          // Progress bar (if applicable)
          if (hasProgress) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress / maxProgress,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 4,
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
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementStat(
    BuildContext context, {
    required String label,
    required int unlocked,
    required int total,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$unlocked/$total',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '${(unlocked / total * 100).toInt()}%',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: unlocked / total,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return Colors.green;
      case 'uncommon':
        return Colors.blue;
      case 'rare':
        return Colors.purple;
      case 'epic':
        return Colors.orange;
      case 'legendary':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
