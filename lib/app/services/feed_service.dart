import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/app/features/feed/models/post.dart';
import 'package:zinapp_v2/app/models/user_profile.dart';
import 'package:zinapp_v2/app/services/api_config.dart';
import 'package:zinapp_v2/app/services/mock_data.dart';

/// Exception thrown when feed operations fail
class FeedException implements Exception {
  final String message;
  FeedException(this.message);

  @override
  String toString() => 'FeedException: $message';
}

/// Service responsible for feed operations
class FeedService {
  final String baseUrl = ApiConfig.baseUrl;

  /// Get all posts
  Future<List<Post>> getAllPosts() async {
    try {
      if (ApiConfig.useMockData) {
        // Use mock data
        return MockData.posts.map((data) => Post.fromJson(data)).toList();
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/posts'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> postsData = jsonDecode(response.body);
          return postsData.map((data) => Post.fromJson(data)).toList();
        } else {
          throw FeedException('Failed to get posts: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting posts: $e');
    }
  }

  /// Get posts by user ID
  Future<List<Post>> getPostsByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> postsData = jsonDecode(response.body);
        return postsData.map((data) => Post.fromJson(data)).toList();
      } else {
        throw FeedException(
            'Failed to get posts by user: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting posts by user: $e');
    }
  }

  /// Get post by ID
  Future<Post> getPostById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$id'),
      );

      if (response.statusCode == 200) {
        final postData = jsonDecode(response.body);
        return Post.fromJson(postData);
      } else {
        throw FeedException('Failed to get post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting post: $e');
    }
  }

  /// Create a new post
  Future<Post> createPost({
    required String userId,
    required String content,
    required List<String> imageUrls,
    required List<String> tags,
    String? location,
  }) async {
    try {
      final postData = {
        'id': 'post${DateTime.now().millisecondsSinceEpoch}',
        'userId': userId,
        'content': content,
        'imageUrls': imageUrls,
        'tags': tags,
        'location': location,
        'likesCount': 0,
        'commentsCount': 0,
        'sharesCount': 0,
        'createdAt': DateTime.now().toIso8601String(),
      };

      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 201) {
        final createdPostData = jsonDecode(response.body);
        return Post.fromJson(createdPostData);
      } else {
        throw FeedException('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error creating post: $e');
    }
  }

  /// Like a post
  Future<Post> likePost(String postId) async {
    try {
      // Get current post
      final post = await getPostById(postId);

      // Update likes count
      final updatedPost = {
        'likesCount': post.likesCount + 1,
      };

      final response = await http.patch(
        Uri.parse('$baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedPost),
      );

      if (response.statusCode == 200) {
        final updatedPostData = jsonDecode(response.body);
        return Post.fromJson(updatedPostData);
      } else {
        throw FeedException('Failed to like post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error liking post: $e');
    }
  }

  /// Get user profile for a post
  Future<UserProfile> getUserForPost(String userId) async {
    try {
      if (ApiConfig.useMockData) {
        // Check users collection
        final userMatch = MockData.users.where((u) => u['id'] == userId).toList();
        if (userMatch.isNotEmpty) {
          return UserProfile.fromJson(userMatch.first);
        }

        // Check stylists collection
        final stylistMatch = MockData.stylists.where((s) => s['id'] == userId).toList();
        if (stylistMatch.isNotEmpty) {
          return UserProfile.fromJson(stylistMatch.first);
        }

        throw FeedException('User not found for post');
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/users/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);
          return UserProfile.fromJson(userData);
        } else {
          // Try stylists collection
          final stylistResponse = await http.get(
            Uri.parse('$baseUrl/stylists/$userId'),
          );

          if (stylistResponse.statusCode == 200) {
            final stylistData = jsonDecode(stylistResponse.body);
            return UserProfile.fromJson(stylistData);
          } else {
            throw FeedException(
                'Failed to get user for post: ${response.statusCode}');
          }
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting user for post: $e');
    }
  }
}
