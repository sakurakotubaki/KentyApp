import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/domain/users/users.dart';
import 'package:kenty_app/provider/auth_provider.dart';
import 'package:kenty_app/provider/firestore_provider.dart';

base class UserBase {
  Ref ref;
  UserBase(this.ref);// refはUserRepositoryのref
}

base class UserRepository extends UserBase {
  UserRepository(super.ref);//super.refはUserBaseのref

  // userコレクションに.setでデータを追加する
  Future<void> createUser(Users users) async {
    try {
      final uid = ref.watch(uidProvider);
      await ref
          .read(fireStoreProvider)
          .collection('user')
          .doc(uid)
          .set(users.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  // userコレクションのデータを.getで取得する
  Future<DocumentSnapshot> readUser() async {
    try {
      final uid = ref.watch(uidProvider);
      return await ref
          .read(fireStoreProvider)
          .collection('user')
          .doc(uid)
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  // userコレクションのデータを.updateで更新する
  Future<void> updateUser(Users users) async {
    try {
      final uid = ref.watch(uidProvider);
      await ref
          .read(fireStoreProvider)
          .collection('user')
          .doc(uid)
          .update(users.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  // userコレクションのデータを.deleteで削除する
  Future<void> deleteUser() async {
    try {
      final uid = ref.watch(uidProvider);
      await ref
          .read(fireStoreProvider)
          .collection('user')
          .doc(uid)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
  
}
