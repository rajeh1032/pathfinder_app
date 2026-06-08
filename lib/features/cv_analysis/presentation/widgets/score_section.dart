import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cv_anaylsis_dummy_model.dart';

class ScoreSection extends StatelessWidget {
  const ScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120.w,
                height: 120.w,
                child: CircularProgressIndicator(
                  value: CvAnalysisDummyData.score / 100,
                  strokeWidth: 10,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                children: [
                  Text(
                    '${CvAnalysisDummyData.score}%',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Match Score',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Text(
            CvAnalysisDummyData.analyzedRole,
            style: AppTextStyles.titleMedium(colorScheme.onSurface)
                .copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            CvAnalysisDummyData.analyzedTime,
            style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                .copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
