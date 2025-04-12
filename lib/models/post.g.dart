// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  userId: json['userId'] as String,
  content: json['content'] as String,
  imageUrls:
      (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  location: json['location'] as String?,
  likesCount: (json['likesCount'] as num).toInt(),
  commentsCount: (json['commentsCount'] as num).toInt(),
  sharesCount: (json['sharesCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'content': instance.content,
  'imageUrls': instance.imageUrls,
  'tags': instance.tags,
  'location': instance.location,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'sharesCount': instance.sharesCount,
  'createdAt': instance.createdAt.toIso8601String(),
};
