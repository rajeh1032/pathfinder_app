import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

class CoverHeader extends StatelessWidget {
  const CoverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tightFor(width: 32.w, height: 32.h),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.primaryDark,
                size: 18.sp,
              ),
            ),
            Text(
              'app.name'.tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          'coverLetter.title'.tr(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.neutral900,
                fontWeight: FontWeight.w900,
                height: .95,
              ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          'coverLetter.subtitle'.tr(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral600,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
