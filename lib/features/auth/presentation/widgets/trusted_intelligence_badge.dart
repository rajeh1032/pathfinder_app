import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TrustedIntelligenceBadge extends StatelessWidget {
  const TrustedIntelligenceBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: AppColors.secondaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              color: AppColors.secondaryDark,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trusted Intelligence',
                  style: AppTextStyles.labelLarge(AppColors.secondaryDark),
                ),
                SizedBox(height: 4.h),
                Text(
                  'PathFinder uses state-of-the-art encryption to protect your learning progress and personal data.',
                  style: AppTextStyles.bodySmall(AppColors.secondaryDark.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}