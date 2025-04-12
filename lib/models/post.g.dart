// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  userId: json['userId'] as String,
  authorName: json['authorName'] as String,
  authorProfilePictureUrl: json['authorProfilePictureUrl'] as String?,
  text: json['text'] as String?,
  imageUrl: json['imageUrl'] as String?,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  location: json['location'] as String?,
  likes: (json['likes'] as num).toInt(),
  comments: (json['comments'] as num).toInt(),
  shares: (json['shares'] as num).toInt(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  isLiked: json['isLiked'] as bool? ?? false,
  type: json['type'] as String?,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'authorName': instance.authorName,
  'authorProfilePictureUrl': instance.authorProfilePictureUrl,
  'text': instance.text,
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
  'location': instance.location,
  'likes': instance.likes,
  'comments': instance.comments,
  'shares': instance.shares,
  'timestamp': instance.timestamp.toIso8601String(),
  'isLiked': instance.isLiked,
  'type': instance.type,
};
