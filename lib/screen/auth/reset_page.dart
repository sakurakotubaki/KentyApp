import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/provider/auth_provider.dart';
import 'package:kenty_app/state/controller.dart';

// この画面は、パスワードをリセットする画面です。
class ResetPage extends ConsumerWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(emailControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワードをリセット'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              const Icon(Icons.lock_reset, size: 200.0, color: Colors.grey),
              const SizedBox(height: 20),
              Container(
                width: 300,
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: "メールアドレスを入力"),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref
                          .read(authServiceProvider)
                          .resetPassword(password.text);
                    } catch (e) {
                      _showErrorSnackbar(context, e.toString());
                    }
                  },
                  child: const Text(
                    'パスワードをリセット',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // スナックバーを表示するメソッド
  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
