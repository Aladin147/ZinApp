import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/rewards/widgets/achievements_card.dart';
import 'package:zinapp_v2/features/rewards/widgets/challenges_card.dart';
import 'package:zinapp_v2/features/rewards/widgets/daily_rewards_card.dart';
import 'package:zinapp_v2/features/rewards/widgets/token_shop_card.dart';
import 'package:zinapp_v2/widgets/dashboard/dashboard_container.dart';

/// A dashboard widget for the Rewards Hub screen
class RewardsDashboard extends ConsumerWidget {
  const RewardsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const Center(
        child: Text('User not found'),
      );
    }

    return DashboardContainer(
      children: [
        // Token balance and level progress
        _buildTokenBalanceCard(context, user),
        
        // Daily rewards card
        const DailyRewardsCard(),
        
        // Challenges card
        const ChallengesCard(),
        
        // Token shop card
        const TokenShopCard(),
        
        // Achievements card
        const AchievementsCard(),
      ],
    );
  }

  Widget _buildTokenBalanceCard(BuildContext context, dynamic user) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Token Balance',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
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
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to token shop
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Shop'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Level ${user.level} • ${user.xp} XP',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (user.xp % 1000) / 1000, // Simple progress calculation
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
