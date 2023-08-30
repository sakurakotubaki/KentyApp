import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenty_app/firebase_storage/read_photo.dart';
import 'package:path/path.dart';

class ImageUploader extends StatelessWidget {
  const ImageUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReadPhoto()),
              );
            },
            icon: const Icon(Icons.photo))
      ], title: const Text('Upload Photo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // ImagePickerで画像を選択
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);

              if (image == null) {
                return;
              }

              // 画像の解像度を落とす
              final img.Image? originalImage =
                  img.decodeImage(File(image.path).readAsBytesSync());
              final img.Image resizedImage =
                  img.copyResize(originalImage!, width: 300);

              // ここで画像形式を指定しない。img.Imageが適切に処理してくれる。
              // encodeBmpは、BMP形式でエンコードする。Bmpとは、ビットマップ画像のこと。
              // png, jpeg対応もあるようです。
              final List<int> resizedBytes = img.encodeBmp(resizedImage);
              final Uint8List resizedUint8List =
                  Uint8List.fromList(resizedBytes);

              // Firebase Storageへ画像をアップロード
              final storageRef = FirebaseStorage.instance.ref();
              final imageRef = storageRef.child('img/${basename(image.path)}');
              final uploadTask = imageRef.putData(
                resizedUint8List,
                SettableMetadata(
                  contentType: 'application/octet-stream', // 一般的なバイナリデータとして
                ),
              );

              final url = await (await uploadTask).ref.getDownloadURL();

              // Firestoreへ画像のURLを保存
              final data = {
                'url': url,
                'path': 'img/${basename(image.path)}'  // Storing the path as well
              };
              await FirebaseFirestore.instance.collection('photo').add(data);
            } catch (e) {
              print(e.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("An error occurred: ${e.toString()}"),
                ),
              );
            }
          },
          child: const Text('Upload'),
        ),
      ),
    );
  }
}
