import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewProgressHeader extends StatelessWidget {
  const InterviewProgressHeader({
    required this.colorScheme,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
    super.key,
  });

  final ColorScheme colorScheme;
  final int currentQuestion;
  final int totalQuestions;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final safeTotal = totalQuestions <= 0 ? 1 : totalQuestions;
    final safeProgress = progress.clamp(0.0, 1.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'interview.questionProgress'.tr(
                namedArgs: {
                  'current': currentQuestion.toString(),
                  'total': safeTotal.toString(),
                },
              ),
              style: AppTextStyles.labelLarge(
                colorScheme.onSurfaceVariant,
              ).copyWith(letterSpacing: 1.2),
            ),
            Text('interview.completeProgress'.tr(
              namedArgs: {'value': (safeProgress * 100).round().toString()},
            )),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10.h,
            value: safeProgress,
            backgroundColor:
                colorScheme.primaryContainer.withValues(alpha: 0.35),
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
