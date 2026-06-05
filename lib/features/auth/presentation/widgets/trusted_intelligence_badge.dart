import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';

class TrustedIntelligenceBadge extends StatelessWidget {
  const TrustedIntelligenceBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withAlpha(26),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(26),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              color: colorScheme.secondary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'auth.turstedTitle'.tr(),
                  style: AppTextStyles.labelLarge(colorScheme.onSurface),
                ),
                SizedBox(height: 4.h),
                Text(
                  'auth.trusted'.tr(),
                  style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
