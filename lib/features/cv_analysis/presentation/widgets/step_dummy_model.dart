import 'package:flutter/cupertino.dart';

enum StepStatus { done, loading, pending }

class LoadingStep {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  StepStatus status;

  LoadingStep({
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.status,
  });
}
