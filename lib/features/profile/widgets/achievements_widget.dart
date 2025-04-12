import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/profile/widgets/expandable_profile_widget.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A widget that displays the user's achievements
/// Shows a summary when collapsed and a gallery when expanded
class AchievementsWidget extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;
  
  /// Callback when an achievement is tapped
  final Function(String)? onAchievementTap;
  
  /// Initial state of the widget
  final ExpandableWidgetState initialState;

  /// Creates an achievements widget
  const AchievementsWidget({
    super.key,
    required this.user,
    this.onAchievementTap,
    this.initialState = ExpandableWidgetState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Get unlocked achievements
    final unlockedAchievements = user.achievements;
    
    // Calculate progress percentage
    final totalAchievements = 20; // Assuming 20 total achievements
    final progressPercentage = unlockedAchievements.length / totalAchievements;
    
    return ExpandableProfileWidget(
      title: 'Achievements',
      subtitle: '${unlockedAchievements.length}/$totalAchievements Unlocked',
      icon: Icons.emoji_events,
      accentColor: Colors.purple,
      initialState: initialState,
      
      // Collapsed view - achievement progress and recent unlocks
      collapsedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(progressPercentage * 100).toInt()}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  // Base progress bar
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.baseDarkAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  
                  // Progress fill
                  FractionallySizedBox(
                    widthFactor: progressPercentage,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.purple,
                            Colors.deepPurple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withAlpha(100),
                            blurRadius: 8,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Recent achievements
          Text(
            'Recent Unlocks',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Achievement icons
          unlockedAchievements.isEmpty
              ? Text(
                  'No achievements unlocked yet',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                )
              : Row(
                  children: unlockedAchievements
                      .take(4)
                      .map((achievement) => _buildAchievementIcon(
                        context,
                        achievement: achievement,
                        onTap: () => onAchievementTap?.call(achievement),
                      ))
                      .toList(),
                ),
        ],
      ),
      
      // Expanded view - achievement gallery
      expandedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress visualization
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withAlpha(70),
                  Colors.deepPurple.withAlpha(40),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withAlpha(30),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Achievement Progress',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple.withAlpha(100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${unlockedAchievements.length}/$totalAchievements',
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
                    // Base progress bar
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
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
                              Colors.purple,
                              Colors.deepPurple,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Milestone markers
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            5,
                            (index) {
                              final milestone = (index + 1) * 4; // 4, 8, 12, 16, 20
                              final isReached = unlockedAchievements.length >= milestone;
                              
                              return Container(
                                width: 3,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: isReached
                                      ? Colors.white
                                      : Colors.white.withAlpha(70),
                                  boxShadow: isReached
                                      ? [
                                          BoxShadow(
                                            color: Colors.white.withAlpha(100),
                                            blurRadius: 4,
                                            spreadRadius: 0,
                                          ),
                                        ]
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Beginner',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Master',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Achievement categories
          Text(
            'Categories',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Category tabs
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryTab(context, 'All', isSelected: true),
                _buildCategoryTab(context, 'Bookings'),
                _buildCategoryTab(context, 'Social'),
                _buildCategoryTab(context, 'Style'),
                _buildCategoryTab(context, 'Special'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Achievement gallery
          Text(
            'Unlocked Achievements',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Achievement grid
          unlockedAchievements.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No achievements unlocked yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: unlockedAchievements.length,
                  itemBuilder: (context, index) {
                    return _buildAchievementCard(
                      context,
                      achievement: unlockedAchievements[index],
                      onTap: () => onAchievementTap?.call(unlockedAchievements[index]),
                    );
                  },
                ),
          
          const SizedBox(height: 16),
          
          // Locked achievements
          Text(
            'Locked Achievements',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Locked achievement grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: 3, // Show a few locked achievements
            itemBuilder: (context, index) {
              return _buildLockedAchievementCard(context);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAchievementIcon(
    BuildContext context, {
    required String achievement,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.purple.withAlpha(100),
                Colors.purple.withAlpha(50),
              ],
              stops: const [0.4, 1.0],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withAlpha(50),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ],
            border: Border.all(
              color: Colors.purple.withAlpha(100),
              width: 1.5,
            ),
          ),
          child: Icon(
            _getAchievementIcon(achievement),
            color: Colors.purple,
            size: 20,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryTab(
    BuildContext context,
    String label, {
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          // TODO: Implement category filtering
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.purple.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.purple.withAlpha(isSelected ? 0 : 100),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildAchievementCard(
    BuildContext context, {
    required String achievement,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.baseDarkAccent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.purple.withAlpha(50),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.purple.withAlpha(100),
                    Colors.purple.withAlpha(50),
                  ],
                  stops: const [0.4, 1.0],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withAlpha(50),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Icon(
                _getAchievementIcon(achievement),
                color: Colors.purple,
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _getAchievementName(achievement),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _getAchievementRarity(achievement),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getRarityColor(achievement),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLockedAchievementCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseDarkAccent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock,
              color: Colors.grey.withAlpha(100),
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Locked',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Keep playing to unlock',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.withAlpha(150),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  IconData _getAchievementIcon(String achievement) {
    // In a real app, this would be based on the achievement type
    if (achievement.contains('booking')) return Icons.calendar_today;
    if (achievement.contains('review')) return Icons.rate_review;
    if (achievement.contains('follower')) return Icons.people;
    if (achievement.contains('post')) return Icons.photo;
    if (achievement.contains('style')) return Icons.style;
    return Icons.emoji_events;
  }
  
  String _getAchievementName(String achievement) {
    // In a real app, this would be a proper name from the achievement data
    if (achievement.contains('booking')) return 'Booking Master';
    if (achievement.contains('review')) return 'Top Reviewer';
    if (achievement.contains('follower')) return 'Social Butterfly';
    if (achievement.contains('post')) return 'Content Creator';
    if (achievement.contains('style')) return 'Style Icon';
    return 'Achievement ${achievement.hashCode % 100}';
  }
  
  String _getAchievementRarity(String achievement) {
    // In a real app, this would be based on the achievement rarity
    final hash = achievement.hashCode;
    if (hash % 10 == 0) return 'Legendary';
    if (hash % 5 == 0) return 'Epic';
    if (hash % 3 == 0) return 'Rare';
    return 'Common';
  }
  
  Color _getRarityColor(String achievement) {
    final rarity = _getAchievementRarity(achievement);
    switch (rarity) {
      case 'Legendary':
        return Colors.orange;
      case 'Epic':
        return Colors.purple;
      case 'Rare':
        return Colors.blue;
      default:
        return Colors.green;
    }
  }
}
