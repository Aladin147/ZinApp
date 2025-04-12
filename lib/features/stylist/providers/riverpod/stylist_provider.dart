import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/services/stylist_service.dart';

// Generate the provider code
part 'stylist_provider.g.dart';

/// Provider for the StylistService
@riverpod
StylistService stylistService(Ref ref) {
  return StylistService();
}

/// State class for the stylist provider
class StylistState {
  final List<Stylist> allStylists;
  final List<Stylist> featuredStylists;
  final List<Stylist> availableStylists;
  final List<Stylist> searchResults;
  final bool isLoading;
  final String? error;

  const StylistState({
    this.allStylists = const [],
    this.featuredStylists = const [],
    this.availableStylists = const [],
    this.searchResults = const [],
    this.isLoading = false,
    this.error,
  });

  /// Create a copy of this StylistState with the given fields replaced with new values
  StylistState copyWith({
    List<Stylist>? allStylists,
    List<Stylist>? featuredStylists,
    List<Stylist>? availableStylists,
    List<Stylist>? searchResults,
    bool? isLoading,
    String? error,
  }) {
    return StylistState(
      allStylists: allStylists ?? this.allStylists,
      featuredStylists: featuredStylists ?? this.featuredStylists,
      availableStylists: availableStylists ?? this.availableStylists,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for managing stylist data
@riverpod
class StylistProvider extends _$StylistProvider {
  @override
  StylistState build() {
    return const StylistState();
  }

  /// Load all stylists
  Future<void> loadAllStylists() async {
    state = state.copyWith(isLoading: true);

    try {
      final stylists = await ref.read(stylistServiceProvider).getAllStylists();
      state = state.copyWith(
        allStylists: stylists,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load featured stylists
  Future<void> loadFeaturedStylists({int limit = 5}) async {
    state = state.copyWith(isLoading: true);

    try {
      final stylists = await ref.read(stylistServiceProvider).getFeaturedStylists(limit: limit);
      state = state.copyWith(
        featuredStylists: stylists,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load available stylists
  Future<void> loadAvailableStylists({int limit = 5}) async {
    state = state.copyWith(isLoading: true);

    try {
      final stylists = await ref.read(stylistServiceProvider).getAvailableStylists(limit: limit);
      state = state.copyWith(
        availableStylists: stylists,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Search stylists
  Future<void> searchStylists(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: []);
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final results = await ref.read(stylistServiceProvider).searchStylists(query);
      state = state.copyWith(
        searchResults: results,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get stylist by ID
  Future<Stylist?> getStylistById(String id) async {
    state = state.copyWith(isLoading: true);

    try {
      final stylist = await ref.read(stylistServiceProvider).getStylistById(id);
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      return stylist;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// Load initial data (featured and available stylists)
  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.wait([
        loadFeaturedStylists(),
        loadAvailableStylists(),
      ]);
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Clear the current error message
  void clearError() {
    state = state.copyWith(error: null);
  }
}
