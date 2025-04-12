import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart' as models;
import 'package:zinapp_v2/services/user_profile_service.dart';

// Generate the provider code
part 'user_profile_provider.g.dart';

/// Provider for the UserProfileService
@riverpod
UserProfileService userProfileService(Ref ref) {
  return UserProfileService();
}

/// Provider for user profile state
@riverpod
class UserProfileProvider extends _$UserProfileProvider {
  @override
  UserProfileState build() {
    return UserProfileState.initial();
  }

  /// Get the current user profile from the auth provider
  models.UserProfile? get userProfile => ref.read(authProvider).user;

  /// Load user profile
  Future<void> loadUserProfile() async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final user = await ref.read(userProfileServiceProvider).getUserProfile(userId);
      ref.read(authProvider.notifier).updateUser(user);
      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final user = await ref.read(userProfileServiceProvider).updateUserProfile(userId, updates);
      ref.read(authProvider.notifier).updateUser(user);
      state = state.copyWith(isLoading: false, error: null);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Add XP
  Future<bool> addXp(int amount, String reason) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final user = await ref.read(userProfileServiceProvider).addXp(userId, amount, reason);
      ref.read(authProvider.notifier).updateUser(user);
      state = state.copyWith(isLoading: false, error: null);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Add or remove tokens
  Future<bool> updateTokens(
    int amount,
    TokenTransactionType type,
    String description, {
    String? relatedEntityId,
  }) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final user = await ref.read(userProfileServiceProvider).updateTokens(
        userId,
        amount,
        type,
        description,
        relatedEntityId: relatedEntityId,
      );
      ref.read(authProvider.notifier).updateUser(user);
      state = state.copyWith(isLoading: false, error: null);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Unlock achievement
  Future<bool> unlockAchievement(String achievementId) async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final user = await ref.read(userProfileServiceProvider).unlockAchievement(userId, achievementId);
      ref.read(authProvider.notifier).updateUser(user);
      state = state.copyWith(isLoading: false, error: null);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Load token transaction history
  Future<void> loadTokenHistory() async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final userId = authState.user!.id;
      final history = await ref.read(userProfileServiceProvider).getTokenHistory(userId);
      state = state.copyWith(isLoading: false, error: null, tokenHistory: history);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Clear the current error message
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// State class for user profile operations
class UserProfileState {
  final bool isLoading;
  final String? error;
  final List<TokenTransaction>? tokenHistory;

  const UserProfileState({
    required this.isLoading,
    this.error,
    this.tokenHistory,
  });

  /// Initial state
  factory UserProfileState.initial() {
    return const UserProfileState(
      isLoading: false,
    );
  }

  /// Creates a copy of this state with the given fields replaced with new values
  UserProfileState copyWith({
    bool? isLoading,
    String? error,
    List<TokenTransaction>? tokenHistory,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      tokenHistory: tokenHistory ?? this.tokenHistory,
    );
  }
}
