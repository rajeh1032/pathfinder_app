import 'package:flutter/material.dart';

class AppBottomSheet {
  const AppBottomSheet._();

  static Future<T?> show<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (_) => child,
    );
  }
}
