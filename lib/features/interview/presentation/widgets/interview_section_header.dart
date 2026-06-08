import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InterviewSectionHeader extends StatelessWidget {
  const InterviewSectionHeader({
    required this.titleKey,
    this.actionKey,
    this.onActionTap,
    super.key,
  });

  final String titleKey;
  final String? actionKey;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            titleKey.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        if (actionKey != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(actionKey!.tr()),
          ),
      ],
    );
  }
}
