import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobInsightBox extends StatelessWidget {
  const JobInsightBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2FF),
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: AppColors.primaryContainer),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.psychology_outlined,
              color: AppColors.primaryDark, size: 24.sp),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Text(
              'jobs.matching.insight'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral700,
                    height: 1.42,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
