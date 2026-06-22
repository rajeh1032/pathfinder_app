import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../screens/dummy_data_model.dart';

class HomeNotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const HomeNotificationCard({super.key, required this.notification});

  Color _typeColor() {
    switch (notification.type) {
      case NotificationType.jobMatch:
        return AppColors.primary;
      case NotificationType.upcoming:
        return AppColors.secondary;
      case NotificationType.aiInsight:
        return AppColors.tertiary;
      case NotificationType.learningProgress:
        return AppColors.warning;
    }
  }

  IconData _typeIcon() {
    switch (notification.type) {
      case NotificationType.jobMatch:
        return Icons.work_outline;
      case NotificationType.upcoming:
        return Icons.calendar_today_outlined;
      case NotificationType.aiInsight:
        return Icons.psychology_outlined;
      case NotificationType.learningProgress:
        return Icons.school_outlined;
    }
  }

  String _typeLabel() {
    switch (notification.type) {
      case NotificationType.jobMatch:
        return 'JOB MATCH';
      case NotificationType.upcoming:
        return 'UPCOMING';
      case NotificationType.aiInsight:
        return 'AI CAREER INSIGHT';
      case NotificationType.learningProgress:
        return 'LEARNING PROGRESS';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _typeColor();

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md.r),
            ),
            child: Icon(_typeIcon(), size: 20.sp, color: color),
          ),
          SizedBox(width: AppSpacing.sm.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _typeLabel(),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.title,
                  style: AppTextStyles.titleSmall(colorScheme.onSurface)
                      .copyWith(fontSize: 13.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                      .copyWith(fontSize: 12.sp, height: 1.4),
                ),
                if (notification.progress != null) ...[
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999.r),
                    child: LinearProgressIndicator(
                      value: notification.progress,
                      minHeight: 6.h,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${((notification.progress ?? 0) * 100).toInt()}% Complete',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
                if (notification.actionLabel != null) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      notification.actionLabel!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
