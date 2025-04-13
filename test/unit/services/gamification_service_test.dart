import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart'; // Import annotations for generation
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/models/user.dart'; // Import UserType
import 'package:zinapp_v2/models/token_transaction.dart'; // Import TokenTransactionType
import 'package:zinapp_v2/services/gamification_service.dart';
import 'package:zinapp_v2/services/user_profile_service.dart'; // Import the actual dependency

// Generate mocks for UserProfileService
@GenerateMocks([UserProfileService])
import 'gamification_service_test.mocks.dart'; // Import generated mocks

void main() {
  group('GamificationService', () {
    late GamificationService gamificationService;
    late MockUserProfileService mockUserProfileService; // Use the correct mock type

    setUp(() {
      mockUserProfileService = MockUserProfileService();
      // Provide the correct dependency to the constructor
      gamificationService = GamificationService(userProfileService: mockUserProfileService);
      // Initialize the service (loads rules) - important for tests relying on rules
      gamificationService.initialize();
    });

    // Helper to create a valid UserProfile for tests
    UserProfile createTestUserProfile({
      String id = 'user1',
      int xp = 1490,
      int level = 5,
      int tokens = 50,
      // Add other required fields with default values
      String username = 'TestUser',
      String email = 'test@example.com',
      UserType userType = UserType.regular,
      DateTime? createdAt,
      DateTime? lastLogin,
      List<String> achievements = const [],
      List<String> badges = const [],
      String rank = 'Gold', // Match level 5 based on default rules
      int postsCount = 0,
      int bookingsCount = 0,
      int followersCount = 0,
      int followingCount = 0,
    }) {
      return UserProfile(
        id: id,
        username: username,
        email: email,
        userType: userType,
        createdAt: createdAt ?? DateTime.now().subtract(const Duration(days: 10)),
        lastLogin: lastLogin ?? DateTime.now().subtract(const Duration(days: 1)),
        xp: xp,
        level: level,
        tokens: tokens,
        achievements: achievements,
        badges: badges,
        rank: rank,
        postsCount: postsCount,
        bookingsCount: bookingsCount,
        followersCount: followersCount,
        followingCount: followingCount,
      );
    }


    group('awardForAction', () {
      test('awards XP and tokens for a valid action (e.g., post_created)', () async {
        // Arrange
        final initialProfile = createTestUserProfile(xp: 100); // Start with some XP
        // Mock the necessary UserProfileService methods used by awardForAction
        when(mockUserProfileService.addXp(any, any, any))
            .thenAnswer((invocation) async {
                final currentXp = initialProfile.xp;
                final gainedXp = invocation.positionalArguments[1] as int;
                return initialProfile.copyWith(xp: currentXp + gainedXp);
            });
         when(mockUserProfileService.updateTokens(any, any, any, any, relatedEntityId: anyNamed('relatedEntityId')))
             .thenAnswer((invocation) async {
                 final currentTokens = initialProfile.tokens;
                 final gainedTokens = invocation.positionalArguments[1] as int;
                 return initialProfile.copyWith(tokens: currentTokens + gainedTokens);
             });

        // Act
        final result = await gamificationService.awardForAction(
          initialProfile.id,
          'postPhoto', // Use an action defined in default rules
          description: 'Created a new post',
        );

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['xpGained'], 10); // Check against default rules
        expect(result['tokensGained'], 5); // Check against default rules
        expect(result['leveledUp'], isA<bool>());
        // expect(result['newRank'], isA<String?>()); // Rank is String? - Asserting type might be brittle if null is valid
        expect(result['updatedUser'], isA<UserProfile>());
        // Verify that the service methods were called
        verify(mockUserProfileService.addXp(initialProfile.id, 10, any)).called(1);
        verify(mockUserProfileService.updateTokens(initialProfile.id, 5, TokenTransactionType.earned, any, relatedEntityId: null)).called(1);
      });

      test('awards different amounts for different actions', () async {
        // Arrange
        final initialProfile = createTestUserProfile(xp: 100);
         when(mockUserProfileService.addXp(any, any, any))
             .thenAnswer((invocation) async => initialProfile.copyWith(xp: initialProfile.xp + (invocation.positionalArguments[1] as int)));
         when(mockUserProfileService.updateTokens(any, any, any, any, relatedEntityId: anyNamed('relatedEntityId')))
              .thenAnswer((invocation) async => initialProfile.copyWith(tokens: initialProfile.tokens + (invocation.positionalArguments[1] as int)));

        // Act
        final postResult = await gamificationService.awardForAction(
          initialProfile.id,
          'postPhoto',
          description: 'Created a new post',
        );

        final commentResult = await gamificationService.awardForAction(
          initialProfile.id,
          'commentOnPost',
          description: 'Added a comment',
        );

        // Assert
        expect(postResult['xpGained'], 10);
        expect(commentResult['xpGained'], 3);
        expect(postResult['xpGained'], isNot(equals(commentResult['xpGained'])));

        expect(postResult['tokensGained'], 5);
        expect(commentResult['tokensGained'], 0); // commentOnPost has no token reward in defaults
        expect(postResult['tokensGained'], isNot(equals(commentResult['tokensGained'])));
      });

      test('detects level up when XP threshold is crossed', () async {
        // Arrange
        // Use helper to create profile just below Gold threshold (500 XP)
        final userProfile = createTestUserProfile(xp: 485, level: 2, rank: 'Silver');

        // Mock addXp to return the updated profile with new XP and potentially level/rank
        when(mockUserProfileService.addXp(userProfile.id, any, any))
            .thenAnswer((invocation) async {
                final gainedXp = invocation.positionalArguments[1] as int;
                // Simulate UserProfileService updating level/rank based on new XP
                final newXp = userProfile.xp + gainedXp;
                return userProfile.copyWith(
                    xp: newXp,
                    level: 3, // Manually set expected new level
                    rank: 'Gold' // Manually set expected new rank
                );
            });
        // Mock updateTokens as it's also called
        when(mockUserProfileService.updateTokens(any, any, any, any, relatedEntityId: anyNamed('relatedEntityId')))
             .thenAnswer((invocation) async => userProfile.copyWith(tokens: userProfile.tokens + (invocation.positionalArguments[1] as int)));


        // Act
        final result = await gamificationService.awardForAction(
          userProfile.id,
          'completeBooking', // Gives 20 XP, should push user past 500 to Gold
          description: 'Completed a booking',
        );

        // Assert
        expect(result['xpGained'], 20);
        expect(result['leveledUp'], isTrue);
        expect(result['newRank'], 'Gold'); // Check the rank name based on rules
        verify(mockUserProfileService.addXp(userProfile.id, 20, any)).called(1);
      });
    });

    // Note: Tests for private methods like _calculateLevelForXp are removed as they are not directly testable.
    // The public methods relying on them (getXPForNextLevel, calculateLevelProgress) are tested instead.

    group('getXPForNextLevel', () { // Test the public method
      test('returns the correct XP required for the next level', () {
        // Arrange: Ensure rules are loaded via initialize() in setUp

        // Act & Assert
        // Based on default rules: 0, 100, 500, 1500, 5000
        expect(gamificationService.getXPForNextLevel(0), 100); // Level Bronze(1) to Silver(2)
        expect(gamificationService.getXPForNextLevel(50), 100); // Level Bronze(1) to Silver(2)
        expect(gamificationService.getXPForNextLevel(100), 500); // Level Silver(2) to Gold(3)
        expect(gamificationService.getXPForNextLevel(499), 500); // Level Silver(2) to Gold(3)
        expect(gamificationService.getXPForNextLevel(500), 1500); // Level Gold(3) to Prime(4)
        expect(gamificationService.getXPForNextLevel(1499), 1500); // Level Gold(3) to Prime(4)
        expect(gamificationService.getXPForNextLevel(1500), 5000); // Level Prime(4) to Legend(5)
        expect(gamificationService.getXPForNextLevel(4999), 5000); // Level Prime(4) to Legend(5)
        expect(gamificationService.getXPForNextLevel(5000), 5000); // At max level
        expect(gamificationService.getXPForNextLevel(10000), 5000); // Above max level
      });
    });

    group('calculateLevelProgress', () {
      test('returns the correct progress percentage for various XP values', () {
        // Arrange: Ensure rules are loaded via initialize() in setUp

        // Act & Assert
        // Levels: 0, 100, 500, 1500, 5000
        expect(gamificationService.calculateLevelProgress(0), closeTo(0.0, 0.01)); // Start of level 1 (0/100)
        expect(gamificationService.calculateLevelProgress(50), closeTo(0.5, 0.01)); // Halfway level 1 (50/100)
        expect(gamificationService.calculateLevelProgress(100), closeTo(0.0, 0.01)); // Start of level 2 (0/400)
        expect(gamificationService.calculateLevelProgress(300), closeTo(0.5, 0.01)); // Halfway level 2 (200/400)
        expect(gamificationService.calculateLevelProgress(500), closeTo(0.0, 0.01)); // Start of level 3 (0/1000)
        expect(gamificationService.calculateLevelProgress(1000), closeTo(0.5, 0.01)); // Halfway level 3 (500/1000)
        expect(gamificationService.calculateLevelProgress(1500), closeTo(0.0, 0.01)); // Start of level 4 (0/3500)
        expect(gamificationService.calculateLevelProgress(3250), closeTo(0.5, 0.01)); // Halfway level 4 (1750/3500)
        expect(gamificationService.calculateLevelProgress(5000), closeTo(1.0, 0.01)); // Max level
        expect(gamificationService.calculateLevelProgress(6000), closeTo(1.0, 0.01)); // Above max level
      });
    });

    group('getAvailableActions', () {
      test('returns a list of available actions from rules', () {
        // Arrange: Ensure rules are loaded via initialize() in setUp

        // Act
        final actions = gamificationService.getAvailableActions();

        // Assert
        expect(actions, isA<List<Map<String, dynamic>>>());
        expect(actions, isNotEmpty);
        // Check a known action from default rules
        final postAction = actions.firstWhere((a) => a['type'] == 'postPhoto', orElse: () => {});
        expect(postAction['xp'], 10);
        expect(postAction['tokens'], 5);

        for (final action in actions) {
          expect(action['type'], isA<String>());
          expect(action['xp'], isA<int>());
          expect(action['tokens'], isA<int>());
        }
      });
    });
  }); // End of group('GamificationService')
} // End of main()
