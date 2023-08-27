import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/doc_generator/dio/dio_generator.dart';

class FetchData extends ConsumerWidget {
  const FetchData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final data = ref.watch(futureGeneratorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data'),
      ),
      body: data.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final post = data[index];
              return ListTile(
                title: Text(post.),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Center(
          child: Text(err.toString()),
        ),
      ),
    );
  }
}