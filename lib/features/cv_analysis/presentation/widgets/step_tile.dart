import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/features/cv_analysis/presentation/widgets/step_dummy_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class StepTile extends StatelessWidget {
  final LoadingStep step;

  const StepTile({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDone = step.status == StepStatus.done;
    final isLoading = step.status == StepStatus.loading;
    final isPending = step.status == StepStatus.pending;

    final Color iconBg = isDone
        ? AppColors.success.withOpacity(0.12)
        : isLoading
        ? AppColors.primary.withOpacity(0.12)
        : colorScheme.surfaceContainerHighest;

    final Color iconColor = isDone
        ? AppColors.success
        : isLoading
        ? AppColors.primary
        : colorScheme.onSurfaceVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: isLoading
            ? AppColors.primary.withOpacity(0.05)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(
          color: isLoading
              ? AppColors.primary.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(AppRadius.md.r),
            ),
            child: isDone
                ? Icon(Icons.check_rounded, size: 20.sp, color: AppColors.success)
                : isLoading
                ? Padding(
              padding: EdgeInsets.all(10.w),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                const AlwaysStoppedAnimation(AppColors.primary),
              ),
            )
                : Icon(step.icon, size: 20.sp, color: iconColor),
          ),
          SizedBox(width: AppSpacing.sm.w),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.titleKey.tr(),
                  style: AppTextStyles.titleSmall(
                    isPending
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onSurface,
                  ).copyWith(fontSize: 13.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  step.subtitleKey.tr(),
                  style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                      .copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ),
          // Status indicator
          if (isDone)
            Icon(Icons.check_circle_rounded,
                size: 18.sp, color: AppColors.success)
          else if (isPending)
            Icon(Icons.circle_outlined,
                size: 18.sp, color: colorScheme.outline),
        ],
      ),
    );
  }
}
