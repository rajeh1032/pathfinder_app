import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobTags extends StatelessWidget {
  const JobTags({
    super.key,
    required this.labels,
  });

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm.w,
      runSpacing: AppSpacing.sm.h,
      children: labels.map((label) => JobTag(label: label)).toList(),
    );
  }
}

class JobTag extends StatelessWidget {
  const JobTag({super.key, required this.label});

  final String label;

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
        label,
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
