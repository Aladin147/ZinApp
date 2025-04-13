import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

/// Represents a badge definition.
@JsonSerializable()
class Badge extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl;

  const Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
  });

  /// Creates a Badge from JSON data.
  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  /// Converts Badge to JSON.
  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  @override
  List<Object?> get props => [id, title, description, iconUrl];

  /// Creates a copy of this Badge with the given fields replaced.
  Badge copyWith({
    String? id,
    String? title,
    String? description,
    String? iconUrl,
  }) {
    return Badge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }
}
