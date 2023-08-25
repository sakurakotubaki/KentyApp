import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'users.freezed.dart';
part 'users.g.dart';
// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Users with _$Users {
  const factory Users({
    @Default('') String name,
  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}