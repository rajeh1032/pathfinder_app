import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message ?? 'common.empty'.tr()));
  }
}
