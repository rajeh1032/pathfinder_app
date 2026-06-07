import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class AiMentorHeader extends StatelessWidget {
  const AiMentorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.md.h,
        horizontal: AppSpacing.md.w,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.psychology_rounded,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'AI Career Mentor',
            style: AppTextStyles.titleSmall(colorScheme.onSurface)
                .copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Career Help, Instantly. Ask anything, grow faster.',
            style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                .copyWith(fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
