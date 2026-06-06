import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';

class AiMatchPill extends StatelessWidget {
  const AiMatchPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F6366F1),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: AppColors.primaryDark, size: 16.sp),
          SizedBox(width: 5.w),
          Text(
            'jobs.common.aiMatchPercent'.tr(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}
