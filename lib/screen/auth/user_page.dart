import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/extention/push.dart';
import 'package:kenty_app/provider/auth_provider.dart';
import 'package:kenty_app/screen/auth/sign_in_page.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if(context.mounted) {
                context.toAndRemoveUntil(const SignInPage());
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text('ユーザー情報'),
      ),
    );
  }
}