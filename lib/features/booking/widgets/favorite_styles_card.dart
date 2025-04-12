import 'package:flutter/material.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays the user's favorite styles based on booking history
class FavoriteStylesCard extends StatelessWidget {
  /// List of favorite styles
  final List<String> favoriteStyles;
  
  /// Callback when a style is tapped
  final Function(String)? onStyleTap;

  /// Creates a favorite styles card
  const FavoriteStylesCard({
    super.key,
    required this.favoriteStyles,
    this.onStyleTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableDashboardCard(
      title: 'Your Favorite Styles',
      icon: Icons.style,
      accentColor: Colors.blue,
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final theme = Theme.of(context);
    
    if (favoriteStyles.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteStyles.length > 3 ? 3 : favoriteStyles.length,
        itemBuilder: (context, index) {
          final style = favoriteStyles[index];
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              style,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final theme = Theme.of(context);
    
    if (favoriteStyles.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Styles You Love',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Based on your booking history',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        
        // Style grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: favoriteStyles.length,
          itemBuilder: (context, index) {
            final style = favoriteStyles[index];
            return _buildStyleItem(context, style);
          },
        ),
      ],
    );
  }

  Widget _buildStyleItem(BuildContext context, String style) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () => onStyleTap?.call(style),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.style,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              style,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.style,
              color: Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No favorite styles yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
