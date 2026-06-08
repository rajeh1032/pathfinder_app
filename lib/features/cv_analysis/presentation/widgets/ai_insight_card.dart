import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cv_anaylsis_dummy_model.dart';

class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.tertiary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.sm.r),
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  size: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Text(
                'AI Insights',
                style: AppTextStyles.titleSmall(colorScheme.onSurface)
                    .copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            CvAnalysisDummyData.aiInsight,
            style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                .copyWith(fontSize: 13.sp, height: 1.5),
          ),
        ],
      ),
    );
  }
}
