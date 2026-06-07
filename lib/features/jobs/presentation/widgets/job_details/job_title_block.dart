import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobTitleBlock extends StatelessWidget {
  const JobTitleBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'jobs.common.seniorUxDesigner'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.neutral900,
                fontWeight: FontWeight.w900,
              ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.verified_outlined,
                size: 16.sp, color: AppColors.neutral600),
            SizedBox(width: 5.w),
            Text(
              'jobs.details.certificate'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral600,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md.h),
        Row(
          children: [
            const JobMetric(icon: Icons.groups_outlined, label: '12k+'),
            SizedBox(width: AppSpacing.lg.w),
            const JobMetric(icon: Icons.schedule, label: '12h'),
          ],
        ),
      ],
    );
  }
}

class JobMetric extends StatelessWidget {
  const JobMetric({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: AppColors.neutral600),
        SizedBox(width: 5.w),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.neutral600,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
