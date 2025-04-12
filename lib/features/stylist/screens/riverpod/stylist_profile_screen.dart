import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/stylist/extensions/stylist_extensions.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class StylistProfileScreen extends ConsumerStatefulWidget {
  final String stylistId;

  const StylistProfileScreen({
    super.key,
    required this.stylistId,
  });

  @override
  ConsumerState<StylistProfileScreen> createState() => _StylistProfileScreenState();
}

class _StylistProfileScreenState extends ConsumerState<StylistProfileScreen> {
  Stylist? _stylist;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStylist();
  }

  Future<void> _loadStylist() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final stylist = await ref.read(stylistProviderProvider.notifier).getStylistById(widget.stylistId);
      setState(() {
        _stylist = stylist;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stylist Profile'),
          backgroundColor: AppColors.baseDark,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stylist Profile'),
          backgroundColor: AppColors.baseDark,
          foregroundColor: Colors.white,
        ),
        body: Center(
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
                'Error: $_error',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadStylist,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_stylist == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stylist Profile'),
          backgroundColor: AppColors.baseDark,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_off,
                color: Colors.grey,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Stylist not found',
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with stylist image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.baseDark,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_stylist!.name),
              background: _stylist!.profileImageUrl != null
                  ? Image.network(
                      _stylist!.profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: AppColors.primaryHighlight,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: AppColors.primaryHighlight,
                        ),
                      ),
                    ),
            ),
          ),

          // Stylist info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_stylist!.rating.toStringAsFixed(1)} (${_stylist!.reviewCount} reviews)',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Specialties
                  Text(
                    'Specialties',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _stylist!.specialties.map((specialty) {
                      return Chip(
                        label: Text(specialty),
                        backgroundColor: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                        labelStyle: TextStyle(
                          color: AppColors.primaryHighlight.withAlpha(230), // 0.9 opacity
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Bio
                  Text(
                    'About',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _stylist!.bio ?? 'No bio available',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Location
                  Text(
                    'Location',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primaryHighlight,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _stylist!.location ?? 'Location not specified',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Book button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement booking functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryHighlight,
                        foregroundColor: AppColors.baseDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
