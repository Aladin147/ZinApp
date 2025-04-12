import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

/// Categories of achievements
enum AchievementCategory {
  @JsonValue('onboarding')
  onboarding,
  @JsonValue('social')
  social,
  @JsonValue('booking')
  booking,
  @JsonValue('style')
  style,
  @JsonValue('loyalty')
  loyalty,
  @JsonValue('milestone')
  milestone,
  @JsonValue('special')
  special,
}

/// Rarity levels for achievements
enum AchievementRarity {
  @JsonValue('common')
  common,
  @JsonValue('uncommon')
  uncommon,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary,
}

/// Represents an achievement that users can unlock
@JsonSerializable()
class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final int xpReward;
  final int tokenReward;
  final AchievementCategory category;
  final AchievementRarity rarity;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.xpReward,
    required this.tokenReward,
    required this.category,
    required this.rarity,
  });

  /// Creates an Achievement from JSON data
  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  /// Converts Achievement to JSON
  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        iconUrl,
        xpReward,
        tokenReward,
        category,
        rarity,
      ];
}
