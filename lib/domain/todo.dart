import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';
// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default('') String id, // DocumentID をモデルに追加
    @Default('') String body,
  }) = _Todo;

  // Firestore DocumentSnapshot から Todo へのカスタムコンバーター
  factory Todo.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    final todo = _$TodoFromJson(data);
    return todo.copyWith(id: snapshot.id); // DocumentID をモデルにセット
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

// @freezed
// class Todo with _$Todo {
//   const factory Todo({
//     @Default('') String body,
//   }) = _Todo;

//   factory Todo.fromJson(Map<String, dynamic> json) =>
//       _$TodoFromJson(json);
// }