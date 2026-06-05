// lib/features/home/presentation/notifications/widgets/notification_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../screens/dummy_data_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  // Icon + color per type
  ({IconData icon, Color color}) get _typeStyle {
    switch (notification.type) {
      case NotificationType.jobMatch:
        return (icon: Icons.work_outline, color: AppColors.primary);
      case NotificationType.upcoming:
        return (icon: Icons.calendar_today_outlined, color: AppColors.secondary);
      case NotificationType.aiInsight:
        return (icon: Icons.psychology_outlined, color: AppColors.tertiary);
      case NotificationType.learningProgress:
        return (icon: Icons.school_outlined, color: AppColors.warning);
    }
  }

  // Top label per type
  String get _typeLabel {
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
    final style = _typeStyle;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: style.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(style.icon, size: 20.sp, color: style.color),
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type label + time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _typeLabel,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: style.color,
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
                // Title
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                // Body
                Text(
                  notification.body,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                // Progress bar (learning type)
                if (notification.progress != null) ...[
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999.r),
                    child: LinearProgressIndicator(
                      value: notification.progress,
                      minHeight: 6.h,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(style.color),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${((notification.progress ?? 0) * 100).toInt()}% Complete',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: style.color,
                    ),
                  ),
                ],
                // Action label
                if (notification.actionLabel != null) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      notification.actionLabel!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: style.color,
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