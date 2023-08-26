import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/extention/push.dart';
import 'package:kenty_app/provider/user/user_base.dart';
import 'package:kenty_app/provider/user/user_provider.dart';
import 'package:kenty_app/screen/auth/update_user.dart';
// ユーザー情報を表示する画面
class userInfo extends ConsumerWidget {
  const userInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userFutureProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.to(const UpdateUser());
              },
              icon: const Icon(Icons.edit))
        ],
        title: const Text('ユーザー情報'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('自己紹介', style: TextStyle(fontSize: 20)),
            users.when(
              data: (userSnapshot) {
                // ドキュメントがnullか、データがnullの場合の処理
                if (userSnapshot == null || userSnapshot.data() == null) {
                  return const Center(child: Text('ユーザー情報が存在しません。'));
                }

                final dataMap = userSnapshot.data() as Map<String, dynamic>;
                final name = dataMap['name'] as String;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
              error: (e, s) => Center(child: Text(e.toString())), // エラーメッセージを表示
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await ref.read(userRepositoryProvider).deleteUser();
                  // ignore: unused_result
                  ref.refresh(userFutureProvider);
                },
                child: const Text('ユーザを削除')),
          ],
        ),
      ),
    );
  }
}
