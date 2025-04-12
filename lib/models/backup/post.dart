import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/models/comment.dart';

/// Represents a post in the ZinApp social feed
class Post {
  /// Unique identifier for the post
  final String postId;
  
  /// ID of the user who created the post (null if created by a stylist)
  final String? userId;
  
  /// ID of the stylist who created the post (null if created by a user)
  final String? stylistId;
  
  /// Type of post (check-in, showcase, etc.)
  final PostType type;
  
  /// URL to the post image
  final String imageUrl;
  
  /// Text caption for the post
  final String caption;
  
  /// Timestamp when the post was created
  final DateTime timestamp;
  
  /// List of user IDs who liked the post
  final List<String> likes;
  
  /// List of comments on the post
  final List<Comment> comments;
  
  /// ID of the related booking (if applicable)
  final String? relatedBookingId;
  
  /// ID of the tagged stylist (if applicable)
  final String? taggedStylistId;

  const Post({
    required this.postId,
    this.userId,
    this.stylistId,
    required this.type,
    required this.imageUrl,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.relatedBookingId,
    this.taggedStylistId,
  });

  /// Creates a Post from JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'] as String? ?? 'unknown_post',
      userId: json['userId'] as String?,
      stylistId: json['stylistId'] as String?,
      type: _parsePostType(json['type'] as String?),
      imageUrl: json['imageUrl'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      relatedBookingId: json['relatedBookingId'] as String?,
      taggedStylistId: json['taggedStylistId'] as String?,
    );
  }

  /// Converts the Post to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'stylistId': stylistId,
      'type': type.toString().split('.').last,
      'imageUrl': imageUrl,
      'caption': caption,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
      'relatedBookingId': relatedBookingId,
      'taggedStylistId': taggedStylistId,
    };
  }

  /// Returns a copy of this Post with the specified fields replaced
  Post copyWith({
    String? postId,
    String? userId,
    String? stylistId,
    PostType? type,
    String? imageUrl,
    String? caption,
    DateTime? timestamp,
    List<String>? likes,
    List<Comment>? comments,
    String? relatedBookingId,
    String? taggedStylistId,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      stylistId: stylistId ?? this.stylistId,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      relatedBookingId: relatedBookingId ?? this.relatedBookingId,
      taggedStylistId: taggedStylistId ?? this.taggedStylistId,
    );
  }

  /// Returns the number of likes on this post
  int get likeCount => likes.length;

  /// Returns the number of comments on this post
  int get commentCount => comments.length;

  /// Checks if a user has liked this post
  bool isLikedBy(String userId) => likes.contains(userId);

  /// Helper method to parse post type from string
  static PostType _parsePostType(String? typeStr) {
    if (typeStr == null) return PostType.general;
    
    switch (typeStr.toLowerCase()) {
      case 'check-in':
        return PostType.checkIn;
      case 'showcase':
        return PostType.showcase;
      default:
        return PostType.general;
    }
  }
}

/// Types of posts in the ZinApp social feed
enum PostType {
  /// General post with no specific context
  general,
  
  /// Post created when a user checks in with a stylist
  checkIn,
  
  /// Post showcasing a stylist's work
  showcase,
}
