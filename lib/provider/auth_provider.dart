import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/interface/auth.dart';
// FirebaseAuthのインスタンスを取得するためのProvider
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
// uidを取得するためのProvider
final uidProvider = Provider((ref) => ref.watch(authProvider).currentUser?.uid);
// ログイン状態を取得するためのProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});

final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref: ref));

// AuthInterfaceを実装したクラス
class AuthService implements AuthInterface {
Ref ref;
  AuthService({required this.ref});

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result =
          await ref.read(authProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }
  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await ref.read(authProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // パスワードのリセット
  @override
  Future<void> resetPassword(String email) async {
    try {
      await ref.read(authProvider).sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // ログアウト
  @override
  Future<void> signOut() async {
    await ref.read(authProvider).signOut();
  }
  
  // エラーメッセージを日本語化
  String _handleError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'メールアドレスが無効。';
      case 'user-disabled':
        return 'このアカウントは無効になっています。';
      case 'user-not-found':
        return 'アカウントが見つかりません。';
      case 'wrong-password':
        return 'パスワードが一致しません。';
      default:
        return 'エラーが発生しました。';
    }
  }
}