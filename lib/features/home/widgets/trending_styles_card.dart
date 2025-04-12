import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/style.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays trending styles
class TrendingStylesCard extends StatelessWidget {
  /// List of trending styles
  final List<Style> styles;
  
  /// Callback when a style is tapped
  final Function(Style)? onStyleTap;
  
  /// Callback when the view all button is tapped
  final VoidCallback? onViewAllTap;
  
  /// Initial state of the card
  final DashboardCardState initialState;

  /// Creates a trending styles card
  const TrendingStylesCard({
    super.key,
    required this.styles,
    this.onStyleTap,
    this.onViewAllTap,
    this.initialState = DashboardCardState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ExpandableDashboardCard(
      title: 'Trending Styles',
      subtitle: 'Popular styles this week',
      icon: Icons.trending_up,
      accentColor: Colors.pink,
      initialState: initialState,
      onViewAllTap: onViewAllTap,
      
      // Collapsed view - horizontal list of styles
      collapsedChild: styles.isEmpty
          ? _buildEmptyState(context)
          : SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: styles.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return _buildStyleItem(
                    context,
                    style: styles[index],
                    onTap: () => onStyleTap?.call(styles[index]),
                  );
                },
              ),
            ),
      
      // Expanded view - grid of styles
      expandedChild: styles.isEmpty
          ? _buildEmptyState(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Style categories
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip(context, 'All', isSelected: true),
                      _buildCategoryChip(context, 'Short'),
                      _buildCategoryChip(context, 'Medium'),
                      _buildCategoryChip(context, 'Long'),
                      _buildCategoryChip(context, 'Curly'),
                      _buildCategoryChip(context, 'Straight'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Grid of styles
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: styles.length,
                  itemBuilder: (context, index) {
                    return _buildStyleGridItem(
                      context,
                      style: styles[index],
                      onTap: () => onStyleTap?.call(styles[index]),
                    );
                  },
                ),
              ],
            ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.style,
            color: Colors.white.withOpacity(0.5),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'No trending styles available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStyleItem(
    BuildContext context, {
    required Style style,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.baseDarkAccent,
          borderRadius: BorderRadius.circular(12),
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
            // Style image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                style.imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 80,
                    color: Colors.grey.withOpacity(0.2),
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
            
            // Style info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        style.likes.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStyleGridItem(
    BuildContext context, {
    required Style style,
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
            // Style image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  style.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Style info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${style.likes} likes',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          style.category,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.pink,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryChip(
    BuildContext context,
    String label, {
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // TODO: Implement category filtering
        },
        backgroundColor: AppColors.baseDarkAccent,
        selectedColor: Colors.pink.withOpacity(0.3),
        checkmarkColor: Colors.pink,
        labelStyle: TextStyle(
          color: isSelected ? Colors.pink : Colors.white.withOpacity(0.7),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? Colors.pink : Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
