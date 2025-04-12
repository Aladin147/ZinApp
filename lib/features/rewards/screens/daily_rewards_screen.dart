import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/services/providers/gamification_provider.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A screen that displays daily rewards and challenges
class DailyRewardsScreen extends ConsumerStatefulWidget {
  const DailyRewardsScreen({super.key});

  @override
  ConsumerState<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends ConsumerState<DailyRewardsScreen> {
  bool _dailyRewardClaimed = false;
  final _today = DateTime.now();
  final _formatter = DateFormat('EEEE, MMMM d');

  @override
  void initState() {
    super.initState();
    // Initialize gamification provider
    Future.microtask(() {
      ref.read(gamificationProvider.notifier).initialize();
    });

    // TODO: Check if daily reward already claimed from storage
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
        title: const Text('Daily Rewards'),
      ),
      body: gamificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date header
                  Text(
                    _formatter.format(_today),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Complete daily tasks to earn tokens and XP',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Daily login reward
                  _buildDailyRewardCard(context),
                  const SizedBox(height: 24),

                  // Daily challenges
                  Text(
                    'Daily Challenges',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Challenge cards
                  _buildChallengeCard(
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

                  _buildChallengeCard(
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

                  _buildChallengeCard(
                    context,
                    title: 'Community Contributor',
                    description: 'Leave a comment on a post',
                    xpReward: 20,
                    tokenReward: 10,
                    progress: 0,
                    maxProgress: 1,
                    icon: Icons.comment,
                  ),
                  const SizedBox(height: 24),

                  // Weekly streak
                  _buildStreakCard(context, user.username),
                ],
              ),
            ),
    );
  }

  Widget _buildDailyRewardCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryHighlight,
            AppColors.primaryHighlight.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryHighlight.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Login Reward',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Claim your daily tokens and XP',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.token,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+1 Token',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.bolt,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+2 XP',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _dailyRewardClaimed
                    ? null
                    : () => _claimDailyReward(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryHighlight,
                  disabledBackgroundColor: Colors.white.withOpacity(0.5),
                  disabledForegroundColor: AppColors.primaryHighlight.withOpacity(0.5),
                ),
                child: Text(_dailyRewardClaimed ? 'Claimed' : 'Claim'),
              ),
            ],
          ),
        ],
      ),
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
  }) {
    final theme = Theme.of(context);
    final isCompleted = progress >= maxProgress;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.2)
                      : AppColors.primaryHighlight.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted ? Icons.check : icon,
                  color: isCompleted ? Colors.green : AppColors.primaryHighlight,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
          const SizedBox(height: 12),
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
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress / maxProgress,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? Colors.green : AppColors.primaryHighlight,
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
          if (isCompleted) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _claimChallengeReward(context, title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Claim Reward'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, String username) {
    final theme = Theme.of(context);

    // Mock streak data
    const currentStreak = 3;
    const longestStreak = 7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Streak',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep logging in daily to earn bonus rewards!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStreakStat(
                context,
                label: 'Current Streak',
                value: '$currentStreak days',
                icon: Icons.local_fire_department,
                color: Colors.orange,
              ),
              _buildStreakStat(
                context,
                label: 'Longest Streak',
                value: '$longestStreak days',
                icon: Icons.emoji_events,
                color: Colors.amber,
              ),
            ],
          ),
          const SizedBox(height: 16),
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
          Text(
            'Weekly Reward: +5 Tokens, +10 XP',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Monthly Reward: +25 Tokens, +50 XP',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
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

  Future<void> _claimDailyReward(BuildContext context) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }

    final userId = authState.user!.id;
    final result = await ref.read(gamificationProvider.notifier).awardForAction(
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
        SnackBar(
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

  Future<void> _claimChallengeReward(BuildContext context, String challengeName) async {
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
        content: Text('$challengeName reward claimed!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

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
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? isToday
                ? AppColors.primaryHighlight
                : AppColors.primaryHighlight.withOpacity(0.3)
            : Colors.grey.withOpacity(0.2),
        border: isToday
            ? Border.all(
                color: AppColors.primaryHighlight,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Text(
          day,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive
                ? isToday
                    ? Colors.black
                    : AppColors.primaryHighlight
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
