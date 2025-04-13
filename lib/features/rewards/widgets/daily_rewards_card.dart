import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/rewards/screens/daily_rewards_screen.dart';
import 'package:zinapp_v2/providers/gamification/gamification_provider.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays daily rewards and streak information
/// 
/// This widget shows the user's current streak, allows them to claim
/// daily rewards, and displays information about streak-based rewards.
class DailyRewardsCard extends ConsumerStatefulWidget {
  const DailyRewardsCard({super.key});

  @override
  ConsumerState<DailyRewardsCard> createState() => _DailyRewardsCardState();
}

class _DailyRewardsCardState extends ConsumerState<DailyRewardsCard> {
  bool _dailyRewardClaimed = false;
  final _today = DateTime.now();
  final _formatter = DateFormat('EEEE, MMMM d');

  @override
  void initState() {
    super.initState();
    // Initialize gamification provider
    Future.microtask(() {
      ref.read(gamificationNotifierProvider.notifier).initialize();
    });
    // TODO: Check if daily reward already claimed from storage
  }

  @override
  Widget build(BuildContext context) {
    // Use ref from ConsumerState
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return ExpandableDashboardCard(
      title: 'Daily Rewards',
      icon: Icons.calendar_today,
      accentColor: Colors.blue,
      onViewAllTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DailyRewardsScreen(),
          ),
        );
      },
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final theme = Theme.of(context);

    // Mock streak data
    const currentStreak = 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.local_fire_department,
              color: Colors.orange,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              '$currentStreak day streak',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _dailyRewardClaimed ? null : () => _claimDailyReward(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.withOpacity(0.3),
          ),
          child: Text(_dailyRewardClaimed ? 'Claimed' : 'Claim Daily'),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final theme = Theme.of(context);

    // Mock streak data
    const currentStreak = 3;
    const longestStreak = 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatter.format(_today),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Daily login reward
        _buildDailyRewardSection(context),
        const SizedBox(height: 16),

        // Streak information
        Text(
          'Your Streak',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStreakStat(
              context,
              label: 'Current',
              value: '$currentStreak days',
              icon: Icons.local_fire_department,
              color: Colors.orange,
            ),
            _buildStreakStat(
              context,
              label: 'Longest',
              value: '$longestStreak days',
              icon: Icons.emoji_events,
              color: Colors.amber,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Week progress
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _DayIndicator(day: 'M', isActive: true, isToday: false),
            _DayIndicator(day: 'T', isActive: true, isToday: false),
            _DayIndicator(day: 'W', isActive: true, isToday: true),
            _DayIndicator(day: 'T', isActive: false, isToday: false),
            _DayIndicator(day: 'F', isActive: false, isToday: false),
            _DayIndicator(day: 'S', isActive: false, isToday: false),
            _DayIndicator(day: 'S', isActive: false, isToday: false),
          ],
        ),
        const SizedBox(height: 16),

        // Streak rewards
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
                'Streak Rewards',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly (7 days):',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.token, size: 16),
                      const SizedBox(width: 2),
                      Text('+5', style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      const Icon(Icons.bolt, size: 16),
                      const SizedBox(width: 2),
                      Text('+10', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly (30 days):',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.token, size: 16),
                      const SizedBox(width: 2),
                      Text('+25', style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      const Icon(Icons.bolt, size: 16),
                      const SizedBox(width: 2),
                      Text('+50', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyRewardSection(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Login Reward',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Claim your daily tokens and XP',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.token,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+1 Token',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.bolt,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+2 XP',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _dailyRewardClaimed ? null : () => _claimDailyReward(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                ),
                child: Text(_dailyRewardClaimed ? 'Claimed' : 'Claim'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakStat(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Claims the daily reward for the current user
  /// 
  /// Shows a success message upon successful claiming
  /// or an error message if claiming fails
  Future<void> _claimDailyReward(BuildContext context) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }

    final userId = authState.user!.id;
    final result = await ref.read(gamificationNotifierProvider.notifier).awardForAction(
      userId,
      'dailyLogin',
      description: 'Daily login reward',
    );

    if (result['error'] == null) {
      setState(() {
        _dailyRewardClaimed = true;
      });

      // Show success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daily reward claimed! +1 Token, +2 XP'),
          backgroundColor: Colors.green,
        ),
      );

      // TODO: Save claimed status to storage
    } else {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to claim reward: ${result['error']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

/// A widget that displays a day indicator for the week view
/// 
/// Shows a circle with the day letter, with different styling
/// based on whether the day is active or is today
class _DayIndicator extends StatelessWidget {
  final String day;
  final bool isActive;
  final bool isToday;

  const _DayIndicator({
    required this.day,
    required this.isActive,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? isToday
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.3)
            : Colors.grey.withOpacity(0.2),
        border: isToday
            ? Border.all(
                color: theme.colorScheme.primary,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Text(
          day,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive
                ? isToday
                    ? Colors.white
                    : theme.colorScheme.primary
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
