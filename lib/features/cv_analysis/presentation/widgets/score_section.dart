import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ScoreSection extends StatelessWidget {
  final int score;
  final String analyzedRole;
  final String analyzedTime;

  const ScoreSection({
    super.key,
    required this.score,
    required this.analyzedRole,
    required this.analyzedTime,
  });

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
                  value: score / 100,
                  strokeWidth: 10,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).colorScheme.primary),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                children: [
                  Text(
                    '$score%',
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
          if (analyzedRole.isNotEmpty)
            Text(
              analyzedRole,
              style: AppTextStyles.titleMedium(colorScheme.onSurface)
                  .copyWith(fontSize: 18.sp),
            ),
          SizedBox(height: 4.h),
          Text(
            analyzedTime,
            style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                .copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
