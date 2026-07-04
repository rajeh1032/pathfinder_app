import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobTitleBlock extends StatelessWidget {
  const JobTitleBlock({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    this.certificateProvider,
    this.duration,
  });

  final String title;
  final String company;
  final String location;
  final String? certificateProvider;
  final String? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w900,
              ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.verified_outlined,
                size: 16.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            SizedBox(width: 5.w),
            Text(
              certificateProvider ?? '$company • $location',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md.h),
        Row(
          children: [
            JobMetric(icon: Icons.business_outlined, label: company),
            SizedBox(width: AppSpacing.lg.w),
            JobMetric(icon: Icons.schedule, label: duration ?? 'Flexible'),
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
        Icon(icon,
            size: 15.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
        SizedBox(width: 5.w),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
