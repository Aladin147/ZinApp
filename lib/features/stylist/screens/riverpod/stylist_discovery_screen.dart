import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/stylist/extensions/stylist_extensions.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/stylist_carousel.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class StylistDiscoveryScreen extends ConsumerStatefulWidget {
  const StylistDiscoveryScreen({super.key});

  @override
  ConsumerState<StylistDiscoveryScreen> createState() => _StylistDiscoveryScreenState();
}

class _StylistDiscoveryScreenState extends ConsumerState<StylistDiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Load stylist data
    Future.microtask(() {
      ref.read(stylistProviderProvider.notifier).loadInitialData();
    });

    // Add listener for search
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        setState(() {
          _isSearching = true;
        });
        ref.read(stylistProviderProvider.notifier).searchStylists(_searchController.text);
      } else {
        setState(() {
          _isSearching = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stylistState = ref.watch(stylistProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Stylist'),
        backgroundColor: AppColors.baseDark,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search stylists...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _isSearching = false;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Content
          Expanded(
            child: _isSearching
                ? _buildSearchResults(stylistState)
                : _buildDiscoveryContent(stylistState),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryContent(StylistState stylistState) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(stylistProviderProvider.notifier).loadInitialData();
      },
      child: ListView(
        children: [
          const SizedBox(height: 16),

          // Featured stylists
          StylistCarousel(
            title: 'Featured Stylists',
            stylists: stylistState.featuredStylists,
            isLoading: stylistState.isLoading,
            errorMessage: stylistState.error,
            onStylistTap: (stylist) {
              context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
            },
            onSeeAllTap: () {
              // Load all stylists and filter for featured ones
              ref.read(stylistProviderProvider.notifier).loadAllStylists();
              // We'll stay on this screen but could navigate to a filtered view in the future
            },
          ),

          const SizedBox(height: 24),

          // Available now
          StylistCarousel(
            title: 'Available Now',
            stylists: stylistState.availableStylists,
            isLoading: stylistState.isLoading,
            errorMessage: stylistState.error,
            onStylistTap: (stylist) {
              context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
            },
            onSeeAllTap: () {
              // Load all stylists and filter for available ones
              ref.read(stylistProviderProvider.notifier).loadAvailableStylists(limit: 100);
              // We'll stay on this screen but could navigate to a filtered view in the future
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSearchResults(StylistState stylistState) {
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
              'No stylists found for "${_searchController.text}"',
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
      padding: const EdgeInsets.all(16),
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
              backgroundImage: stylist.profileImageUrl != null
                  ? NetworkImage(stylist.profileImageUrl!)
                  : null,
              child: stylist.profileImageUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(
              stylist.name,
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
                      '${stylist.rating.toStringAsFixed(1)} (${stylist.reviewCount})',
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  stylist.specialties.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryHighlight,
                foregroundColor: AppColors.baseDark,
              ),
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
