import 'package:dio/dio.dart';
import 'package:kenty_app/doc_generator/dio/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'dio_generator.g.dart';

@riverpod
Future<List<Post>> futureGenerator(FetchRef, ref) async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
  if (response.statusCode == 200) {
    final data = response.data as List;
    final posts = data.map((e) => Post.fromJson(e)).toList();
    return posts;
  }
  return [];
}
