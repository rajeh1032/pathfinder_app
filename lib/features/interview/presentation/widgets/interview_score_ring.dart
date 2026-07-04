import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class InterviewScoreRing extends StatelessWidget {
  const InterviewScoreRing({
    required this.score,
    this.previousScore,
    this.improvement,
    super.key,
  });

  final int score;
  final int? previousScore;
  final int? improvement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasPrevious = previousScore != null;
    final change = improvement ?? (hasPrevious ? score - previousScore! : 0);
    final isPositive = change >= 0;

    return SizedBox(
      width: 220.w,
      height: 220.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: 180.w,
            child: CircularProgressIndicator(
              value: (score.clamp(0, 100)) / 100,
              strokeWidth: 12,
              backgroundColor: colorScheme.primaryContainer,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score%',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              if (hasPrevious) ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive
                            ? colorScheme.secondaryContainer
                            : colorScheme.errorContainer)
                        .withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isPositive
                            ? 'interview.improvementLabel'
                                .tr(namedArgs: {'value': '$change'})
                            : 'interview.declineLabel'
                                .tr(namedArgs: {'value': '$change'}),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: isPositive
                                      ? colorScheme.secondary
                                      : colorScheme.error,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      Text(
                        'interview.previousScoreLabel'.tr(
                          namedArgs: {'value': '$previousScore'},
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
