import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class AiInsightsCard extends StatelessWidget {
  final String insight;

  const AiInsightsCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.08),
            colorScheme.tertiary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.sm.r),
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  size: 16.sp,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Text(
                'cvAnalysis.aiInsights'.tr(),
                style: AppTextStyles.titleSmall(colorScheme.onSurface)
                    .copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            insight,
            style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                .copyWith(fontSize: 13.sp, height: 1.5),
          ),
        ],
      ),
    );
  }
}
