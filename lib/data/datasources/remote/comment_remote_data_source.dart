import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/comment.dart'; // Assuming Comment model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider

/// Abstract class for remote comment data operations.
abstract class CommentRemoteDataSource {
  /// Fetches comments for a specific post.
  Future<List<Comment>> getCommentsForPost(String postId);
  Future<Comment> createComment(Comment comment);
  // Add update/delete if needed
}

/// Implementation of [CommentRemoteDataSource] using Dio.
class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'http://127.0.0.1:3000';

  CommentRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Comment>> getCommentsForPost(String postId) async {
    try {
      // json-server allows filtering by foreign key
      final response = await _dio.get(
        '$_baseUrl/comments',
        queryParameters: {'postId': postId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> commentList = response.data as List<dynamic>;
        return commentList
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching comments for post $postId: $e');
      throw Exception('Failed to fetch comments.');
    }
  }

  @override
  Future<Comment> createComment(Comment comment) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/comments',
        data: comment.toJson(),
      );
      if (response.statusCode == 201) {
        return Comment.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error creating comment: $e');
      throw Exception('Failed to create comment.');
    }
  }
}

// --- Riverpod Provider ---
final commentRemoteDataSourceProvider = Provider<CommentRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return CommentRemoteDataSourceImpl(dio);
});
