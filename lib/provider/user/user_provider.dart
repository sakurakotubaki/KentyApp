import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/provider/auth_provider.dart';
import 'package:kenty_app/provider/firestore_provider.dart';

final userFutureProvider = FutureProvider<DocumentSnapshot?>((ref) async {
  try {
    final uid = ref.read(uidProvider); // ref.watch() から ref.read() へ変更
    final snapshot = await ref.read(fireStoreProvider).collection('user').doc(uid).get();

    if (!snapshot.exists) { // ドキュメントが存在しない場合はnullを返す
      return null;
    }

    return snapshot;
  } catch (e) {
    // エラーが発生した場合は、プロバイダーのエラーを投げます。
    // FutureProviderはこのエラーを捉えて、.error部分で処理します。
    throw Exception("Failed to fetch user data: $e");
  }
});

