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
        expect(userProfile.name, isNotEmpty);
        expect(userProfile.email, isNotEmpty);
        expect(userProfile.profilePictureUrl, isNotEmpty);
      });

      test('throws an exception for an invalid user ID', () async {
        // Act & Assert
        expect(
          () => mockApiService.getUserProfile('invalid_user_id'),
          throwsException,
        );
      });
    });

    group('getFeed', () {
      test('returns a list of posts', () async {
        // Act
        final posts = await mockApiService.getFeed();

        // Assert
        expect(posts, isA<List<Post>>());
        expect(posts, isNotEmpty);
        for (final post in posts) {
          expect(post.id, isNotEmpty);
          expect(post.userId, isNotEmpty);
          expect(post.user, isA<UserProfile>());
          expect(post.content, isNotEmpty);
          expect(post.likes, isA<int>());
          expect(post.comments, isA<int>());
          expect(post.isLiked, isA<bool>());
          expect(post.createdAt, isA<DateTime>());
        }
      });
    });

    group('getStylists', () {
      test('returns a list of stylists', () async {
        // Act
        final stylists = await mockApiService.getStylists();

        // Assert
        expect(stylists, isA<List<Stylist>>());
        expect(stylists, isNotEmpty);
        for (final stylist in stylists) {
          expect(stylist.id, isNotEmpty);
          expect(stylist.name, isNotEmpty);
          expect(stylist.profilePictureUrl, isNotEmpty);
          expect(stylist.rating, isA<double>());
          expect(stylist.reviewCount, isA<int>());
          expect(stylist.specialties, isA<List<String>>());
          expect(stylist.location, isNotEmpty);
          expect(stylist.priceRange, isNotEmpty);
          expect(stylist.isAvailable, isA<bool>());
        }
      });
    });

    group('getFeaturedStylists', () {
      test('returns a list of featured stylists', () async {
        // Act
        final stylists = await mockApiService.getFeaturedStylists();

        // Assert
        expect(stylists, isA<List<Stylist>>());
        expect(stylists, isNotEmpty);
        for (final stylist in stylists) {
          expect(stylist.isFeatured, isTrue);
        }
      });
    });

    group('likePost', () {
      test('returns true when liking a post succeeds', () async {
        // Act
        final result = await mockApiService.likePost('post1', 'user1');

        // Assert
        expect(result, isTrue);
      });
    });

    group('unlikePost', () {
      test('returns true when unliking a post succeeds', () async {
        // Act
        final result = await mockApiService.unlikePost('post1', 'user1');

        // Assert
        expect(result, isTrue);
      });
    });

    group('addComment', () {
      test('returns true when adding a comment succeeds', () async {
        // Act
        final result = await mockApiService.addComment(
          postId: 'post1',
          userId: 'user1',
          text: 'This is a test comment',
        );

        // Assert
        expect(result, isTrue);
      });
    });

    group('getComments', () {
      test('returns a list of comments for a post', () async {
        // Act
        final comments = await mockApiService.getComments('post1');

        // Assert
        expect(comments, isA<List<Map<String, dynamic>>>());
        for (final comment in comments) {
          expect(comment['id'], isNotEmpty);
          expect(comment['postId'], 'post1');
          expect(comment['userId'], isNotEmpty);
          expect(comment['user'], isA<Map<String, dynamic>>());
          expect(comment['text'], isNotEmpty);
          expect(comment['createdAt'], isNotEmpty);
        }
      });
    });
  });
}
