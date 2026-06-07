import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isUser = message.isFromUser;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 28.w,
              height: 28.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.tertiary],
                ),
              ),
              child: Icon(Icons.psychology_rounded,
                  size: 14.sp, color: Colors.white),
            ),
            SizedBox(width: 8.w),
          ],
          // Bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: AppSpacing.sm.h,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg.r),
                  topRight: Radius.circular(AppRadius.lg.r),
                  bottomLeft: isUser
                      ? Radius.circular(AppRadius.lg.r)
                      : Radius.circular(AppRadius.sm.r),
                  bottomRight: isUser
                      ? Radius.circular(AppRadius.sm.r)
                      : Radius.circular(AppRadius.lg.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.bodyMedium(
                      isUser ? Colors.white : colorScheme.onSurface,
                    ).copyWith(fontSize: 13.sp, height: 1.5),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isUser
                          ? Colors.white.withOpacity(0.7)
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.w),
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.2),
              ),
              child: Icon(Icons.person_rounded,
                  size: 16.sp, color: AppColors.secondary),
            ),
          ],
        ],
      ),
    );
  }
}
