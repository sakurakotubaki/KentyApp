import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ReadPhoto extends StatelessWidget {
  const ReadPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read Photo')),
      // photoのコレクションを参照して、画像を表示。nullの時は、nullを表示
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('photo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final String url = documents[index].data()['url'];
              final String path = documents[index].data()['path'];
              return Row(
                children: [
                  Image.network(url),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      try {
                        // Firebase Storageから画像を削除
                        await FirebaseStorage.instance.ref(path).delete();

                        // Firestoreから画像のURLを削除
                        await FirebaseFirestore.instance
                            .collection('photo')
                            .doc(documents[index].id)
                            .delete();
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
