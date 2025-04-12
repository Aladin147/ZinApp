import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/gamification_service.dart';
import 'package:zinapp_v2/services/api_service.dart';

class MockApiService extends Mock implements ApiService {
  @override
  Future<UserProfile> getUserProfile(String userId) async {
    return UserProfile(
      id: userId,
      name: 'Test User',
      email: 'test@example.com',
      profilePictureUrl: 'https://example.com/profile.jpg',
      level: 5,
      xp: 1200,
      tokens: 50,
    );
  }

  @override
  Future<UserProfile> updateUserProfile(
    String userId, {
    String? name,
    String? email,
    String? profilePictureUrl,
    String? bio,
    int? level,
    int? xp,
    int? tokens,
    bool? isVerified,
  }) async {
    return UserProfile(
      id: userId,
      name: name ?? 'Test User',
      email: email ?? 'test@example.com',
      profilePictureUrl: profilePictureUrl ?? 'https://example.com/profile.jpg',
      bio: bio,
      level: level ?? 5,
      xp: xp ?? 1200,
      tokens: tokens ?? 50,
      isVerified: isVerified ?? false,
    );
  }
}

void main() {
  group('GamificationService', () {
    late GamificationService gamificationService;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      gamificationService = GamificationService(apiService: mockApiService);
    });

    group('awardForAction', () {
      test('awards XP and tokens for a valid action', () async {
        // Act
        final result = await gamificationService.awardForAction(
          'user1',
          'post_created',
          description: 'Created a new post',
        );

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['xpGained'], isA<int>());
        expect(result['tokensGained'], isA<int>());
        expect(result['leveledUp'], isA<bool>());
        expect(result['newLevel'], isA<int>());
      });

      test('awards different amounts for different actions', () async {
        // Act
        final postResult = await gamificationService.awardForAction(
          'user1',
          'post_created',
          description: 'Created a new post',
        );

        final commentResult = await gamificationService.awardForAction(
          'user1',
          'comment_added',
          description: 'Added a comment',
        );

        // Assert
        expect(postResult['xpGained'], isNot(equals(commentResult['xpGained'])));
      });

      test('detects level up when XP threshold is crossed', () async {
        // Arrange
        final userProfile = UserProfile(
          id: 'user1',
          name: 'Test User',
          email: 'test@example.com',
          profilePictureUrl: 'https://example.com/profile.jpg',
          level: 5,
          xp: 1490, // Just below level 6 threshold (1500)
          tokens: 50,
        );

        when(mockApiService.getUserProfile('user1'))
            .thenAnswer((_) async => userProfile);

        // Act
        final result = await gamificationService.awardForAction(
          'user1',
          'post_created', // Gives 20 XP, which should push user to level 6
          description: 'Created a new post',
        );

        // Assert
        expect(result['leveledUp'], isTrue);
        expect(result['newLevel'], 6);
      });
    });

    group('calculateLevelForXp', () {
      test('returns the correct level for various XP values', () {
        // Act & Assert
        expect(gamificationService.calculateLevelForXp(0), 1); // Minimum level
        expect(gamificationService.calculateLevelForXp(100), 1);
        expect(gamificationService.calculateLevelForXp(500), 3);
        expect(gamificationService.calculateLevelForXp(1000), 4);
        expect(gamificationService.calculateLevelForXp(1500), 6);
        expect(gamificationService.calculateLevelForXp(2000), 7);
        expect(gamificationService.calculateLevelForXp(5000), 15);
        expect(gamificationService.calculateLevelForXp(10000), 25);
      });
    });

    group('calculateXpForNextLevel', () {
      test('returns the correct XP required for the next level', () {
        // Act & Assert
        expect(gamificationService.calculateXpForNextLevel(0), 300); // Level 1 to 2
        expect(gamificationService.calculateXpForNextLevel(100), 300); // Level 1 to 2
        expect(gamificationService.calculateXpForNextLevel(500), 700); // Level 3 to 4
        expect(gamificationService.calculateXpForNextLevel(1000), 1200); // Level 4 to 5
        expect(gamificationService.calculateXpForNextLevel(1500), 1800); // Level 6 to 7
        expect(gamificationService.calculateXpForNextLevel(2000), 2300); // Level 7 to 8
      });
    });

    group('calculateLevelProgress', () {
      test('returns the correct progress percentage for various XP values', () {
        // Act & Assert
        expect(gamificationService.calculateLevelProgress(0), 0.0); // Start of level 1
        expect(gamificationService.calculateLevelProgress(150), 0.5); // Halfway through level 1
        expect(gamificationService.calculateLevelProgress(300), 0.0); // Start of level 2
        expect(gamificationService.calculateLevelProgress(400), 0.5); // Halfway through level 2
        expect(gamificationService.calculateLevelProgress(500), 0.0); // Start of level 3
      });
    });

    group('getAvailableActions', () {
      test('returns a list of available actions', () {
        // Act
        final actions = gamificationService.getAvailableActions();

        // Assert
        expect(actions, isA<List<Map<String, dynamic>>>());
        expect(actions, isNotEmpty);
        for (final action in actions) {
          expect(action['id'], isNotEmpty);
          expect(action['name'], isNotEmpty);
          expect(action['description'], isNotEmpty);
          expect(action['xpReward'], isA<int>());
          expect(action['tokenReward'], isA<int>());
        }
      });
    });
  });
}
