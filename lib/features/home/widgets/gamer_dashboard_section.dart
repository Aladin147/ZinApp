import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class GamerDashboardSection extends StatelessWidget {
  final UserProfile? user;

  const GamerDashboardSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.baseDark,
            AppColors.baseDark.withAlpha(230), // 0.9 opacity
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26), // 0.1 opacity
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: User info and tokens
          Row(
            children: [
              // User avatar with level ring
              Stack(
                alignment: Alignment.center,
                children: [
                  // Level ring
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          AppColors.primaryHighlight,
                          AppColors.primaryHighlight.withAlpha(77), // 0.3 opacity
                        ],
                        stops: const [0.7, 0.7], // 70% progress
                      ),
                    ),
                  ),
                  // User avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: user?.profilePictureUrl != null
                        ? AssetImage(user!.profilePictureUrl!)
                        : null,
                    child: user?.profilePictureUrl == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // User info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? 'User',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          user?.rank ?? 'Novice',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryHighlight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Level ${user?.level ?? 1}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withAlpha(179), // 0.7 opacity
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // Token display with glow effect
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryHighlight.withAlpha(77), // 0.3 opacity
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.token,
                      color: AppColors.primaryHighlight,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${user?.tokens ?? 0}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryHighlight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // XP progress bar with animation
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'XP Progress',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${user?.xp ?? 0} / 1000 XP',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  // Base progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (user?.xp ?? 0) / 1000, // Calculate progress based on XP (max 1000)
                      backgroundColor: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryHighlight,
                      ),
                      minHeight: 12,
                    ),
                  ),
                  // Milestone markers
                  SizedBox(
                    height: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 2,
                          height: 12,
                          color: Colors.white.withAlpha(128), // 0.5 opacity
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Achievement showcase
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Achievements',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Show 5 achievements or placeholders
                  itemBuilder: (context, index) {
                    // Show actual achievements if available, otherwise placeholders
                    final achievements = user?.achievements;
                    final hasAchievement = achievements != null && index < achievements.length;

                    return Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: hasAchievement
                            ? AppColors.primaryHighlight.withAlpha(51) // 0.2 opacity
                            : Colors.grey.withAlpha(51), // 0.2 opacity
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: hasAchievement
                              ? AppColors.primaryHighlight
                              : Colors.grey.withAlpha(128), // 0.5 opacity
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          hasAchievement ? Icons.emoji_events : Icons.lock,
                          color: hasAchievement
                              ? AppColors.primaryHighlight
                              : Colors.grey.withAlpha(128), // 0.5 opacity
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
