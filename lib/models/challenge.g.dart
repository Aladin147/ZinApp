// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  iconUrl: json['iconUrl'] as String,
  xpReward: (json['xpReward'] as num).toInt(),
  tokenReward: (json['tokenReward'] as num).toInt(),
  category: json['category'] as String,
  type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
  goal: (json['goal'] as num).toInt(),
  repeatable: $enumDecode(_$ChallengeRepeatableEnumMap, json['repeatable']),
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'iconUrl': instance.iconUrl,
  'xpReward': instance.xpReward,
  'tokenReward': instance.tokenReward,
  'category': instance.category,
  'type': _$ChallengeTypeEnumMap[instance.type]!,
  'goal': instance.goal,
  'repeatable': _$ChallengeRepeatableEnumMap[instance.repeatable]!,
  'isActive': instance.isActive,
};

const _$ChallengeTypeEnumMap = {
  ChallengeType.counter: 'counter',
  ChallengeType.boolean: 'boolean',
  ChallengeType.timeBased: 'time_based',
};

const _$ChallengeRepeatableEnumMap = {
  ChallengeRepeatable.none: 'none',
  ChallengeRepeatable.daily: 'daily',
  ChallengeRepeatable.weekly: 'weekly',
  ChallengeRepeatable.monthly: 'monthly',
};
