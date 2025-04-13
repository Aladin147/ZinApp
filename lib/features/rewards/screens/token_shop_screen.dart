import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A screen that displays items that can be purchased with tokens
class TokenShopScreen extends ConsumerStatefulWidget {
  const TokenShopScreen({super.key});

  @override
  ConsumerState<TokenShopScreen> createState() => _TokenShopScreenState();
}

class _TokenShopScreenState extends ConsumerState<TokenShopScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final user = authState.user;
    // final userId = userProfile?.id; // Removed unused variable

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Shop'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Features'),
            Tab(text: 'Styles'),
          ],
        ),
      ),
      body: SafeArea( // Wrap the main Column with SafeArea
        child: Column(
          children: [
            // Token balance
            Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.token,
                  color: AppColors.primaryHighlight,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your Balance: ${user.tokens} Tokens',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to token earning screen
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Earn More'),
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Profile tab
                _buildProfileItemsTab(context, user.tokens),
                
                // Features tab
                _buildFeaturesTab(context, user.tokens),
                
                // Styles tab
                _buildStylesTab(context, user.tokens),
              ],
            ),
          ),
        ],
      ),
     ), // Close SafeArea
    );
  }
  
  Widget _buildProfileItemsTab(BuildContext context, int userTokens) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildShopItem(
          context,
          title: 'Premium Avatar Frame',
          description: 'Add a golden frame to your profile picture',
          tokenPrice: 100,
          imageAsset: 'assets/images/shop/premium_frame.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Custom Username Color',
          description: 'Change the color of your username in posts and comments',
          tokenPrice: 150,
          imageAsset: 'assets/images/shop/username_color.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Profile Animations',
          description: 'Add subtle animations to your profile page',
          tokenPrice: 200,
          imageAsset: 'assets/images/shop/profile_animation.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Custom Profile Background',
          description: 'Choose from a selection of premium backgrounds',
          tokenPrice: 250,
          imageAsset: 'assets/images/shop/profile_background.png',
          userTokens: userTokens,
        ),
      ],
    );
  }
  
  Widget _buildFeaturesTab(BuildContext context, int userTokens) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildShopItem(
          context,
          title: 'Priority Booking',
          description: 'Get priority when booking with popular stylists',
          tokenPrice: 300,
          imageAsset: 'assets/images/shop/priority_booking.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Advanced Analytics',
          description: 'See detailed stats about your style preferences',
          tokenPrice: 200,
          imageAsset: 'assets/images/shop/analytics.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Style Recommendations',
          description: 'Get personalized style recommendations',
          tokenPrice: 150,
          imageAsset: 'assets/images/shop/recommendations.png',
          userTokens: userTokens,
        ),
      ],
    );
  }
  
  Widget _buildStylesTab(BuildContext context, int userTokens) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildShopItem(
          context,
          title: 'Exclusive Style Collection',
          description: 'Access to premium hairstyle ideas',
          tokenPrice: 100,
          imageAsset: 'assets/images/shop/exclusive_styles.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Seasonal Trends',
          description: 'Early access to upcoming seasonal style trends',
          tokenPrice: 150,
          imageAsset: 'assets/images/shop/seasonal_trends.png',
          userTokens: userTokens,
        ),
        const SizedBox(height: 16),
        
        _buildShopItem(
          context,
          title: 'Celebrity Styles',
          description: 'Collection of celebrity hairstyles with tutorials',
          tokenPrice: 200,
          imageAsset: 'assets/images/shop/celebrity_styles.png',
          userTokens: userTokens,
        ),
      ],
    );
  }
  
  Widget _buildShopItem(
    BuildContext context, {
    required String title,
    required String description,
    required int tokenPrice,
    required String imageAsset,
    required int userTokens,
  }) {
    final theme = Theme.of(context);
    final canAfford = userTokens >= tokenPrice;
    
    return Container(
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
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 48,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                // In a real app, we would use:
                // Image.asset(
                //   imageAsset,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                // ),
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.token,
                          color: AppColors.primaryHighlight,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$tokenPrice Tokens',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: canAfford
                                ? AppColors.primaryHighlight
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: canAfford
                          ? () => _purchaseItem(context, title, tokenPrice)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryHighlight,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(canAfford ? 'Purchase' : 'Not Enough Tokens'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _purchaseItem(BuildContext context, String itemName, int tokenPrice) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text('Are you sure you want to purchase $itemName for $tokenPrice tokens?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryHighlight,
              foregroundColor: Colors.black,
            ),
            child: const Text('Purchase'),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    // Process purchase
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }
    
    final userId = authState.user!.id;
    final result = await ref.read(userProfileProviderProvider.notifier).updateTokens(
      -tokenPrice,
      TokenTransactionType.spent,
      'Purchased $itemName',
    );
    
    if (result) {
      // Show success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully purchased $itemName!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // TODO: Actually apply the purchased item
    } else {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to complete purchase. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
