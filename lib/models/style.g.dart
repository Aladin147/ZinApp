// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Style _$StyleFromJson(Map<String, dynamic> json) => Style(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
  category: json['category'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  likes: (json['likes'] as num).toInt(),
  saves: (json['saves'] as num).toInt(),
  relatedStyles:
      (json['relatedStyles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  createdBy: json['createdBy'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'category': instance.category,
  'tags': instance.tags,
  'likes': instance.likes,
  'saves': instance.saves,
  'relatedStyles': instance.relatedStyles,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt.toIso8601String(),
};
