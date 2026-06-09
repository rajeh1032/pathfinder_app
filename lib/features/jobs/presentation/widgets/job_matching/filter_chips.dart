import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobFilterChips extends StatelessWidget {
  const JobFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          JobFilterChip(
            label: 'jobs.matching.filters'.tr(),
            icon: Icons.tune,
            isSelected: true,
          ),
          JobFilterChip(label: 'jobs.matching.remote'.tr()),
          const JobFilterChip(label: r'$120K+'),
          JobFilterChip(label: 'jobs.matching.design'.tr()),
        ],
      ),
    );
  }
}

class JobFilterChip extends StatelessWidget {
  const JobFilterChip({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor =
        isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;
    final backgroundColor = _pillTint(
      context,
      foregroundColor,
      alpha: isSelected ? .16 : .07,
    );

    return Container(
      margin: EdgeInsetsDirectional.only(end: AppSpacing.sm.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(
          color: foregroundColor.withValues(alpha: isSelected ? .48 : .28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: foregroundColor, size: 15.sp),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
          ),
        ],
      ),
    );
  }
}

Color _pillTint(BuildContext context, Color tint, {required double alpha}) {
  return Color.alphaBlend(
    tint.withValues(alpha: alpha),
    Theme.of(context).colorScheme.surface,
  );
}
