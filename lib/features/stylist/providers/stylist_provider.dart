import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/services/stylist_service.dart';

/// Provider for managing stylist data
class StylistProvider extends ChangeNotifier {
  final StylistService _stylistService = StylistService();

  List<Stylist> _allStylists = [];
  List<Stylist> _featuredStylists = [];
  List<Stylist> _availableStylists = [];
  List<Stylist> _searchResults = [];

  bool _isLoading = false;
  String? _error;

  /// All stylists
  List<Stylist> get allStylists => _allStylists;

  /// Featured stylists (top rated or promoted)
  List<Stylist> get featuredStylists => _featuredStylists;

  /// Available stylists (those who are currently available)
  List<Stylist> get availableStylists => _availableStylists;

  /// Search results
  List<Stylist> get searchResults => _searchResults;

  /// Whether stylist operations are in progress
  bool get isLoading => _isLoading;

  /// Current error message
  String? get error => _error;

  /// Load all stylists
  Future<void> loadAllStylists() async {
    _setLoading(true);

    try {
      _allStylists = await _stylistService.getAllStylists();
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Load featured stylists
  Future<void> loadFeaturedStylists({int limit = 5}) async {
    _setLoading(true);

    try {
      _featuredStylists = await _stylistService.getFeaturedStylists(limit: limit);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Load available stylists
  Future<void> loadAvailableStylists({int limit = 5}) async {
    _setLoading(true);

    try {
      _availableStylists = await _stylistService.getAvailableStylists(limit: limit);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Search stylists
  Future<void> searchStylists(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      _searchResults = await _stylistService.searchStylists(query);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Get stylist by ID
  Future<Stylist?> getStylistById(String id) async {
    _setLoading(true);

    try {
      final stylist = await _stylistService.getStylistById(id);
      _setError(null);
      return stylist;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Load initial data (featured and available stylists)
  Future<void> loadInitialData() async {
    _setLoading(true);

    try {
      await Future.wait([
        loadFeaturedStylists(),
        loadAvailableStylists(),
      ]);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Clear the current error message
  void clearError() {
    _setError(null);
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
