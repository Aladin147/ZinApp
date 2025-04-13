import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/post.dart'; // Assuming Post model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider

/// Abstract class for remote post data operations.
abstract class PostRemoteDataSource {
  Future<List<Post>> getPosts({Map<String, dynamic>? queryParams});
  Future<Post> getPostById(String postId);
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(String postId);
  // Add methods for likes, comments if handled via posts endpoint
}

/// Implementation of [PostRemoteDataSource] using Dio.
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'http://127.0.0.1:3000';

  PostRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Post>> getPosts({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/posts',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        final List<dynamic> postList = response.data as List<dynamic>;
        return postList
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to fetch posts.');
    }
  }

  @override
  Future<Post> getPostById(String postId) async {
    try {
      final response = await _dio.get('$_baseUrl/posts/$postId');
      if (response.statusCode == 200) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching post $postId: $e');
      throw Exception('Failed to fetch post.');
    }
  }

  @override
  Future<Post> createPost(Post post) async {
    try {
      // Note: json-server might assign its own ID, ignoring the one in post.toJson()
      final response = await _dio.post(
        '$_baseUrl/posts',
        data: post.toJson(),
      );
      if (response.statusCode == 201) { // Check for 201 Created
        return Post.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error creating post: $e');
      throw Exception('Failed to create post.');
    }
  }

  @override
  Future<Post> updatePost(Post post) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/posts/${post.id}',
        data: post.toJson(),
      );
      if (response.statusCode == 200) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error updating post ${post.id}: $e');
      throw Exception('Failed to update post.');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      final response = await _dio.delete('$_baseUrl/posts/$postId');
      if (response.statusCode != 200) { // json-server returns 200 on delete
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
      // No return value needed for delete
    } catch (e) {
      print('Error deleting post $postId: $e');
      throw Exception('Failed to delete post.');
    }
  }
}

// --- Riverpod Provider ---
final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return PostRemoteDataSourceImpl(dio);
});
