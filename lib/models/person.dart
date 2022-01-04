import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(createFactory: true)
class Person {
  int id;
  String email;
  String password;

  Person({
    required this.id,
    required this.email,
    required this.password,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
