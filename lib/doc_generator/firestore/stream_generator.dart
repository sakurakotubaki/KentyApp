import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenty_app/doc_generator/firestore/firestore_generator.dart';

class StreamGenerator extends ConsumerWidget {
  const StreamGenerator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamGenerator'),
      ),
      body: cart.when(
        data: (carts) {
          return ListView.builder(
            itemCount: carts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(carts[index].name),
              );
            },
          );
        },
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
