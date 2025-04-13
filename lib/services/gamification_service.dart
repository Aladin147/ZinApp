import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/user_profile_service.dart';

/// Service for handling gamification features like XP, levels, tokens, and achievements.
class GamificationService {
  final UserProfileService _userProfileService;
  
  // Cache for gamification rules
  Map<String, dynamic>? _gamificationRules;
  
  GamificationService({required UserProfileService userProfileService})
      : _userProfileService = userProfileService;
  
  /// Initialize the service by loading gamification rules
  Future<void> initialize() async {
    await _loadGamificationRules();
  }
  
  /// Load gamification rules from assets
  Future<void> _loadGamificationRules() async {
    try {
      // Try to load from assets first
      final jsonString = await rootBundle.loadString('assets/data/gamification.json');
      _gamificationRules = jsonDecode(jsonString);
    } catch (e) {
      // Fallback to hardcoded rules if file not found
      _gamificationRules = {
        "levels": [
          {"name": "Bronze", "minXP": 0},
          {"name": "Silver", "minXP": 100},
          {"name": "Gold", "minXP": 500},
          {"name": "Prime", "minXP": 1500},
          {"name": "Legend", "minXP": 5000}
        ],
        "actionRewards": {
          "rateExperience": {"xp": 5},
          "postPhoto": {"xp": 10, "zinTokens": 5},
          "completeBooking": {"xp": 20},
          "commentOnPost": {"xp": 3},
          "tagPhoto": {"xp": 30, "zinTokens": 10},
          "dailyLogin": {"xp": 2, "zinTokens": 1},
          "weeklyStreak": {"xp": 10, "zinTokens": 5},
          "monthlyStreak": {"xp": 50, "zinTokens": 25},
          "referFriend": {"xp": 100, "zinTokens": 50},
          "completeProfile": {"xp": 15, "zinTokens": 10},
          "firstBooking": {"xp": 30, "zinTokens": 15},
          "sharePost": {"xp": 5, "zinTokens": 2},
          "followStylist": {"xp": 5},
          "receiveFollower": {"xp": 2, "zinTokens": 1}
        }
      };
    }
  }
  
  /// Award XP and tokens for a specific action
  Future<Map<String, dynamic>> awardForAction(
    String userId,
    String actionType,
    {String? description, String? relatedEntityId}
  ) async {
    // Ensure rules are loaded
    if (_gamificationRules == null) {
      await _loadGamificationRules();
    }
    
    // Get rewards for this action
    final rewards = _getRewardsForAction(actionType);
    final xpGained = rewards['xp'] ?? 0;
    final tokensGained = rewards['zinTokens'] ?? 0;
    
    // Update user profile with XP
    UserProfile? updatedUser;
    if (xpGained > 0) {
      updatedUser = await _userProfileService.addXp(
        userId,
        xpGained,
        "Earned from $actionType",
      );
    }
    
    // Update user profile with tokens
    if (tokensGained > 0) {
      final tokenDescription = description ?? "Earned from $actionType";
      updatedUser = await _userProfileService.updateTokens(
        userId,
        tokensGained,
        TokenTransactionType.earned,
        tokenDescription,
        relatedEntityId: relatedEntityId,
      );
    }
    
    // Check if user leveled up
    bool leveledUp = false;
    String? newRank;
    
    if (updatedUser != null && xpGained > 0) {
      final oldLevel = _getLevelForXP(updatedUser.xp - xpGained);
      final newLevel = _getLevelForXP(updatedUser.xp);
      
      if (oldLevel != newLevel) {
        leveledUp = true;
        newRank = newLevel;
      }
    }
    
    // Return results
    return {
      'xpGained': xpGained,
      'tokensGained': tokensGained,
      'leveledUp': leveledUp,
      'newRank': newRank,
      'updatedUser': updatedUser,
    };
  }
  
  /// Get rewards for a specific action
  Map<String, int> _getRewardsForAction(String actionType) {
    if (_gamificationRules == null) {
      return {'xp': 0, 'zinTokens': 0};
    }
    
    final actionRewards = _gamificationRules!['actionRewards'];
    if (actionRewards == null || !actionRewards.containsKey(actionType)) {
      return {'xp': 0, 'zinTokens': 0};
    }
    
    final rewards = actionRewards[actionType];
    return {
      'xp': rewards['xp'] ?? 0,
      'zinTokens': rewards['zinTokens'] ?? 0,
    };
  }
  
  /// Get the level name for a given XP amount
  String _getLevelForXP(int xp) {
    if (_gamificationRules == null) {
      return 'Bronze';
    }
    
    final levels = _gamificationRules!['levels'];
    if (levels == null || levels.isEmpty) {
      return 'Bronze';
    }
    
    String levelName = levels[0]['name'];
    
    for (var level in levels) {
      if (xp >= level['minXP']) {
        levelName = level['name'];
      } else {
        break;
      }
    }
    
    return levelName;
  }
  
  /// Get XP required for next level
  int getXPForNextLevel(int currentXP) {
    if (_gamificationRules == null) {
      return 100;
    }
    
    final levels = _gamificationRules!['levels'];
    if (levels == null || levels.isEmpty) {
      return 100;
    }
    
    for (var i = 0; i < levels.length; i++) {
      final minXP = levels[i]['minXP'];
      if (currentXP < minXP) {
        return minXP;
      }
    }
    
    // Already at max level
    return levels.last['minXP'];
  }
  
  /// Calculate progress percentage to next level
  double calculateLevelProgress(int currentXP) {
    final currentLevelXP = _getCurrentLevelMinXP(currentXP);
    final nextLevelXP = getXPForNextLevel(currentXP);
    
    if (nextLevelXP <= currentLevelXP) {
      return 1.0; // Already at max level
    }
    
    final xpInCurrentLevel = currentXP - currentLevelXP;
    final xpRequiredForNextLevel = nextLevelXP - currentLevelXP;
    
    return xpInCurrentLevel / xpRequiredForNextLevel;
  }
  
  /// Get the minimum XP for the current level
  int _getCurrentLevelMinXP(int currentXP) {
    if (_gamificationRules == null) {
      return 0;
    }
    
    final levels = _gamificationRules!['levels'];
    if (levels == null || levels.isEmpty) {
      return 0;
    }
    
    int currentLevelXP = 0;
    
    for (var level in levels) {
      final minXP = level['minXP'];
      if (currentXP >= minXP) {
        currentLevelXP = minXP;
      } else {
        break;
      }
    }
    
    return currentLevelXP;
  }
  
  /// Get all available actions that can earn rewards
  List<Map<String, dynamic>> getAvailableActions() {
    if (_gamificationRules == null) {
      return [];
    }
    
    final actionRewards = _gamificationRules!['actionRewards'];
    if (actionRewards == null) {
      return [];
    }
    
    final actions = <Map<String, dynamic>>[];
    
    actionRewards.forEach((key, value) {
      actions.add({
        'type': key,
        'xp': value['xp'] ?? 0,
        'tokens': value['zinTokens'] ?? 0,
      });
    });
    
    return actions;
  }
  
  /// Check if a token transaction would exceed daily limits
  Future<bool> checkTokenLimits(String userId, String actionType) async {
    // TODO: Implement daily token limits to prevent abuse
    // This would check if the user has already earned too many tokens today
    // from this specific action type
    
    return true; // For now, always allow
  }
}
