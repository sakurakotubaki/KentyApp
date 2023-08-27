import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';
// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Cart with _$Cart {
  const factory Cart({
    @Default('') String name,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}