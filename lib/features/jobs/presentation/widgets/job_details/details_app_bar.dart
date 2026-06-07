import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
          ),
          Expanded(
            child: Text(
              'jobs.details.title'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.share_outlined, color: AppColors.primaryDark),
          ),
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.bookmark_border, color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}
