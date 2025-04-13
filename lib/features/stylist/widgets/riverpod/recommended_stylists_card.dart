import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/stylist_card.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays recommended stylists
class RecommendedStylistsCard extends StatelessWidget {
  final List<Stylist> stylists;
  final bool isLoading;
  final String? errorMessage;
  final Function(Stylist)? onStylistTap;
  final VoidCallback? onViewAllTap;

  const RecommendedStylistsCard({
    super.key,
    required this.stylists,
    this.isLoading = false,
    this.errorMessage,
    this.onStylistTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableDashboardCard(
      title: 'Recommended For You',
      icon: Icons.recommend,
      accentColor: Colors.purple,
      onViewAllTap: onViewAllTap,
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState(context);
    }

    if (stylists.isEmpty) {
      return _buildEmptyState(context);
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stylists.length > 3 ? 3 : stylists.length,
        itemBuilder: (context, index) {
          final stylist = stylists[index];
          return StylistCard(
            stylist: stylist,
            onTap: onStylistTap,
            showBookButton: false,
            compact: true,
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState(context);
    }

    if (stylists.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalized Recommendations',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Based on your preferences and booking history',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stylists.length,
            itemBuilder: (context, index) {
              final stylist = stylists[index];
              return StylistCard(
                stylist: stylist,
                onTap: onStylistTap,
                showBookButton: true,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Recommendation reasons
        _buildRecommendationReasons(context),
      ],
    );
  }

  Widget _buildRecommendationReasons(BuildContext context) {
    final theme = Theme.of(context);
    
    // Mock recommendation reasons
    final reasons = [
      {
        'icon': Icons.style,
        'title': 'Style Match',
        'description': 'Matches your preferred styles',
      },
      {
        'icon': Icons.location_on,
        'title': 'Nearby',
        'description': 'Close to your location',
      },
      {
        'icon': Icons.schedule,
        'title': 'Available Soon',
        'description': 'Has openings in the next few days',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why We Recommend These Stylists',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...reasons.map((reason) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  reason['icon'] as IconData,
                  color: Colors.purple,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reason['title'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      reason['description'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            height: 160,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'An error occurred',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_off,
              color: Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No recommended stylists available',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
