import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_transaction.g.dart';

/// Types of token transactions
enum TokenTransactionType {
  @JsonValue('earned')
  earned,
  @JsonValue('spent')
  spent,
  @JsonValue('received')
  received,
  @JsonValue('sent')
  sent,
  @JsonValue('system')
  system,
}

/// Represents a token transaction in the ZinToken economy
@JsonSerializable()
class TokenTransaction extends Equatable {
  final String id;
  final String userId;
  final int amount;
  final TokenTransactionType type;
  final String? description;
  final DateTime timestamp;
  final String? relatedEntityId;

  const TokenTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.description,
    required this.timestamp,
    this.relatedEntityId,
  });

  /// Creates a TokenTransaction from JSON data
  factory TokenTransaction.fromJson(Map<String, dynamic> json) =>
      _$TokenTransactionFromJson(json);

  /// Converts TokenTransaction to JSON
  Map<String, dynamic> toJson() => _$TokenTransactionToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        type,
        description,
        timestamp,
        relatedEntityId,
      ];
}
