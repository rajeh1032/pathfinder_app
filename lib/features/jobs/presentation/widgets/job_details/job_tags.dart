import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobTags extends StatelessWidget {
  const JobTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm.w,
      runSpacing: AppSpacing.sm.h,
      children: const [
        JobTag(labelKey: 'jobs.details.webDevelopment'),
        JobTag(labelKey: 'jobs.details.advanced'),
      ],
    );
  }
}

class JobTag extends StatelessWidget {
  const JobTag({super.key, required this.labelKey});

  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.primarySoft.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: AppColors.primarySoft),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
