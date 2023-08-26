import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/domain/users/users.dart';
import 'package:kenty_app/provider/user/user_base.dart';
import 'package:kenty_app/provider/user/user_provider.dart';
import 'package:kenty_app/state/controller.dart';
// ユーザー情報を更新する画面
class UpdateUser extends ConsumerWidget {
  const UpdateUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー情報を更新'),
      ),
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: '名前を入力',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var users = Users(name: name.text);
                  await ref.read(userRepositoryProvider).updateUser(users);
                  // ignore: unused_result
                  ref.refresh(userFutureProvider);
                },
                child: const Text(
                  '名前を変更',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}