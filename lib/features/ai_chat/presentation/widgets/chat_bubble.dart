import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isFromUser;

  const ChatBubble(
      {super.key, required this.message, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSpacing.xs.h),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.sm.h,
        ),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        decoration: BoxDecoration(
          color: isFromUser
              ? cs.primary
              : cs.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.md.r),
            topRight: Radius.circular(AppRadius.md.r),
            bottomLeft: Radius.circular(isFromUser ? AppRadius.md.r : 4.r),
            bottomRight: Radius.circular(isFromUser ? 4.r : AppRadius.md.r),
          ),
        ),
        child: Text(
          message,
          style: AppTextStyles.bodyMedium(
            isFromUser ? cs.onPrimary : cs.onSurface,
          ),
        ),
      ),
    );
  }
}
