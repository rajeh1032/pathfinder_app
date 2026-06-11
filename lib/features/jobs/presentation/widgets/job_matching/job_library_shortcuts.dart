import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobLibraryShortcuts extends StatelessWidget {
  const JobLibraryShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ShortcutPill(
            icon: Icons.bookmark_border,
            labelKey: 'routes.savedJobs',
            routeName: AppRoutes.savedJobs,
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: _ShortcutPill(
            icon: Icons.history,
            labelKey: 'routes.appliedJobs',
            routeName: AppRoutes.appliedJobs,
          ),
        ),
      ],
    );
  }
}

class _ShortcutPill extends StatelessWidget {
  const _ShortcutPill({
    required this.icon,
    required this.labelKey,
    required this.routeName,
  });

  final IconData icon;
  final String labelKey;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(routeName),
      borderRadius: BorderRadius.circular(AppRadius.pill.r),
      child: Container(
        height: 42.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            colors.primary.withValues(alpha: .10),
            colors.surface,
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill.r),
          border: Border.all(color: colors.primary.withValues(alpha: .34)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors.primary, size: 18.sp),
            SizedBox(width: AppSpacing.xs.w),
            Flexible(
              child: Text(
                labelKey.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
