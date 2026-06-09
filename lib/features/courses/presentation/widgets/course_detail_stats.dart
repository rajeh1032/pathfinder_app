import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/course.dart';

class CourseDetailStats extends StatelessWidget {
  const CourseDetailStats({required this.course, super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        const _StatItem(icon: Icons.star, labelKey: 'courses.ratingSummary'),
        _StatItem(
          icon: Icons.groups_outlined,
          labelKey: course.studentsKey,
        ),
        _StatItem(icon: Icons.schedule_outlined, labelKey: course.durationKey),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colors.primary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          labelKey.tr(),
          style: AppTextStyles.labelMedium(colors.onSurfaceVariant),
        ),
      ],
    );
  }
}
