import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/rewards/screens/token_shop_screen.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays featured items from the token shop
class TokenShopCard extends ConsumerWidget {
  const TokenShopCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return ExpandableDashboardCard(
      title: 'Token Shop',
      icon: Icons.shopping_bag,
      accentColor: Colors.amber,
      onViewAllTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TokenShopScreen(),
          ),
        );
      },
      collapsedChild: _buildCollapsedContent(context, user.tokens ?? 0), // Null check
      expandedChild: _buildExpandedContent(context, user.tokens ?? 0), // Null check
    );
  }

  Widget _buildCollapsedContent(BuildContext context, int userTokens) { // Already handles int
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.token,
              size: 16,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              '$userTokens tokens available',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context, int userTokens) { // Already handles int
    final theme = Theme.of(context);

    // Featured items
    final featuredItems = [
      {
        'title': 'Premium Avatar Frame',
        'description': 'Add a golden frame to your profile picture',
        'price': 100,
        'category': 'Profile',
        'icon': Icons.person,
        'color': Colors.amber,
      },
      {
        'title': 'Priority Booking',
        'description': 'Get priority when booking with popular stylists',
        'price': 300,
        'category': 'Features',
        'icon': Icons.calendar_today,
        'color': Colors.purple,
      },
      {
        'title': 'Exclusive Style Collection',
        'description': 'Access to premium hairstyle ideas',
        'price': 100,
        'category': 'Styles',
        'icon': Icons.style,
        'color': Colors.blue,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Items',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Featured items list
        ...featuredItems.map((item) => _buildShopItemPreview(
          context,
          title: item['title'] as String,
          description: item['description'] as String,
          price: item['price'] as int,
          category: item['category'] as String,
          icon: item['icon'] as IconData,
          color: item['color'] as Color,
          userTokens: userTokens,
        )).toList(),

        const SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () {
              // Navigate to token shop
            },
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Visit Token Shop'),
          ),
        ),
      ],
    );
  }

  Widget _buildShopItemPreview(
    BuildContext context, {
    required String title,
    required String description,
    required int price,
    required String category,
    required IconData icon,
    required Color color,
    required int userTokens,
  }) {
    final theme = Theme.of(context);
    final canAfford = userTokens >= price;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
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
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.token,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$price',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: canAfford ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: canAfford ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: const Size(0, 32),
                        textStyle: theme.textTheme.labelSmall,
                      ),
                      child: Text(canAfford ? 'Purchase' : 'Not Enough'),
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
}
