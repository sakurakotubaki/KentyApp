import 'package:kenty_app/domain/todo/todo.dart';

abstract class TodoBase {
  Future<void> createTodo(Todo todo);
  Future<void> readTodo();
  Future<void> updateTodo(Todo todo, id);
  Future<void> deleteTodo(id);
}
