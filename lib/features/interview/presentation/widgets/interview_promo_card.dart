import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewPromoCard extends StatelessWidget {
  const InterviewPromoCard({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        gradient: AppGradients.aiTertiary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.28),
            blurRadius: 28.r,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 82.w,
              height: 82.w,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_rounded,
                color: colorScheme.onPrimary.withValues(alpha: 0.26),
                size: 42.sp,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'interview.refineYourPitchTitle'.tr(),
                style: AppTextStyles.headlineSmall(colorScheme.onPrimary),
              ),
              SizedBox(height: AppSpacing.sm.h),
              SizedBox(
                width: 240.w,
                child: Text(
                  'interview.refineYourPitchDescription'.tr(),
                  style: AppTextStyles.bodyMedium(
                    colorScheme.onPrimary.withValues(alpha: 0.9),
                  ).copyWith(height: 1.55),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
