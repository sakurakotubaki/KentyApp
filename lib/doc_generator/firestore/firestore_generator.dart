import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenty_app/doc_generator/firestore/model/cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_generator.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
@riverpod
// 今回は、Cartクラスを型に使うのでジェネリクスに指定する。
// .mapまで、書くとListView.builderで使えるようになる。
Stream<List<Cart>> cart(CartRef ref) {
  final store = FirebaseFirestore.instance;
  final collection = store.collection('cart').snapshots();
  return collection
      .map((event) => event.docs.map((e) => Cart.fromJson(e.data())).toList());
}
