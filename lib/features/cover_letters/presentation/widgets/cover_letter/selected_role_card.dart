import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class SelectedRoleCard extends StatelessWidget {
  const SelectedRoleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.all(AppSpacing.md.w),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
            ),
            child: Icon(
              Icons.business_center_outlined,
              color: AppColors.primaryDark,
              size: 20.sp,
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'coverLetter.selectedRole.title'.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.neutral900,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'coverLetter.selectedRole.companyLocation'.tr(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.neutral600,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              color: AppColors.neutral700,
              size: 19.sp,
            ),
          ),
        ],
      ),
    );
  }
}
