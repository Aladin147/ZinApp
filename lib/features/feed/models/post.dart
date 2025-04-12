import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

/// Represents a post in the social feed
@JsonSerializable()
class Post extends Equatable {
  final String id;
  final String userId;
  final String content;
  final List<String> imageUrls;
  final List<String> tags;
  final String? location;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.imageUrls,
    required this.tags,
    this.location,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.createdAt,
  });

  /// Creates a Post from JSON data
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Converts Post to JSON
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        imageUrls,
        tags,
        location,
        likesCount,
        commentsCount,
        sharesCount,
        createdAt,
      ];
}
