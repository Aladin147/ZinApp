// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenTransaction _$TokenTransactionFromJson(Map<String, dynamic> json) =>
    TokenTransaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TokenTransactionTypeEnumMap, json['type']),
      description: json['description'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      relatedEntityId: json['relatedEntityId'] as String?,
    );

Map<String, dynamic> _$TokenTransactionToJson(TokenTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'type': _$TokenTransactionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'relatedEntityId': instance.relatedEntityId,
    };

const _$TokenTransactionTypeEnumMap = {
  TokenTransactionType.earned: 'earned',
  TokenTransactionType.spent: 'spent',
  TokenTransactionType.received: 'received',
  TokenTransactionType.sent: 'sent',
  TokenTransactionType.system: 'system',
};
