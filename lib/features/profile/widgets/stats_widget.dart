import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/profile/widgets/expandable_profile_widget.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A widget that displays the user's stats
/// Shows a summary when collapsed and detailed stats when expanded
class StatsWidget extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;
  
  /// Initial state of the widget
  final ExpandableWidgetState initialState;

  /// Creates a stats widget
  const StatsWidget({
    super.key,
    required this.user,
    this.initialState = ExpandableWidgetState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ExpandableProfileWidget(
      title: 'Stats',
      subtitle: 'Your activity summary',
      icon: Icons.bar_chart,
      accentColor: Colors.blue,
      initialState: initialState,
      
      // Collapsed view - key stats in a row
      collapsedChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(
            context,
            icon: Icons.photo,
            value: user.postsCount.toString(),
            label: 'Posts',
            color: Colors.teal,
          ),
          _buildStatItem(
            context,
            icon: Icons.calendar_today,
            value: user.bookingsCount.toString(),
            label: 'Bookings',
            color: Colors.green,
          ),
          _buildStatItem(
            context,
            icon: Icons.people,
            value: user.followersCount.toString(),
            label: 'Followers',
            color: Colors.blue,
          ),
          _buildStatItem(
            context,
            icon: Icons.person_add,
            value: user.followingCount.toString(),
            label: 'Following',
            color: Colors.indigo,
          ),
        ],
      ),
      
      // Expanded view - detailed stats with visualizations
      expandedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildDetailedStatCard(
                context,
                icon: Icons.photo,
                title: 'Posts',
                value: user.postsCount.toString(),
                subtitle: 'Total posts shared',
                color: Colors.teal,
              ),
              _buildDetailedStatCard(
                context,
                icon: Icons.calendar_today,
                title: 'Bookings',
                value: user.bookingsCount.toString(),
                subtitle: 'Appointments made',
                color: Colors.green,
              ),
              _buildDetailedStatCard(
                context,
                icon: Icons.people,
                title: 'Followers',
                value: user.followersCount.toString(),
                subtitle: 'People following you',
                color: Colors.blue,
              ),
              _buildDetailedStatCard(
                context,
                icon: Icons.person_add,
                title: 'Following',
                value: user.followingCount.toString(),
                subtitle: 'People you follow',
                color: Colors.indigo,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Activity chart
          Text(
            'Activity Over Time',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Simple activity chart
          Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.baseDarkAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildActivityChart(context),
          ),
          
          const SizedBox(height: 16),
          
          // Engagement stats
          Text(
            'Engagement',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Engagement metrics
          Row(
            children: [
              Expanded(
                child: _buildEngagementMetric(
                  context,
                  title: 'Likes',
                  value: '${(user.postsCount * 5.7).toInt()}',
                  icon: Icons.favorite,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEngagementMetric(
                  context,
                  title: 'Comments',
                  value: '${(user.postsCount * 2.3).toInt()}',
                  icon: Icons.comment,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEngagementMetric(
                  context,
                  title: 'Shares',
                  value: '${(user.postsCount * 1.2).toInt()}',
                  icon: Icons.share,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Favorite styles
          if (user.favoriteStyles != null && user.favoriteStyles!.isNotEmpty) ...[
            Text(
              'Favorite Styles',
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Style tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.favoriteStyles!.map((style) => _buildStyleTag(context, style)).toList(),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                color.withAlpha(80),
                color.withAlpha(30),
              ],
              stops: const [0.4, 1.0],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(50),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ],
            border: Border.all(
              color: color.withAlpha(100),
              width: 1.5,
            ),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDetailedStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withAlpha(70),
            color.withAlpha(30),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(30),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityChart(BuildContext context) {
    // This is a simplified chart visualization
    // In a real app, you would use a proper chart library
    
    // Generate some random data points
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    final dataPoints = <double>[
      20 + random % 30,
      30 + random % 40,
      25 + random % 35,
      40 + random % 30,
      35 + random % 25,
      45 + random % 20,
      50 + random % 30,
    ];
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        dataPoints.length,
        (index) {
          final height = dataPoints[index];
          final day = _getDayAbbreviation(index);
          final isToday = index == dataPoints.length - 1;
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 20,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      isToday ? Colors.blue : Colors.blue.withAlpha(150),
                      isToday ? Colors.blue.shade300 : Colors.blue.shade300.withAlpha(150),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: isToday
                      ? [
                          BoxShadow(
                            color: Colors.blue.withAlpha(100),
                            blurRadius: 8,
                            spreadRadius: -2,
                          ),
                        ]
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                day,
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildEngagementMetric(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.baseDarkAccent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStyleTag(BuildContext context, String style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withAlpha(100),
          width: 1,
        ),
      ),
      child: Text(
        style,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
  
  String _getDayAbbreviation(int daysAgo) {
    final today = DateTime.now();
    final date = today.subtract(Duration(days: 6 - daysAgo));
    
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[date.weekday - 1];
  }
}
