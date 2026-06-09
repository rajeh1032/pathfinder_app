import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cv_anaylsis_dummy_model.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Recommendations',
          style: AppTextStyles.titleSmall(colorScheme.onSurface)
              .copyWith(fontSize: 15.sp),
        ),
        SizedBox(height: AppSpacing.sm.h),
        ...CvAnalysisDummyData.recommendations.map(
              (rec) => Container(
            margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
            padding: EdgeInsets.all(AppSpacing.md.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg.r),
              border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: rec.avatarColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.md.r),
                  ),
                  child: Center(
                    child: Text(
                      rec.avatarLabel,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: rec.avatarColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.title,
                        style: AppTextStyles.titleSmall(colorScheme.onSurface)
                            .copyWith(fontSize: 13.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        rec.subtitle,
                        style: AppTextStyles.bodySmall(
                            colorScheme.onSurfaceVariant)
                            .copyWith(fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
