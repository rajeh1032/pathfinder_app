import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

enum AppliedJobAccent { primary, secondary }

class AppliedJobCard extends StatelessWidget {
  const AppliedJobCard({
    super.key,
    required this.statusKey,
    required this.dateKey,
    required this.accent,
  });

  final String statusKey;
  final String dateKey;
  final AppliedJobAccent accent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accentColor =
        accent == AppliedJobAccent.primary ? colors.primary : colors.secondary;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AppliedJobTitle(accentColor: accentColor),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              _StatusPill(labelKey: statusKey, color: accentColor),
              const Spacer(),
              Text(
                dateKey.tr(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          _NextStep(color: accentColor),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('common.actionReady'.tr())),
                    );
                  },
                  child: Text('jobs.applied.followUp'.tr()),
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterResult),
                  child: Text('jobs.applied.viewLetter'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppliedJobTitle extends StatelessWidget {
  const _AppliedJobTitle({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 46.w,
          height: 46.w,
          decoration: BoxDecoration(
            color: _pillTint(context, accentColor, alpha: .12),
            borderRadius: BorderRadius.circular(AppRadius.sm.r),
          ),
          child: Icon(Icons.task_alt, color: accentColor),
        ),
        SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'coverLetter.selectedRole.title'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                'coverLetter.selectedRole.companyLocation'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.labelKey, required this.color});

  final String labelKey;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _pillTint(context, color, alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: color.withValues(alpha: .38)),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class _NextStep extends StatelessWidget {
  const _NextStep({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.sm.w),
      decoration: BoxDecoration(
        color: _pillTint(context, color, alpha: .08),
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      child: Row(
        children: [
          Icon(Icons.event_available_outlined, color: color, size: 18.sp),
          SizedBox(width: AppSpacing.sm.w),
          Text(
            'jobs.applied.nextStep'.tr(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w800,
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
