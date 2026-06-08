import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobTags extends StatelessWidget {
  const JobTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm.w,
      runSpacing: AppSpacing.sm.h,
      children: [
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _pillTint(context, colorScheme.primary, alpha: .11),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: colorScheme.primary.withValues(alpha: .38)),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
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
