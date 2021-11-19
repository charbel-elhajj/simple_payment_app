// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    id: json['id'] as int,
    personFrom: json['person_from'] as String,
    personTo: json['person_to'] as String,
    amount: (json['amount'] as num).toDouble(),
    time: DateTime.parse(json['time'] as String),
    hash: json['hash'] as String,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) => <String, dynamic>{
      'id': instance.id,
      'person_from': instance.personFrom,
      'person_to': instance.personTo,
      'amount': instance.amount,
      'time': instance.time.toIso8601String(),
      'hash': instance.hash,
    };
