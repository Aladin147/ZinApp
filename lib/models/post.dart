import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

/// Represents a post in the social feed
@JsonSerializable()
class Post extends Equatable {
  final String id;
  final String userId;
  final String authorName;
  final String? authorProfilePictureUrl;
  final String? text;
  final String? imageUrl;
  final List<String> tags;
  final String? location;
  final int likes;
  final int comments;
  final int shares;
  final DateTime timestamp;
  final bool isLiked;
  final String? type;

  const Post({
    required this.id,
    required this.userId,
    required this.authorName,
    this.authorProfilePictureUrl,
    this.text,
    this.imageUrl,
    required this.tags,
    this.location,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.timestamp,
    this.isLiked = false,
    this.type,
  });

  /// Creates a Post from JSON data
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Converts Post to JSON
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        authorName,
        authorProfilePictureUrl,
        text,
        imageUrl,
        tags,
        location,
        likes,
        comments,
        shares,
        timestamp,
        isLiked,
        type,
      ];

  /// Create a copy of this post with the given fields replaced with the new values
  Post copyWith({
    String? id,
    String? userId,
    String? authorName,
    String? authorProfilePictureUrl,
    String? text,
    String? imageUrl,
    List<String>? tags,
    String? location,
    int? likes,
    int? comments,
    int? shares,
    DateTime? timestamp,
    bool? isLiked,
    String? type,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      authorName: authorName ?? this.authorName,
      authorProfilePictureUrl: authorProfilePictureUrl ?? this.authorProfilePictureUrl,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      type: type ?? this.type,
    );
  }
}
