import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.freezed.dart';
part 'post.g.dart';
// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Post with _$Post {
  const factory Post({
    @Default('') String title,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}