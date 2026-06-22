import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import 'interview_result_labels.dart';

class InterviewResultTitleHeader extends StatelessWidget {
  const InterviewResultTitleHeader({
    required this.colorScheme,
    required this.title,
    required this.interviewType,
    this.durationMinutes,
    this.completedAt,
    super.key,
  });

  final ColorScheme colorScheme;
  final String title;
  final String interviewType;
  final int? durationMinutes;
  final String? completedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                _metaLabel(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSpacing.md.w),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Text(
            InterviewResultLabels.roundLabel(interviewType),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }

  String _metaLabel() {
    final minutes = durationMinutes ?? 0;
    final date = _formattedDate();
    if (date == null) {
      return 'interview.minutesCount'.tr(namedArgs: {'minutes': '$minutes'});
    }
    return 'interview.resultMeta'.tr(
      namedArgs: {'minutes': '$minutes', 'date': date},
    );
  }

  String? _formattedDate() {
    if (completedAt == null || completedAt!.isEmpty) return null;
    final parsed = DateTime.tryParse(completedAt!);
    if (parsed == null) return null;
    return DateFormatter.format(parsed.toLocal());
  }
}
