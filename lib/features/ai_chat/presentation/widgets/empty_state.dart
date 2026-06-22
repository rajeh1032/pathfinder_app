import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 60.sp,
              color: cs.onSurface.withValues(alpha: 0.18),
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'chatHistory.empty'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                cs.onSurface.withValues(alpha: 0.4),
              ).copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
