import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'jobs.details.overview'.tr(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w900,
              ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: 72.w,
          height: 3.h,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(AppRadius.pill.r),
          ),
        ),
      ],
    );
  }
}
