import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class ReviewInsightsCard extends StatelessWidget {
  const ReviewInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle('coverLetter.insights.title'.tr()),
          SizedBox(height: AppSpacing.sm.h),
          InsightItem(
            icon: Icons.check_circle_outline,
            text: 'coverLetter.insights.alignment'.tr(),
            color: AppColors.secondarySoft,
            iconColor: AppColors.secondaryDark,
          ),
          InsightItem(
            icon: Icons.check_circle_outline,
            text: 'coverLetter.insights.leadership'.tr(),
            color: AppColors.secondarySoft,
            iconColor: AppColors.secondaryDark,
          ),
          InsightItem(
            icon: Icons.warning_amber_rounded,
            text: 'coverLetter.insights.achievements'.tr(),
            color: const Color(0xFFFFE4E6),
            iconColor: AppColors.error,
          ),
          InsightItem(
            icon: Icons.info_outline,
            text: 'coverLetter.insights.reactNative'.tr(),
            color: AppColors.primarySoft,
            iconColor: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}

class InsightItem extends StatelessWidget {
  const InsightItem({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.iconColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15.sp, color: iconColor),
          SizedBox(width: 7.w),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.neutral700,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
