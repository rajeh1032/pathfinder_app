import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/cv_analysis_ui_models.dart';

class RecommendationsSection extends StatelessWidget {
  final List<CvRecommendation> recommendations;

  const RecommendationsSection({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (recommendations.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cvAnalysis.aiRecommendations'.tr(),
          style: AppTextStyles.titleSmall(colorScheme.onSurface)
              .copyWith(fontSize: 15.sp),
        ),
        SizedBox(height: AppSpacing.sm.h),
        ...recommendations.map(
              (rec) => Container(
            margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
            padding: EdgeInsets.all(AppSpacing.md.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg.r),
              border:
              Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: rec?.avatarColor.withValues(alpha: 0.15),
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
                      if (rec.subtitle.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          rec.subtitle,
                          style: AppTextStyles.bodySmall(
                            colorScheme.onSurfaceVariant,
                          ).copyWith(fontSize: 11.sp),
                        ),
                      ],
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