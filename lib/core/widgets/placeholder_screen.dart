import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.titleKey, super.key});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleKey.tr())),
      body: Center(child: Text(titleKey.tr())),
    );
  }
}
