import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/shapes/wave_clipper.dart';
import 'package:zinapp_v2/widgets/containers/organic_container.dart';

class GamerDashboardSection extends StatelessWidget {
  final UserProfile? user;
  final VoidCallback? onProfileTap;

  const GamerDashboardSection({
    super.key,
    required this.user,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipPath(
      clipper: WaveBottomClipper(
        amplitude: 15.0,
        frequency: 1.2,
      ),
      child: OrganicContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: AppColors.baseDark,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.baseDark,
            AppColors.baseDarkDeeper,
          ],
        ),
        elevation: 4,
        borderRadius: 0, // No border radius at top since it's at screen edge
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primaryHighlight.withAlpha(15),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        shape: OrganicShape.rounded, // We're using ClipPath instead of the built-in shapes
        child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: User info and tokens
          Row(
            children: [
              // User avatar with level ring
              GestureDetector(
                onTap: () {
                  context.go(AppRoutes.profile);
                },
                child: Stack(
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

          // XP progress bar with enhanced visualization
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.primaryHighlight,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Level ${(user?.xp ?? 0) ~/ 200 + 1}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryHighlight.withAlpha(70),
                          AppColors.primaryHighlight.withAlpha(40),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryHighlight.withAlpha(30),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      '${user?.xp ?? 0} / 1000 XP',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  // Base progress bar background with glow
                  Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.baseDarkAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryHighlight.withAlpha(15),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                  // Progress fill
                  FractionallySizedBox(
                    widthFactor: (user?.xp ?? 0) / 1000,
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.primaryHighlight,
                            Color(0xFFA0FF00), // Slightly different shade for gradient effect
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryHighlight.withAlpha(100),
                            blurRadius: 12,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Milestone markers
                  SizedBox(
                    height: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 2,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withAlpha(80),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Level indicators
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                          (index) => index == 0
                            ? const SizedBox(width: 1) // Empty space for first position
                            : Container(
                              width: 16,
                              height: 16,
                              alignment: Alignment.center,
                              child: Text(
                                '$index',
                                style: TextStyle(
                                  color: index <= ((user?.xp ?? 0) ~/ 200 + 1)
                                    ? Colors.black
                                    : Colors.white.withAlpha(150),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
