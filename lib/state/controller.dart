import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ログインなしの場合で使用するProvider
final bodyControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());
// userコレクション用のProvider
final nameControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());

// 認証用のProvider
final emailControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());
final passwordControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());
