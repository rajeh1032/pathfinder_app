import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class AppliedJobsHeader extends StatelessWidget {
  const AppliedJobsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colors.secondary.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colors.secondary.withValues(alpha: .30)),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: colors.secondary, size: 28.sp),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Text(
              'jobs.applied.subtitle'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
