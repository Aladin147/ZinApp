import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';
import 'package:zinapp_v2/services/user_profile_service.dart';

/// Provider for managing user profile data
class UserProfileProvider extends ChangeNotifier {
  final UserProfileService _profileService = UserProfileService();
  final AuthProvider _authProvider;

  UserProfileProvider(this._authProvider);

  bool _isLoading = false;
  String? _error;
  List<TokenTransaction>? _tokenHistory;

  /// Current user profile
  UserProfile? get userProfile => _authProvider.user;

  /// Whether profile operations are in progress
  bool get isLoading => _isLoading;

  /// Current error message
  String? get error => _error;

  /// Token transaction history
  List<TokenTransaction>? get tokenHistory => _tokenHistory;

  /// Load user profile
  Future<void> loadUserProfile() async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      final user = await _profileService.getUserProfile(userId);
      _authProvider.updateUser(user);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Update profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return false;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      final user = await _profileService.updateUserProfile(userId, updates);
      _authProvider.updateUser(user);
      _setError(null);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Add XP
  Future<bool> addXp(int amount, String reason) async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return false;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      final user = await _profileService.addXp(userId, amount, reason);
      _authProvider.updateUser(user);
      _setError(null);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update tokens
  Future<bool> updateTokens(
    int amount,
    TokenTransactionType type,
    String description, {
    String? relatedEntityId,
  }) async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return false;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      final user = await _profileService.updateTokens(
        userId,
        amount,
        type,
        description,
        relatedEntityId: relatedEntityId,
      );
      _authProvider.updateUser(user);
      _setError(null);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Unlock achievement
  Future<bool> unlockAchievement(String achievementId) async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return false;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      final user = await _profileService.unlockAchievement(userId, achievementId);
      _authProvider.updateUser(user);
      _setError(null);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Load token transaction history
  Future<void> loadTokenHistory() async {
    if (!_authProvider.isAuthenticated || _authProvider.user == null) {
      return;
    }

    _setLoading(true);

    try {
      final userId = _authProvider.user!.id;
      _tokenHistory = await _profileService.getTokenHistory(userId);
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
