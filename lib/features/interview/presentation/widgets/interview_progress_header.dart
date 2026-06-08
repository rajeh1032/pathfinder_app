import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewProgressHeader extends StatelessWidget {
  const InterviewProgressHeader({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'interview.questionProgress'.tr(
                namedArgs: {'current': '3', 'total': '10'},
              ),
              style: AppTextStyles.labelLarge(
                colorScheme.onSurfaceVariant,
              ).copyWith(letterSpacing: 1.2),
            ),
            Text(
              'interview.completeProgress'.tr(namedArgs: {'value': '30'}),
              style: AppTextStyles.labelLarge(colorScheme.primary),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10.h,
            value: 0.3,
            backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.35),
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
