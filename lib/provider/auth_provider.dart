import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// FirebaseAuthのインスタンスを取得するためのProvider
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
// uidを取得するためのProvider
final uidProvider = Provider((ref) => ref.watch(authProvider).currentUser?.uid);
// ログイン状態を取得するためのProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});
