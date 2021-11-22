import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(createFactory: true)
class Transaction {
  int id;
  @JsonKey(name: 'person_from')
  String personFrom;
  @JsonKey(name: 'person_to')
  String personTo;
  double amount;
  @JsonKey(toJson: _dateTimeToString, fromJson: _stringTodateTime)
  DateTime time;
  String hash;

  Transaction({
    required this.id,
    required this.personFrom,
    required this.personTo,
    required this.amount,
    required this.time,
    required this.hash,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static String _dateTimeToString(DateTime date) => HttpDate.format(date);
  static DateTime _stringTodateTime(String stringDate) => HttpDate.parse(stringDate).toLocal();
}
