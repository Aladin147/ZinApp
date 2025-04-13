import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zinapp_v2/models/comment.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/feed_service.dart';

// Generate the provider code
part 'feed_provider.g.dart';

/// Provider for the FeedService
@riverpod
FeedService feedService(Ref ref) {
  return FeedService();
}

/// Provider for feed state
@riverpod
class Feed extends _$Feed {
  @override
  FeedState build() {
    return FeedState.initial();
  }

  /// Load initial posts (first page)
  Future<void> loadPosts() async {
    // Reset to initial page
    state = state.copyWith(
      isLoading: true,
      currentPage: 1,
      hasMorePages: true,
      posts: [], // Clear existing posts
    );

    try {
      final posts = await ref.read(feedServiceProvider).getAllPosts(
        page: 1,
        limit: 10, // Load 10 posts per page
      );

      // Sort by creation date (newest first)
      posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Load user profiles for posts
      final postUsers = await _loadUsersForPosts(posts);

      state = state.copyWith(
        posts: posts,
        postUsers: postUsers,
        isLoading: false,
        currentPage: 2, // Next page to load
        hasMorePages: posts.length >= 10, // If we got a full page, there might be more
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load more posts (next page)
  Future<void> loadMorePosts() async {
    // Don't load more if already loading or no more pages
    if (state.isLoading || !state.hasMorePages) return;

    state = state.copyWith(isLoading: true);

    try {
      final newPosts = await ref.read(feedServiceProvider).getAllPosts(
        page: state.currentPage,
        limit: 10, // Load 10 posts per page
      );

      // Sort by creation date (newest first)
      newPosts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Load user profiles for new posts
      final newPostUsers = await _loadUsersForPosts(newPosts);

      // Merge with existing posts and users
      final allPosts = [...state.posts, ...newPosts];
      final allPostUsers = {...state.postUsers, ...newPostUsers};

      state = state.copyWith(
        posts: allPosts,
        postUsers: allPostUsers,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMorePages: newPosts.length >= 10, // If we got a full page, there might be more
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load posts by user ID
  Future<void> loadPostsByUserId(String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await ref.read(feedServiceProvider).getPostsByUserId(userId);

      // Sort by creation date (newest first)
      posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Load user profiles for posts
      final postUsers = await _loadUsersForPosts(posts);

      state = state.copyWith(
        posts: posts,
        postUsers: postUsers,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Create a new post
  Future<bool> createPost({
    required String userId,
    required String content,
    required List<String> imageUrls,
    required List<String> tags,
    String? location,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final post = await ref.read(feedServiceProvider).createPost(
            userId: userId,
            content: content,
            imageUrls: imageUrls,
            tags: tags,
            location: location,
          );

      // Add to posts list
      final updatedPosts = [post, ...state.posts];

      // Update user profiles if needed
      final updatedPostUsers = Map<String, UserProfile>.from(state.postUsers);
      if (!updatedPostUsers.containsKey(userId)) {
        try {
          final user = await ref.read(feedServiceProvider).getUserForPost(userId);
          updatedPostUsers[userId] = user;
        } catch (_) {
          // Skip if user can't be loaded
        }
      }

      state = state.copyWith(
        posts: updatedPosts,
        postUsers: updatedPostUsers,
        isLoading: false,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Like a post (legacy method, use toggleLike instead)
  Future<bool> likePost(String postId) async {
    try {
      // Find the post
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) return false; // Post not found

      final post = state.posts[postIndex];

      // Only like if not already liked
      if (!post.isLiked) {
        await toggleLike(postId);
      }

      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Get user profile for a post
  UserProfile? getUserForPost(String userId) {
    return state.postUsers[userId];
  }

  /// Get user profile for a post (async version)
  Future<UserProfile?> getUserForPostAsync(String userId) async {
    if (state.postUsers.containsKey(userId)) {
      return state.postUsers[userId];
    }

    try {
      final user = await ref.read(feedServiceProvider).getUserForPost(userId);

      // Update users in state
      final updatedUsers = Map<String, UserProfile>.from(state.postUsers);
      updatedUsers[userId] = user;

      state = state.copyWith(postUsers: updatedUsers);

      return user;
    } catch (e) {
      return null;
    }
  }

  /// Load user profiles for all posts
  Future<Map<String, UserProfile>> _loadUsersForPosts(List<Post> posts) async {
    final userIds = posts.map((post) => post.userId).toSet().toList();
    final postUsers = Map<String, UserProfile>.from(state.postUsers);

    for (final userId in userIds) {
      if (!postUsers.containsKey(userId)) {
        try {
          final user = await ref.read(feedServiceProvider).getUserForPost(userId);
          postUsers[userId] = user;
        } catch (_) {
          // Skip this user
        }
      }
    }

    return postUsers;
  }

  /// Clear the current error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Set active post for comments
  void setActivePost(String postId) {
    state = state.copyWith(activePostId: postId);
    loadCommentsForPost(postId);
  }

  /// Clear active post
  void clearActivePost() {
    state = state.copyWith(activePostId: null);
  }

  /// Load comments for a post
  Future<void> loadCommentsForPost(String postId) async {
    state = state.copyWith(isLoadingComments: true);

    try {
      final comments = await ref.read(feedServiceProvider).getCommentsForPost(postId);

      // Update comments in state
      final updatedComments = Map<String, List<Comment>>.from(state.postComments);
      updatedComments[postId] = comments;

      // Load user profiles for comments
      final userIds = comments.map((comment) => comment.userId).toSet().toList();
      final updatedUsers = await _loadUsersForIds(userIds);

      state = state.copyWith(
        postComments: updatedComments,
        postUsers: updatedUsers,
        isLoadingComments: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingComments: false,
        error: 'Failed to load comments: ${e.toString()}',
      );
    }
  }

  /// Add a comment to a post
  Future<bool> addComment({
    required String postId,
    required String userId,
    required String text,
  }) async {
    try {
      // Add the comment via service
      final comment = await ref.read(feedServiceProvider).addComment(
        postId: postId,
        userId: userId,
        text: text,
      );

      // Update comments in state
      final updatedComments = Map<String, List<Comment>>.from(state.postComments);
      if (updatedComments.containsKey(postId)) {
        updatedComments[postId] = [comment, ...updatedComments[postId]!];
      } else {
        updatedComments[postId] = [comment];
      }

      // Update post comment count
      final updatedPosts = List<Post>.from(state.posts);
      final postIndex = updatedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        updatedPosts[postIndex] = updatedPosts[postIndex].copyWith(
          comments: updatedPosts[postIndex].comments + 1,
        );
      }

      state = state.copyWith(
        postComments: updatedComments,
        posts: updatedPosts,
        error: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to add comment: ${e.toString()}');
      return false;
    }
  }

  /// Delete a comment
  Future<bool> deleteComment(String commentId, String postId) async {
    try {
      // Find the comment in the current state
      final comments = state.postComments[postId] ?? [];
      final commentIndex = comments.indexWhere((c) => c.commentId == commentId);

      if (commentIndex == -1) {
        state = state.copyWith(error: 'Comment not found');
        return false;
      }

      // Delete the comment via service
      final success = await ref.read(feedServiceProvider).deleteComment(commentId, postId);

      if (success) {
        // Update comments in state
        final updatedComments = Map<String, List<Comment>>.from(state.postComments);
        if (updatedComments.containsKey(postId)) {
          updatedComments[postId] = List<Comment>.from(updatedComments[postId]!)
            ..removeWhere((c) => c.commentId == commentId);
        }

        // Update post comment count
        final updatedPosts = List<Post>.from(state.posts);
        final postIndex = updatedPosts.indexWhere((post) => post.id == postId);
        if (postIndex != -1) {
          final currentCount = updatedPosts[postIndex].comments;
          updatedPosts[postIndex] = updatedPosts[postIndex].copyWith(
            comments: currentCount > 0 ? currentCount - 1 : 0,
          );
        }

        state = state.copyWith(
          postComments: updatedComments,
          posts: updatedPosts,
          error: null,
        );

        return true;
      } else {
        state = state.copyWith(error: 'Failed to delete comment');
        return false;
      }
    } catch (e) {
      state = state.copyWith(error: 'Error deleting comment: ${e.toString()}');
      return false;
    }
  }

  /// Load user profiles for a list of user IDs
  Future<Map<String, UserProfile>> _loadUsersForIds(List<String> userIds) async {
    final updatedUsers = Map<String, UserProfile>.from(state.postUsers);

    for (final userId in userIds) {
      if (!updatedUsers.containsKey(userId)) {
        try {
          final user = await ref.read(feedServiceProvider).getUserForPost(userId);
          updatedUsers[userId] = user;
        } catch (_) {
          // Skip this user if there's an error
        }
      }
    }

    return updatedUsers;
  }

  /// Toggle like status for a post
  Future<void> toggleLike(String postId) async {
    try {
      // Find the post in the current state
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) {
        state = state.copyWith(error: 'Post not found');
        return; // Post not found
      }

      final post = state.posts[postIndex];
      final isCurrentlyLiked = post.isLiked;

      // Create a new list with the updated post
      final updatedPosts = List<Post>.from(state.posts);
      updatedPosts[postIndex] = post.copyWith(
        isLiked: !isCurrentlyLiked,
        likes: isCurrentlyLiked ? post.likes - 1 : post.likes + 1,
      );

      // Update state optimistically
      state = state.copyWith(posts: updatedPosts, error: null);

      try {
        // Call the API to update the like status
        await ref.read(feedServiceProvider).toggleLike(postId, !isCurrentlyLiked);
      } catch (apiError) {
        // If the API call fails, revert the optimistic update but keep the UI responsive
        final revertedPosts = List<Post>.from(state.posts);
        revertedPosts[postIndex] = post; // Revert to original post
        state = state.copyWith(
          posts: revertedPosts,
          error: 'Failed to update like status: ${apiError.toString()}',
        );
      }
    } catch (e) {
      // Handle any other errors
      state = state.copyWith(error: 'Error processing like action: ${e.toString()}');
    }
  }
}

/// State class for feed operations
class FeedState {
  final List<Post> posts;
  final Map<String, UserProfile> postUsers;
  final Map<String, List<Comment>> postComments;
  final String? activePostId;
  final bool isLoading;
  final bool isLoadingComments;
  final String? error;
  final int currentPage;
  final bool hasMorePages;

  const FeedState({
    required this.posts,
    required this.postUsers,
    required this.postComments,
    this.activePostId,
    required this.isLoading,
    required this.isLoadingComments,
    this.error,
    required this.currentPage,
    required this.hasMorePages,
  });

  /// Initial state
  factory FeedState.initial() {
    return const FeedState(
      posts: [],
      postUsers: {},
      postComments: {},
      activePostId: null,
      isLoading: false,
      isLoadingComments: false,
      currentPage: 1,
      hasMorePages: true,
    );
  }

  /// Creates a copy of this state with the given fields replaced with new values
  FeedState copyWith({
    List<Post>? posts,
    Map<String, UserProfile>? postUsers,
    Map<String, List<Comment>>? postComments,
    String? activePostId,
    bool? isLoading,
    bool? isLoadingComments,
    String? error,
    int? currentPage,
    bool? hasMorePages,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      postUsers: postUsers ?? this.postUsers,
      postComments: postComments ?? this.postComments,
      activePostId: activePostId ?? this.activePostId,
      isLoading: isLoading ?? this.isLoading,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }
}
