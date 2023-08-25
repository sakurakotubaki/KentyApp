import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/domain/todo.dart';
import 'package:kenty_app/provider/firestore_provider.dart';
import 'package:kenty_app/state/controller.dart';

class ReadPage extends ConsumerWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snap = ref.watch(todoSnapshot);
    final body = ref.watch(bodyControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Read'),
      ),
      body: snap.when(
        data: (todo) {
          return ListView.builder(
            itemCount: todo.docs.length,// Firestoreのドキュメント数を取得
            itemBuilder: (context, index) {
              final data = todo.docs[index].data();// Firestoreのデータを取得
              return ListTile(
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            // 編集用のダイアログを表示
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('編集'),
                                    actions: [
                                      TextFormField(
                                        controller: body,
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            var updateTodo =
                                                Todo(body: body.text);
                                            final id = todo.docs[index]
                                                .id; // snapshotの中からドキュメントIDを取得
                                            await ref
                                                .read(fireStoreProvider)
                                                .collection('todo')
                                                .doc(id)
                                                .update(updateTodo
                                                    .toJson()); // FirestoreのドキュメントIDを取得して更新
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                            body.clear();
                                          },
                                          child: const Text('更新')),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.edit)),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () async {
                            final id = todo.docs[index].id;
                            await ref
                                .read(fireStoreProvider)
                                .collection('todo')
                                .doc(id)
                                .delete(); // FirestoreのドキュメントIDを取得して削除
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
                title: Text(data['body']),// Firestoreのフィールド名bodyと合わせる
              );
            },
          );
        },
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
