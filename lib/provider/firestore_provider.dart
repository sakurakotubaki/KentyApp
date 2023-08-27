import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/domain/todo/todo.dart';
import 'package:kenty_app/interface/todo.dart';
import 'package:kenty_app/provider/auth_provider.dart';

final fireStoreProvider = Provider((ref) => FirebaseFirestore.instance);

// final todoStreamProvider = StreamProvider<List<Todo>>((ref) {
//   final store = ref.watch(fireStoreProvider).collection('todo').snapshots();
//   return store
//       .map((event) => event.docs.map((e) => Todo.fromJson(e.data())).toList());
// });

// 全てのドキュメントを取得する場合は、StreamProvider使用する
// .autoDispose()を使用すると、ウィジェットが破棄されたときにストリームを自動的にキャンセルする
final todoSnapshot = StreamProvider.autoDispose((ref) {
  final store = ref.watch(fireStoreProvider).collection('todo').snapshots();
  return store;
});
// 全てのドキュメントをいちどだけ取得する場合は、FutureProvider使用する
// .autoDispose()を使用すると、ウィジェットが破棄されたときにFutureを自動的にキャンセルする
final todoFutureProvider = FutureProvider.autoDispose((ref) async {
  final store = ref.read(fireStoreProvider).collection('todo').get();
  return store;
});

final todoRepositoryProvider = Provider((ref) => TodoRepostitory(ref));

class TodoRepostitory implements TodoBase {
  Ref ref;
  TodoRepostitory(this.ref);

  @override
  Future<void> createTodo(Todo todo) async {
    try {
      final uid = ref.watch(uidProvider);
      await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(uid)
          .set(todo.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<DocumentSnapshot> readTodo() async {
    try {
      final uid = ref.watch(uidProvider);
      return await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(uid)
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateTodo(Todo todo, id) async {
    try {
      await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(id)
          .update(todo.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteTodo(id) async {
    try {
      await ref.read(fireStoreProvider).collection('todo').doc(id).delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
