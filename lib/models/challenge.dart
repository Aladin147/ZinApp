import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

/// Enum representing the type of challenge condition.
enum ChallengeType {
  @JsonValue('counter')
  counter, // e.g., like 5 posts
  @JsonValue('boolean')
  boolean, // e.g., leave a comment (yes/no)
  @JsonValue('time_based')
  timeBased, // e.g., log in for 3 consecutive days
}

/// Enum representing how often a challenge can be repeated.
enum ChallengeRepeatable {
  @JsonValue('none')
  none,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
}

/// Represents a challenge definition.
@JsonSerializable()
class Challenge extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl; // Assuming icon is represented by a URL
  final int xpReward;
  final int tokenReward;
  final String category;
  final ChallengeType type;
  final int goal; // Target value (e.g., 5 for counter, 1 for boolean)
  final ChallengeRepeatable repeatable;
  final bool isActive;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.xpReward,
    required this.tokenReward,
    required this.category,
    required this.type,
    required this.goal,
    required this.repeatable,
    required this.isActive,
  });

  /// Creates a Challenge from JSON data.
  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  /// Converts Challenge to JSON.
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        iconUrl,
        xpReward,
        tokenReward,
        category,
        type,
        goal,
        repeatable,
        isActive,
      ];

  /// Creates a copy of this Challenge with the given fields replaced.
  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    String? iconUrl,
    int? xpReward,
    int? tokenReward,
    String? category,
    ChallengeType? type,
    int? goal,
    ChallengeRepeatable? repeatable,
    bool? isActive,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      xpReward: xpReward ?? this.xpReward,
      tokenReward: tokenReward ?? this.tokenReward,
      category: category ?? this.category,
      type: type ?? this.type,
      goal: goal ?? this.goal,
      repeatable: repeatable ?? this.repeatable,
      isActive: isActive ?? this.isActive,
    );
  }
}
