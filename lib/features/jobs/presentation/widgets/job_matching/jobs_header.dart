import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobsHeader extends StatelessWidget {
  const JobsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md.w,
        AppSpacing.md.h,
        AppSpacing.md.w,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'app.name'.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          Container(
            width: 44.w,
            height: 44.h,
            decoration: const BoxDecoration(
              color: AppColors.tertiarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications,
              color: AppColors.tertiary,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
