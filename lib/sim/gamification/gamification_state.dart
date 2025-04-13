import 'package:equatable/equatable.dart';
import 'package:zinapp_v2/models/achievement.dart'; // Assuming definition exists
import 'package:zinapp_v2/models/challenge.dart'; // Assuming definition exists

// TODO: Define models for UserChallengeProgress and UserAchievementProgress if needed

/// Represents the state of the gamification simulation for a user.
/// This state is managed internally by the simulation layer for now.
class GamificationState extends Equatable {
  final int currentXp;
  final int currentLevel;
  final int currentTokens;
  final List<String> unlockedAchievementIds; // IDs of unlocked achievements
  final List<String> unlockedBadgeIds; // IDs of unlocked badges (if badges are separate)
  final int currentStreak;
  final DateTime? lastStreakCheckIn;
  // TODO: Add challenge progress tracking (e.g., Map<String, int> challengeProgress)

  const GamificationState({
    required this.currentXp,
    required this.currentLevel,
    required this.currentTokens,
    required this.unlockedAchievementIds,
    required this.unlockedBadgeIds,
    required this.currentStreak,
    this.lastStreakCheckIn,
  });

  /// Initial state for a new user simulation.
  factory GamificationState.initial() {
    return const GamificationState(
      currentXp: 0,
      currentLevel: 1,
      currentTokens: 0, // Start with 0 tokens? Or a small amount?
      unlockedAchievementIds: [],
      unlockedBadgeIds: [],
      currentStreak: 0,
      lastStreakCheckIn: null,
    );
  }

  // TODO: Add methods for calculating XP needed for next level, etc.
  int get xpForNextLevel => (currentLevel + 1) * 1000; // Example calculation
  double get levelProgress => (currentXp % xpForNextLevel) / xpForNextLevel;

  @override
  List<Object?> get props => [
        currentXp,
        currentLevel,
        currentTokens,
        unlockedAchievementIds,
        unlockedBadgeIds,
        currentStreak,
        lastStreakCheckIn,
      ];

  GamificationState copyWith({
    int? currentXp,
    int? currentLevel,
    int? currentTokens,
    List<String>? unlockedAchievementIds,
    List<String>? unlockedBadgeIds,
    int? currentStreak,
    DateTime? lastStreakCheckIn,
    bool clearLastStreakCheckIn = false, // Flag to explicitly set to null
  }) {
    return GamificationState(
      currentXp: currentXp ?? this.currentXp,
      currentLevel: currentLevel ?? this.currentLevel,
      currentTokens: currentTokens ?? this.currentTokens,
      unlockedAchievementIds: unlockedAchievementIds ?? this.unlockedAchievementIds,
      unlockedBadgeIds: unlockedBadgeIds ?? this.unlockedBadgeIds,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStreakCheckIn: clearLastStreakCheckIn ? null : (lastStreakCheckIn ?? this.lastStreakCheckIn),
    );
  }
}
