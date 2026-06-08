import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewPersonalizationBulletItem extends StatelessWidget {
  const InterviewPersonalizationBulletItem(this.titleKey, {super.key});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 6, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              titleKey.tr(),
              style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                  .copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
