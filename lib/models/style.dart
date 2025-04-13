import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';

/// Represents a hairstyle in the application
@JsonSerializable()
class Style extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final int likes;
  final int saves;
  final List<String>? relatedStyles;
  final String? createdBy;
  final DateTime createdAt;

  const Style({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.tags,
    required this.likes,
    required this.saves,
    this.relatedStyles,
    this.createdBy,
    required this.createdAt,
  });

  /// Creates a Style from JSON data
  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  /// Converts Style to JSON
  Map<String, dynamic> toJson() => _$StyleToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        category,
        tags,
        likes,
        saves,
        relatedStyles,
        createdBy,
        createdAt,
      ];
}
