import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/profile/widgets/expandable_profile_widget.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A widget that displays the user's level progress
/// Shows a summary when collapsed and detailed information when expanded
class LevelProgressWidget extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;
  
  /// Callback when a reward is tapped
  final Function(String)? onRewardTap;
  
  /// Initial state of the widget
  final ExpandableWidgetState initialState;

  /// Creates a level progress widget
  const LevelProgressWidget({
    super.key,
    required this.user,
    this.onRewardTap,
    this.initialState = ExpandableWidgetState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xpProgress = user.xp % 1000; // Simple calculation assuming 1000 XP per level
    final progressPercentage = xpProgress / 1000;
    final nextLevel = user.level + 1;
    
    // List of rewards for the next level
    final rewards = [
      'New Avatar Frame',
      '+100 Token Bonus',
      'Exclusive Style Access',
    ];
    
    return ExpandableProfileWidget(
      title: 'Level Progress',
      subtitle: 'Level ${user.level} • ${user.rank}',
      icon: Icons.star_rounded,
      accentColor: AppColors.primaryHighlight,
      initialState: initialState,
      
      // Collapsed view - simple progress bar and next level
      collapsedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level indicator and XP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      'Level ${user.level}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user.rank,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Text(
                '$xpProgress / 1000 XP',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Progress bar
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
                widthFactor: progressPercentage,
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
                              color: index <= ((user.xp) ~/ 200 + 1) 
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
          
          const SizedBox(height: 4),
          
          // XP to next level
          Text(
            '${1000 - xpProgress} XP to Level $nextLevel',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
      
      // Expanded view - detailed progress and rewards
      expandedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress visualization (same as collapsed but larger)
          Stack(
            children: [
              // Base progress bar background with glow
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.baseDarkAccent,
                  borderRadius: BorderRadius.circular(12),
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
                widthFactor: progressPercentage,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.primaryHighlight,
                        Color(0xFFA0FF00), // Slightly different shade for gradient effect
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
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
              
              // Level indicators
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => index == 0 
                        ? const SizedBox(width: 1) // Empty space for first position
                        : Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          child: Text(
                            '$index',
                            style: TextStyle(
                              color: index <= ((user.xp) ~/ 200 + 1) 
                                ? Colors.black 
                                : Colors.white.withAlpha(150),
                              fontSize: 12,
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
          
          const SizedBox(height: 8),
          
          // XP details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current XP: ${user.xp}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                'Next Level: ${user.level + 1}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Rewards section
          Text(
            'Rewards for Level $nextLevel',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Reward cards
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: rewards.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _buildRewardCard(
                  context,
                  reward: rewards[index],
                  icon: _getRewardIcon(rewards[index]),
                  onTap: () => onRewardTap?.call(rewards[index]),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Recent XP gains
          Text(
            'Recent XP Gains',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Recent XP list
          Column(
            children: [
              _buildXpGainItem(
                context,
                amount: 50,
                source: 'Completed Booking',
                date: 'Today',
              ),
              _buildXpGainItem(
                context,
                amount: 25,
                source: 'Daily Check-in',
                date: 'Today',
              ),
              _buildXpGainItem(
                context,
                amount: 100,
                source: 'New Achievement',
                date: 'Yesterday',
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildRewardCard(
    BuildContext context, {
    required String reward,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.baseDarkAccent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryHighlight.withAlpha(50),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryHighlight,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              reward,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildXpGainItem(
    BuildContext context, {
    required int amount,
    required String source,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryHighlight.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.primaryHighlight,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '+$amount XP',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primaryHighlight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getRewardIcon(String reward) {
    if (reward.contains('Avatar')) return Icons.face;
    if (reward.contains('Token')) return Icons.token;
    if (reward.contains('Style')) return Icons.style;
    return Icons.card_giftcard;
  }
}
