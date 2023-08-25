import 'package:flutter/material.dart';

/// [extensionで画面遷移のWidgetを作成する関数を作成]
extension BuildContextE on BuildContext {
  Future<void> to(Widget view) async {
    await Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) {
          return view;
        },
      ),
    );
  }
}

/// [pushAndRemoveUntilで画面遷移をする関数を作成]
extension BuildContextE2 on BuildContext {
  Future<void> toAndRemoveUntil(Widget view) async {
    await Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return view;
        },
      ),
      (route) => false,
    );
  }
}