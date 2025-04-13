import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/models/achievement.dart';
import 'package:zinapp_v2/models/challenge.dart';
import 'package:zinapp_v2/sim/gamification/gamification_state.dart';

part 'gamification_simulation.g.dart';

// TODO: Define constants for XP amounts, token rewards, level thresholds etc.
const int xpPerLike = 1;
const int xpPerComment = 5;
const int xpPerPost = 10;
const int xpPerBooking = 50;
const int tokensPerLevelUp = 20;

/// Simulation provider for managing gamification logic (XP, levels, tokens, etc.)
///
/// This simulation currently operates independently of the data layer.
/// It will need to be integrated with repositories later to persist state.
@riverpod
class GamificationSimulation extends _$GamificationSimulation {

  // TODO: Load initial state from repository/storage when integrated
  @override
  GamificationState build() {
    // For now, start with an initial state for simulation purposes
    return GamificationState.initial();
  }

  // --- Core Logic Methods (To be implemented) ---

  /// Processes a user action and updates XP, potentially triggering level-ups, achievements, etc.
  void processUserAction(String actionType, {Map<String, dynamic>? details}) {
    // 1. Calculate XP earned for the action
    int xpEarned = _calculateXpForAction(actionType, details);
    if (xpEarned == 0) return; // No XP change

    // 2. Get current state values
    int currentXp = state.currentXp;
    int currentLevel = state.currentLevel;
    int currentTokens = state.currentTokens;
    List<String> currentAchievements = state.unlockedAchievementIds; // Keep track if needed

    // 3. Calculate potential new state
    int newXp = currentXp + xpEarned;
    int finalLevel = currentLevel;
    int finalTokens = currentTokens;
    List<String> newlyUnlockedAchievements = []; // Track newly unlocked ones in this action

    // Create a temporary state for level-up checks
    GamificationState tempCheckState = state.copyWith(currentXp: newXp);

    // 4. Check for level up (potentially multiple levels)
    while (tempCheckState.currentXp >= tempCheckState.xpForNextLevel) {
      finalLevel++;
      finalTokens += tokensPerLevelUp; // Award tokens for level up
      // TODO: Trigger level up effect/notification
      print("Level Up! Reached level $finalLevel");
      // Update tempCheckState for the next loop iteration's xpForNextLevel calculation
      tempCheckState = tempCheckState.copyWith(currentLevel: finalLevel, currentTokens: finalTokens);
    }

    // TODO: Check and update achievements based on new state/action
    // Example: if (newXp >= 1000 && !currentAchievements.contains('xp_1000')) {
    //   newlyUnlockedAchievements.add('xp_1000');
    //   // Potentially award bonus tokens/XP here or in unlockAchievement
    // }
    List<String> finalAchievements = List.from(currentAchievements)..addAll(newlyUnlockedAchievements);


    // 5. Update the actual state property once with all changes
    state = state.copyWith(
      currentXp: newXp,
      currentLevel: finalLevel,
      currentTokens: finalTokens,
      unlockedAchievementIds: finalAchievements,
    );

    // TODO: Check and update challenge progress based on the action
    _updateChallengeProgress(actionType, details);

    print("Action '$actionType': +$xpEarned XP. New State: Level ${state.currentLevel}, XP ${state.currentXp}, Tokens ${state.currentTokens}");
  }

  /// Calculates XP based on action type.
  int _calculateXpForAction(String actionType, Map<String, dynamic>? details) {
    switch (actionType) {
      case 'like_post': return xpPerLike;
      case 'comment_post': return xpPerComment;
      case 'create_post': return xpPerPost;
      case 'complete_booking': return xpPerBooking;
      // Add more actions...
      default: return 0;
    }
  }

  /// Checks and updates challenge progress based on an action.
  void _updateChallengeProgress(String actionType, Map<String, dynamic>? details) {
    // TODO: Implement challenge progress logic
    // This method would read state, calculate progress, and potentially update state
    // by calling addXp, addTokens, or directly modifying challenge progress state (if added).
    print("Challenge progress update needed for action: $actionType");
  }

