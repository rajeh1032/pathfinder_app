import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProTipCard extends StatelessWidget {
  const ProTipCard({super.key});

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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
            ),
            child: Icon(
              Icons.lightbulb_outline_rounded,
              size: 16.sp,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cvLoading.proTipTitle'.tr(),
                  style: AppTextStyles.titleSmall(colorScheme.onSurface)
                      .copyWith(fontSize: 12.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  'cvLoading.proTipBody'.tr(),
                  style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                      .copyWith(fontSize: 11.sp, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
