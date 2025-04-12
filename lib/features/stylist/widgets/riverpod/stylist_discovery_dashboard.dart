import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/featured_stylists_card.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/nearby_styles_card.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/style_categories_card.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/recommended_stylists_card.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/widgets/dashboard/dashboard_container.dart';

/// A dashboard widget for the Stylist Discovery screen
class StylistDiscoveryDashboard extends ConsumerWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final VoidCallback onClearSearch;
  final bool isSearching;

  const StylistDiscoveryDashboard({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.onClearSearch,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stylistState = ref.watch(stylistProviderProvider);

    return DashboardContainer(
      children: [
        // Search bar
        _buildSearchBar(context),

        // If searching, show search results, otherwise show dashboard cards
        if (isSearching)
          _buildSearchResults(context, stylistState)
        else ...[
          // Featured stylists card
          FeaturedStylistsCard(
            stylists: stylistState.featuredStylists,
            isLoading: stylistState.isLoading,
            errorMessage: stylistState.error,
            onStylistTap: (stylist) {
              context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
            },
            onViewAllTap: () {
              ref.read(stylistProviderProvider.notifier).loadAllStylists();
            },
          ),

          // Recommended stylists card
          RecommendedStylistsCard(
            stylists: stylistState.availableStylists,
            isLoading: stylistState.isLoading,
            errorMessage: stylistState.error,
            onStylistTap: (stylist) {
              context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
            },
            onViewAllTap: () {
              ref.read(stylistProviderProvider.notifier).loadAvailableStylists(limit: 100);
            },
          ),

          // Style categories card
          const StyleCategoriesCard(),

          // Nearby styles card
          const NearbyStylesCard(),
        ],
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search stylists...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: onClearSearch,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onSearch,
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, StylistState stylistState) {
    if (stylistState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (stylistState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              stylistState.error ?? 'An error occurred',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (stylistState.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              color: Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No stylists found for "${searchController.text}"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: stylistState.searchResults.length,
      itemBuilder: (context, index) {
        final stylist = stylistState.searchResults[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: stylist.profilePictureUrl != null
                  ? NetworkImage(stylist.profilePictureUrl!)
                  : null,
              child: stylist.profilePictureUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(
              stylist.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${stylist.stylistProfile.rating.toStringAsFixed(1)} (${stylist.stylistProfile.reviewCount})',
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  stylist.stylistProfile.services.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
              },
              child: const Text('View'),
            ),
            onTap: () {
              context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
            },
          ),
        );
      },
    );
  }
}
