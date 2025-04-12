import 'package:flutter/material.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays popular styles in the user's area
class NearbyStylesCard extends StatelessWidget {
  const NearbyStylesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableDashboardCard(
      title: 'Trending Near You',
      icon: Icons.trending_up,
      accentColor: Colors.green,
      onViewAllTap: () {
        // Navigate to trending styles screen
      },
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    // Mock trending styles data
    final trendingStyles = [
      {
        'name': 'Modern Bob',
        'imageUrl': 'https://example.com/bob.jpg',
        'popularity': 95,
      },
      {
        'name': 'Beach Waves',
        'imageUrl': 'https://example.com/waves.jpg',
        'popularity': 87,
      },
      {
        'name': 'Pixie Cut',
        'imageUrl': 'https://example.com/pixie.jpg',
        'popularity': 82,
      },
    ];
    
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendingStyles.length,
        itemBuilder: (context, index) {
          final style = trendingStyles[index];
          return _buildStyleItem(
            context,
            name: style['name'] as String,
            imageUrl: style['imageUrl'] as String,
            popularity: style['popularity'] as int,
            compact: true,
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    // Mock trending styles data
    final trendingStyles = [
      {
        'name': 'Modern Bob',
        'imageUrl': 'https://example.com/bob.jpg',
        'popularity': 95,
        'description': 'A sleek, chin-length cut with clean lines',
      },
      {
        'name': 'Beach Waves',
        'imageUrl': 'https://example.com/waves.jpg',
        'popularity': 87,
        'description': 'Effortless, textured waves for a casual look',
      },
      {
        'name': 'Pixie Cut',
        'imageUrl': 'https://example.com/pixie.jpg',
        'popularity': 82,
        'description': 'Short, layered cut with a bold edge',
      },
      {
        'name': 'Balayage',
        'imageUrl': 'https://example.com/balayage.jpg',
        'popularity': 78,
        'description': 'Hand-painted highlights for a natural sun-kissed look',
      },
      {
        'name': 'Curtain Bangs',
        'imageUrl': 'https://example.com/curtain.jpg',
        'popularity': 75,
        'description': 'Face-framing bangs that part in the middle',
      },
      {
        'name': 'Shag Cut',
        'imageUrl': 'https://example.com/shag.jpg',
        'popularity': 72,
        'description': 'Layered, textured cut with lots of movement',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Styles in Your Area',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'See what\'s trending and find stylists who specialize in these looks',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: trendingStyles.length,
          itemBuilder: (context, index) {
            final style = trendingStyles[index];
            return _buildStyleItem(
              context,
              name: style['name'] as String,
              imageUrl: style['imageUrl'] as String,
              popularity: style['popularity'] as int,
              description: style['description'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildStyleItem(
    BuildContext context, {
    required String name,
    required String imageUrl,
    required int popularity,
    String? description,
    bool compact = false,
  }) {
    final theme = Theme.of(context);
    
    if (compact) {
      return Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
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
          children: [
            // Image placeholder
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    
    return InkWell(
      onTap: () {
        // Navigate to style details
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
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
            // Image placeholder
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Colors.green,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '$popularity%',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
