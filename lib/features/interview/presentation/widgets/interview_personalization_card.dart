import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'interview_personalization_bullet_item.dart';

class InterviewPersonalizationCard extends StatelessWidget {
  const InterviewPersonalizationCard({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.psychology_alt_rounded,
                color: colorScheme.onPrimary,
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'interview.aiPersonalizationActive'.tr(),
            style: AppTextStyles.titleLarge(colorScheme.primary),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'interview.aiPersonalizationDescription'.tr(),
            style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                .copyWith(height: 1.55),
          ),
          SizedBox(height: AppSpacing.sm.h),
          const InterviewPersonalizationBulletItem(
            'interview.personalizationBulletOne',
          ),
          const InterviewPersonalizationBulletItem(
            'interview.personalizationBulletTwo',
          ),
          const InterviewPersonalizationBulletItem(
            'interview.personalizationBulletThree',
          ),
        ],
      ),
    );
  }
}
