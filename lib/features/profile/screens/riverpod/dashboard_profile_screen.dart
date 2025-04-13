import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/features/profile/widgets/achievements_widget.dart';
// import 'package:zinapp_v2/features/profile/widgets/expandable_profile_widget.dart'; // Unused import removed
import 'package:zinapp_v2/features/profile/widgets/level_progress_widget.dart';
// import 'package:zinapp_v2/features/profile/widgets/profile_dashboard.dart'; // Unused import removed
import 'package:zinapp_v2/features/profile/widgets/profile_header_widget.dart';
import 'package:zinapp_v2/features/profile/widgets/stats_widget.dart';
import 'package:zinapp_v2/features/profile/widgets/token_balance_widget.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/backgrounds/organic_background.dart';

/// A dashboard-style profile screen that displays all user information
/// in a unified, scrollable view with expandable widgets
class DashboardProfileScreen extends ConsumerStatefulWidget {
  const DashboardProfileScreen({super.key});

  @override
  ConsumerState<DashboardProfileScreen> createState() => _DashboardProfileScreenState();
}

class _DashboardProfileScreenState extends ConsumerState<DashboardProfileScreen> {
  @override
  void initState() {
    super.initState();
    
    // Load user profile and token history when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProfileProviderProvider.notifier).loadUserProfile();
      ref.read(userProfileProviderProvider.notifier).loadTokenHistory();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(userProfileProviderProvider);
    final user = authState.user;
    
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }
    // Add a null check for the user before building the main content
    if (user == null) {
       // Or return a login screen redirect, or a specific loading/error state
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userProfileProviderProvider.notifier).loadUserProfile();
          await ref.read(userProfileProviderProvider.notifier).loadTokenHistory();
        },
        child: OrganicBackground(
          backgroundColor: AppColors.baseDarkDeeper,
          shapeColor: AppColors.baseDarkAccent,
          numberOfShapes: 3,
          shapeOpacity: 0.05,
          animate: true,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App bar
              SliverToBoxAdapter(
                child: SafeArea(
                  child: ProfileHeaderWidget(
                    user: user, // Now guaranteed non-null
                    showEditButton: true,
                    showSettingsButton: true,
                  ),
                ),
              ),
              
              // Dashboard widgets
              SliverPadding(
                padding: const EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: _buildDashboardWidgets(user, profileState.tokenHistory ?? []), // Now guaranteed non-null
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDashboardWidgets(UserProfile user, List<TokenTransaction> transactions) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Level progress widget
          LevelProgressWidget(
            user: user,
            onRewardTap: (reward) {
              _showRewardDetails(context, reward);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Token balance widget
          TokenBalanceWidget(
            user: user,
            transactions: transactions,
            onEarnMoreTap: () {
              _showEarnTokensDialog(context);
            },
            onSpendTap: () {
              _showSpendTokensDialog(context);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Stats widget
          StatsWidget(
            user: user,
          ),
          
          const SizedBox(height: 16),
          
          // Achievements widget
          AchievementsWidget(
            user: user,
            onAchievementTap: (achievement) {
              _showAchievementDetails(context, achievement);
            },
          ),
          
          // Add more widgets as needed
        ],
      ),
    );
  }
  
  void _showRewardDetails(BuildContext context, String reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reward: $reward'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You\'ll receive this reward when you reach the next level.'),
            const SizedBox(height: 8),
            if (reward.contains('Avatar'))
              const Text('This will unlock a new frame for your profile picture.'),
            if (reward.contains('Token'))
              const Text('Tokens can be used to purchase premium styles and features.'),
            if (reward.contains('Style'))
              const Text('You\'ll get access to exclusive styles not available to other users.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showAchievementDetails(BuildContext context, String achievement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Achievement: ${_getAchievementName(achievement)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rarity: ${_getAchievementRarity(achievement)}'),
            const SizedBox(height: 8),
            const Text('Description:'),
            const SizedBox(height: 4),
            Text(_getAchievementDescription(achievement)),
            const SizedBox(height: 8),
            const Text('Rewards:'),
            const SizedBox(height: 4),
            Text('• ${_getAchievementReward(achievement)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showEarnTokensDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Earn Tokens'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEarnTokenOption(
              context,
              title: 'Book an Appointment',
              description: 'Earn 50 tokens for each booking',
              icon: Icons.calendar_today,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildEarnTokenOption(
              context,
              title: 'Leave a Review',
              description: 'Earn 25 tokens for each review',
              icon: Icons.rate_review,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildEarnTokenOption(
              context,
              title: 'Share a Post',
              description: 'Earn 10 tokens for each post',
              icon: Icons.share,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildEarnTokenOption(
              context,
              title: 'Daily Check-in',
              description: 'Earn 5 tokens each day you open the app',
              icon: Icons.check_circle,
              color: Colors.purple,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showSpendTokensDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Spend Tokens'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpendTokenOption(
              context,
              title: 'Premium Styles',
              description: 'Unlock exclusive styles',
              cost: 100,
              icon: Icons.style,
              color: Colors.pink,
            ),
            const SizedBox(height: 12),
            _buildSpendTokenOption(
              context,
              title: 'Tip a Stylist',
              description: 'Show appreciation for great service',
              cost: 50,
              icon: Icons.volunteer_activism,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            _buildSpendTokenOption(
              context,
              title: 'Priority Booking',
              description: 'Get priority for appointments',
              cost: 200,
              icon: Icons.stars,
              color: Colors.amber,
            ),
            const SizedBox(height: 12),
            _buildSpendTokenOption(
              context,
              title: 'Profile Customization',
              description: 'Unlock special profile features',
              cost: 150,
              icon: Icons.face,
              color: Colors.teal,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEarnTokenOption(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSpendTokenOption(
    BuildContext context, {
    required String title,
    required String description,
    required int cost,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.token,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                cost.toString(),
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
  
  String _getAchievementDescription(String achievement) {
    // In a real app, this would be a proper description from the achievement data
    if (achievement.contains('booking')) {
      return 'Complete 10 bookings with stylists.';
    }
    if (achievement.contains('review')) {
      return 'Leave 5 reviews for stylists you\'ve booked.';
    }
    if (achievement.contains('follower')) {
      return 'Reach 100 followers on your profile.';
    }
    if (achievement.contains('post')) {
      return 'Share 20 posts with the community.';
    }
    if (achievement.contains('style')) {
      return 'Save 15 styles to your favorites.';
    }
    return 'Complete special actions to earn this achievement.';
  }
  
  String _getAchievementReward(String achievement) {
    // In a real app, this would be based on the achievement type and rarity
    final rarity = _getAchievementRarity(achievement);
    switch (rarity) {
      case 'Legendary':
        return '500 Tokens + Exclusive Avatar Frame';
      case 'Epic':
        return '250 Tokens + Special Badge';
      case 'Rare':
        return '100 Tokens';
      default:
        return '50 Tokens';
    }
  }
}
