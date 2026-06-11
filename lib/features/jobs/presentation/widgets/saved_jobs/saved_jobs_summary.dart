import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class SavedJobsSummary extends StatelessWidget {
  const SavedJobsSummary({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: .16),
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colors.primary.withValues(alpha: .28)),
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark, color: colors.primary, size: 28.sp),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Text(
              'jobs.saved.subtitle'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Text(
            '$count',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}
