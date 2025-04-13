import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/mock_api_service.dart';

void main() {
  group('MockApiService', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    group('getUserProfile', () {
      test('returns a UserProfile for a valid user ID', () async {
        // Act
        final userProfile = await mockApiService.getUserProfile('user1');

        // Assert
        expect(userProfile, isA<UserProfile>());
        expect(userProfile.id, 'user1');
        expect(userProfile.username, isNotEmpty); // Use username
        expect(userProfile.email, isNotEmpty);
        // profilePictureUrl can be null, so just check type or handle null
        expect(userProfile.profilePictureUrl, isA<String?>());
      });

      test('throws an exception for an invalid user ID', () async {
        // Act & Assert
        expect(
          () => mockApiService.getUserProfile('invalid_user_id'),
          throwsException,
        );
      });
    });

    // Removed tests for methods not present in MockApiService/ApiService interface
    // (getFeed, getStylists, getFeaturedStylists, likePost, unlikePost, addComment, getComments)
    // These should be tested in their respective service tests (e.g., FeedService tests).

  }); // End group MockApiService
} // End main