  /// Adds XP directly (e.g., from challenge completion).
  void addXp(int amount) {
     if (amount <= 0) return;

     // Get current state
     int currentXp = state.currentXp;
     int currentLevel = state.currentLevel;
     int currentTokens = state.currentTokens;

     // Calculate potential new state
     int newXp = currentXp + amount;
     int finalLevel = currentLevel;
     int finalTokens = currentTokens;

     // Create a temporary state for level-up checks
     GamificationState tempCheckState = state.copyWith(currentXp: newXp, currentLevel: currentLevel, currentTokens: currentTokens);

     // Check for level ups
     while (tempCheckState.currentXp >= tempCheckState.xpForNextLevel) {
       finalLevel++;
       finalTokens += tokensPerLevelUp;
       print("Level Up! Reached level $finalLevel");
       // Update tempCheckState for the next loop iteration
       tempCheckState = tempCheckState.copyWith(currentLevel: finalLevel, currentTokens: finalTokens);
     }

     // Update the actual state property
     state = state.copyWith(
       currentXp: newXp,
       currentLevel: finalLevel,
       currentTokens: finalTokens,
     );
     print("Added $amount XP. New State: Level ${state.currentLevel}, XP ${state.currentXp}, Tokens ${state.currentTokens}");
  }

   /// Adds/removes tokens directly.
  void addTokens(int amount, String reason) {
     if (amount == 0) return;
     // Update the state property
     state = state.copyWith(currentTokens: state.currentTokens + amount);
     // TODO: Log transaction (when integrated with data layer)
     print("Tokens changed by $amount ($reason). New Balance: ${state.currentTokens}");
  }

  /// Checks daily streak and awards bonus if applicable.
  void checkDailyStreak() {
    final now = DateTime.now();
    final lastCheckIn = state.lastStreakCheckIn;
    int currentStreak = state.currentStreak;
    bool updatedStreak = false;

    if (lastCheckIn == null) {
      // First check-in ever
      currentStreak = 1;
      updatedStreak = true;
    } else {
      // Check if it's a new day compared to the last check-in
      final difference = DateTime(now.year, now.month, now.day)
          .difference(DateTime(lastCheckIn.year, lastCheckIn.month, lastCheckIn.day))
          .inDays;

      if (difference == 1) {
        // Consecutive day
        currentStreak++;
        updatedStreak = true;
      } else if (difference > 1) {
        // Streak broken
        currentStreak = 1;
        updatedStreak = true;
      }
      // If difference is 0, already checked in today, do nothing.
    }

    if (updatedStreak) {
      // Award streak bonus (example: 5 tokens + 2*streak XP)
      int tokenBonus = 5;
      int xpBonus = 2 * currentStreak;
      // Note: Calling addTokens/addXp will update the state internally.
      addTokens(tokenBonus, "Daily Streak Bonus (Day $currentStreak)");
      addXp(xpBonus);

      // Update the streak info in the state *after* bonuses are applied
      // We read the state again because addXp/addTokens might have changed it (level up)
      state = state.copyWith(
        currentStreak: currentStreak,
        lastStreakCheckIn: now,
      );
      print("Daily Check-in: Streak Day $currentStreak. Awarded +$tokenBonus Tokens, +$xpBonus XP. Final State: Level ${state.currentLevel}, XP ${state.currentXp}, Tokens ${state.currentTokens}");
    } else {
       print("Daily Check-in: Already checked in today or no streak update.");
    }
  }

  /// Unlocks a specific achievement.
  void unlockAchievement(String achievementId) {
    // Access state via the state property
    if (!state.unlockedAchievementIds.contains(achievementId)) {
      final updatedList = List<String>.from(state.unlockedAchievementIds)..add(achievementId);
      // Assign the new state to the state property
      state = state.copyWith(unlockedAchievementIds: updatedList);
      // TODO: Fetch achievement definition to award XP/Tokens (call addXp/addTokens)
      // TODO: Trigger achievement unlocked effect/notification
      print("Achievement Unlocked: $achievementId");
    }
  }

  // --- Other potential methods ---
  // void spendTokens(int amount, String reason)
  // void resetProgress()
  // Future<void> loadInitialDataFromRepository() // For later integration
}
