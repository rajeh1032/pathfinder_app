import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

Future<bool> showSettingsConfirmationDialog({
  required BuildContext context,
  required String titleKey,
  required String messageKey,
  required String confirmKey,
  bool destructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final colors = Theme.of(dialogContext).colorScheme;

      return AlertDialog(
        title: Text(dialogContext.tr(titleKey)),
        content: Text(dialogContext.tr(messageKey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(dialogContext.tr('common.cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              dialogContext.tr(confirmKey),
              style:
                  destructive ? AppTextStyles.labelLarge(colors.error) : null,
            ),
          ),
        ],
      );
    },
  );

  return confirmed ?? false;
}
