import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/services/gamification_service.dart';

part 'gamification_provider.g.dart';

/// Provider for the GamificationService
@Riverpod(keepAlive: true)
GamificationService gamificationService(GamificationServiceRef ref) {
  final userProfileService = ref.watch(userProfileServiceProvider);
  return GamificationService(userProfileService: userProfileService);
}

/// Provider for gamification state
@Riverpod(keepAlive: true)
class GamificationNotifier extends _$GamificationNotifier {
  @override
  GamificationState build() {
    return GamificationState.initial();
  }

  /// Initialize the gamification service
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    try {
      final gamificationService = ref.read(gamificationServiceProvider);
      await gamificationService.initialize();
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Award XP and tokens for a specific action
  Future<Map<String, dynamic>> awardForAction(
    String userId,
    String actionType, {
    String? description,
    String? relatedEntityId,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final gamificationService = ref.read(gamificationServiceProvider);
      final result = await gamificationService.awardForAction(
        userId,
        actionType,
        description: description,
        relatedEntityId: relatedEntityId,
      );

      state = state.copyWith(
        isLoading: false,
        error: null,
        lastReward: {
          'actionType': actionType,
          'xpGained': result['xpGained'],
          'tokensGained': result['tokensGained'],
          'leveledUp': result['leveledUp'],
          'newRank': result['newRank'],
        },
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return {
        'error': e.toString(),
        'xpGained': 0,
        'tokensGained': 0,
        'leveledUp': false,
      };
    }
  }

  /// Get available actions that can earn rewards
  List<Map<String, dynamic>> getAvailableActions() {
    final gamificationService = ref.read(gamificationServiceProvider);
    return gamificationService.getAvailableActions();
  }

  /// Calculate progress percentage to next level
  double calculateLevelProgress(int currentXP) {
    final gamificationService = ref.read(gamificationServiceProvider);
    return gamificationService.calculateLevelProgress(currentXP);
  }

  /// Get XP required for next level
  int getXPForNextLevel(int currentXP) {
    final gamificationService = ref.read(gamificationServiceProvider);
    return gamificationService.getXPForNextLevel(currentXP);
  }

  /// Clear the current error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clear the last reward
  void clearLastReward() {
    state = state.copyWith(lastReward: null);
  }
}

/// State class for gamification
class GamificationState {
  final bool isLoading;
  final bool isInitialized;
  final String? error;
  final Map<String, dynamic>? lastReward;

  GamificationState({
    required this.isLoading,
    required this.isInitialized,
    this.error,
    this.lastReward,
  });

  /// Initial state
  factory GamificationState.initial() {
    return GamificationState(
      isLoading: false,
      isInitialized: false,
    );
  }

  /// Create a copy with updated values
  GamificationState copyWith({
    bool? isLoading,
    bool? isInitialized,
    String? error,
    Map<String, dynamic>? lastReward,
  }) {
    return GamificationState(
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
      lastReward: lastReward,
    );
  }
}
