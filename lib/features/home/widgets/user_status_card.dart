import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays the user's status information
/// Shows level, tokens, and quick stats
class UserStatusCard extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;
  
  /// Callback when the user taps on the level section
  final VoidCallback? onLevelTap;
  
  /// Callback when the user taps on the tokens section
  final VoidCallback? onTokensTap;
  
  /// Callback when the user taps on the view all button
  final VoidCallback? onViewAllTap;

  /// Creates a user status card
  const UserStatusCard({
    super.key,
    required this.user,
    this.onLevelTap,
    this.onTokensTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Calculate XP progress
    final xpProgress = user.xp % 1000; // Simple calculation assuming 1000 XP per level
    final progressPercentage = xpProgress / 1000;
    
    return ExpandableDashboardCard(
      title: 'Your Status',
      subtitle: 'Level ${user.level} • ${user.rank}',
      icon: Icons.person,
      accentColor: AppColors.primaryHighlight,
      backgroundColor: AppColors.baseDarkAlt,
      expandable: false, // This card doesn't need to expand
      showViewAll: false,
      
      // Collapsed view - level, tokens, and quick stats
      collapsedChild: Column(
        children: [
          // Level and tokens row
          Row(
            children: [
              // Level section
              Expanded(
                child: InkWell(
                  onTap: onLevelTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryHighlight.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.star,
                              color: AppColors.primaryHighlight,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Level ${user.level}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // XP progress bar
                      Stack(
                        children: [
                          // Base progress bar
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.baseDarkAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          
                          // Progress fill
                          FractionallySizedBox(
                            widthFactor: progressPercentage,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.primaryHighlight,
                                    Color(0xFFA0FF00), // Slightly different shade for gradient effect
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryHighlight.withOpacity(0.4),
                                    blurRadius: 4,
                                    spreadRadius: -1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$xpProgress / 1000 XP',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Tokens section
              Expanded(
                child: InkWell(
                  onTap: onTokensTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.token,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tokens',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.tokens.toString(),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Available Balance',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                context,
                icon: Icons.calendar_today,
                value: user.bookingsCount.toString(),
                label: 'Bookings',
              ),
              _buildStatItem(
                context,
                icon: Icons.photo,
                value: user.postsCount.toString(),
                label: 'Posts',
              ),
              _buildStatItem(
                context,
                icon: Icons.emoji_events,
                value: user.achievements.length.toString(),
                label: 'Achievements',
              ),
              _buildStatItem(
                context,
                icon: Icons.people,
                value: user.followersCount.toString(),
                label: 'Followers',
              ),
            ],
          ),
        ],
      ),
      
      // This card doesn't expand, but we need to provide an expanded child
      expandedChild: const SizedBox(),
    );
  }
  
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.7),
          size: 16,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
