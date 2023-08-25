import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/domain/todo.dart';
import 'package:kenty_app/extention/push.dart';
import 'package:kenty_app/provider/firestore_provider.dart';
import 'package:kenty_app/screen/document_page.dart';
import 'package:kenty_app/screen/read_page.dart.dart';
import 'package:kenty_app/state/controller.dart';

class CreatePage extends ConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = ref.watch(bodyControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.to(const ReadPage());
              },
              icon: const Icon(Icons.read_more)),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {
                context.to(const DocumentPage());
              },
              icon: const Icon(Icons.ramen_dining_sharp)),
        ],
        title: const Text('Create'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: body,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          var todo = Todo(body: body.text);
                          await ref
                              .read(todoRepositoryProvider)
                              .createTodo(todo);
                          body.clear();// 入力後にテキストフィールドをクリア
                        } catch (e) {
                          throw e.toString();
                        }
                      },
                      child: const Text('追加'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
