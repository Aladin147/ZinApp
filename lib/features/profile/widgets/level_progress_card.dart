import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card that displays the user's level progress and rewards for the next level.
class LevelProgressCard extends StatelessWidget {
  final int currentLevel;
  final int nextLevel;
  final int currentXp;
  final int xpToNextLevel;
  final List<String> rewards;

  const LevelProgressCard({
    super.key,
    required this.currentLevel,
    required this.nextLevel,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xpProgress = currentXp % 1000; // Simple calculation assuming 1000 XP per level
    final progressPercentage = xpProgress / 1000;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level Progress',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Level $currentLevel',
                  style: TextStyle(
                    color: AppColors.primaryHighlight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Progress bar
          Row(
            children: [
              Text(
                '$xpProgress',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressPercentage,
                    backgroundColor: Colors.grey.withAlpha(51), // 0.2 opacity
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryHighlight,
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '1000',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${1000 - xpProgress} XP to Level $nextLevel',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(179), // 0.7 opacity
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Rewards
          Text(
            'Level $nextLevel Rewards',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...rewards.map((reward) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  reward,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
