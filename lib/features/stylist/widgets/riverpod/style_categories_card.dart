import 'package:flutter/material.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays style categories
class StyleCategoriesCard extends StatelessWidget {
  const StyleCategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableDashboardCard(
      title: 'Style Categories',
      icon: Icons.style,
      accentColor: Colors.blue,
      onViewAllTap: () {
        // Navigate to style categories screen
      },
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    // Mock categories data
    final categories = [
      {'name': 'Haircuts', 'icon': Icons.content_cut},
      {'name': 'Color', 'icon': Icons.color_lens},
      {'name': 'Styling', 'icon': Icons.brush},
    ];
    
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryItem(
            context,
            name: category['name'] as String,
            icon: category['icon'] as IconData,
            compact: true,
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    // Mock categories data
    final categories = [
      {'name': 'Haircuts', 'icon': Icons.content_cut, 'count': 45},
      {'name': 'Color', 'icon': Icons.color_lens, 'count': 32},
      {'name': 'Styling', 'icon': Icons.brush, 'count': 28},
      {'name': 'Treatments', 'icon': Icons.spa, 'count': 19},
      {'name': 'Extensions', 'icon': Icons.straighten, 'count': 12},
      {'name': 'Braids', 'icon': Icons.waves, 'count': 24},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Find stylists specialized in specific services',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryItem(
              context,
              name: category['name'] as String,
              icon: category['icon'] as IconData,
              count: category['count'] as int,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required String name,
    required IconData icon,
    int? count,
    bool compact = false,
  }) {
    final theme = Theme.of(context);
    
    if (compact) {
      return Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    
    return InkWell(
      onTap: () {
        // Navigate to category
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (count != null) ...[
              const SizedBox(height: 4),
              Text(
                '$count stylists',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
