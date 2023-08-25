import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bodyControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());

final emailControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());
final passwordControllerProvider = StateProvider.autoDispose((ref) => TextEditingController());
