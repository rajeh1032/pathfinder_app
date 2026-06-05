import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app_gradient_back_button.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.titleKey, super.key});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text(titleKey.tr()),
      ),
      body: Center(child: Text(titleKey.tr())),
    );
  }
}
