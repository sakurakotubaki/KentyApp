# kenty_app
Firestore学習用のアプリ

## データを追加するときの方法
単一のドキュメントを作成または上書きするには、言語固有の次の set() メソッドを使用します。
```dart
Future<void> createTodo(Todo todo) async {
    try {
      final uid = ref.watch(uidProvider);
      await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(uid)
          .set(todo.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
```
ただし、ドキュメントに適切な ID を用意しておらず、Cloud Firestore によって ID が自動的に生成されたほうが都合のよい場合もあります。これを行うには、言語固有の次の add() メソッドを呼び出します。
```dart
Future<void> createTodo(Todo todo) async {
    try {
      await ref
          .read(fireStoreProvider)
          .collection('todo')
          .add(todo.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
```

## データを取得するとき
次の例は、get() を使用して単一のドキュメントの内容を取得する方法を示しています。
```dart
// メソッド書いた例。
Future<DocumentSnapshot> readTodo() async {
    try {
      final uid = ref.watch(uidProvider);
      return await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(uid)
          .get();
    } catch (e) {
      throw e.toString();
    }
  }
// プロバイダーで書いた例

// 全てのドキュメントをいちどだけ取得する場合は、FutureProvider使用する
// .autoDispose()を使用すると、ウィジェットが破棄されたときにFutureを自動的にキャンセルする
final todoFutureProvider = FutureProvider.autoDispose((ref) async {
  final store = ref.read(fireStoreProvider).collection('todo').get();
  return store;
});
```

## 全てのデータを取得する
データの変更を監視して、増えたり減ったりすると画面が切り替わるStreamを使うコードはこれ。
StreamBuilderを使った例
```dart
class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['full_name']),
                  subtitle: Text(data['company']),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
```

## Riverpodを使用した例
全てのデータを取得して、変更があるとすぐに、スナップショットが更新される
```dart
// 全てのドキュメントを取得する場合は、StreamProvider使用する
// .autoDispose()を使用すると、ウィジェットが破棄されたときにストリームを自動的にキャンセルする
final todoSnapshot = StreamProvider.autoDispose((ref) {
  final store = ref.watch(fireStoreProvider).collection('todo').snapshots();
  return store;
});
```

## データを更新するとき
ドキュメント全体を上書きすることなく一部のフィールドを更新するには、言語固有の次の update() メソッドを使用します。
```dart
Future<void> updateTodo(Todo todo, id) async {
    try {
      await ref
          .read(fireStoreProvider)
          .collection('todo')
          .doc(id)
          .update(todo.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
```

## データを削除するとき
ドキュメントを削除するには、次の言語固有の delete() メソッドを使用します。
```dart
Future<void> deleteTodo(id) async {
    try {
      await ref.read(fireStoreProvider).collection('todo').doc(id).delete();
    } catch (e) {
      throw e.toString();
    }
  }
```