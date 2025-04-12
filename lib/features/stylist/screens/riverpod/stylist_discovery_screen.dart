import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/stylist_discovery_dashboard.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Stylist'),
        backgroundColor: AppColors.baseDark,
        foregroundColor: Colors.white,
      ),
      body: StylistDiscoveryDashboard(
        searchController: _searchController,
        onSearch: (query) {
          if (query.isNotEmpty) {
            setState(() {
              _isSearching = true;
            });
            ref.read(stylistProviderProvider.notifier).searchStylists(query);
          }
        },
        onClearSearch: () {
          _searchController.clear();
          setState(() {
            _isSearching = false;
          });
        },
        isSearching: _isSearching,
      ),
    );
  }
}
