import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class SelectedRoleCard extends StatelessWidget {
  const SelectedRoleCard({
    super.key,
    this.title,
    this.company,
    this.location,
    this.onChangeRole,
  });

  final String? title;
  final String? company;
  final String? location;
  final VoidCallback? onChangeRole;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final roleTitle =
        title?.trim().isNotEmpty == true ? title!.trim() : 'Selected job';
    final companyLocation = [
      if (company?.trim().isNotEmpty == true) company!.trim(),
      if (location?.trim().isNotEmpty == true) location!.trim(),
    ].join(' - ');

    return SurfaceCard(
      padding: EdgeInsets.all(AppSpacing.md.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
            ),
            child: Icon(
              Icons.business_center_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 20.sp,
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roleTitle,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  companyLocation.isNotEmpty ? companyLocation : 'No company',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.xs.w),
          IconButton(
            onPressed: onChangeRole,
            constraints: BoxConstraints.tight(Size(36.w, 36.h)),
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.edit_outlined,
              color: colorScheme.onSurfaceVariant,
              size: 19.sp,
            ),
          ),
        ],
      ),
    );
  }
}
