import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/extention/push.dart';
import 'package:kenty_app/provider/auth_provider.dart';
import 'package:kenty_app/screen/auth/reset_page.dart';
import 'package:kenty_app/screen/auth/sign_up_page.dart';
import 'package:kenty_app/screen/auth/user_page.dart';
import 'package:kenty_app/state/controller.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final email = ref.watch(emailControllerProvider);
    final password = ref.watch(passwordControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3), // 画面の高さの1/3
              SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'メールアドレスを入力',
                    border: OutlineInputBorder(),
                  ),
                  controller: email,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'パスワードを入力',
                    border: OutlineInputBorder(),
                  ),
                  controller: password,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(60),
                ),
                onPressed: () async {
                  try {
                    await authService.signIn(email.text, password.text);
                    if (context.mounted) {
                      context.toAndRemoveUntil(const UserPage());
                    }
                  } catch (e) {
                    _showErrorSnackbar(context, e.toString());
                  }
                },
                child: const Text('ログイン'),
              ),
              const SizedBox(height: 16),
              TextButton(
                  onPressed: () {
                    context.to(const SignUpScreen());
                  },
                  child: const Text('新規追加')),
              const SizedBox(height: 5),
              TextButton(
                  onPressed: () {
                    context.to(const ResetPage());
                  },
                  child: const Text('パスワードを忘れた')),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
