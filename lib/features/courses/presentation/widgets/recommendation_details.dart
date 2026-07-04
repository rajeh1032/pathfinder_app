import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/course_recommendation.dart';

class RecommendationDetails extends StatelessWidget {
  const RecommendationDetails({required this.recommendation, super.key});

  final CourseRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final number = NumberFormat.decimalPattern(context.locale.toString());
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.md,
            children: [
              Text(
                'courses.recommendationScore'.tr(
                  args: [number.format(recommendation.score)],
                ),
              ),
              Text(
                'courses.coverage'.tr(
                  args: [number.format(recommendation.coveragePercentage)],
                ),
              ),
            ],
          ),
          if (recommendation.matchReasons.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            for (final reason in recommendation.matchReasons)
              Text(
                _reason(context, reason),
                style: AppTextStyles.bodySmall(context.colors.onSurfaceVariant),
              ),
          ],
        ],
      ),
    );
  }

  String _reason(BuildContext context, RecommendationReason reason) {
    final (key, parameter) = switch (reason.code) {
      RecommendationReasonCode.coversMissingSkill => (
          'courses.reasons.coversMissingSkill',
          reason.params['skill']
        ),
      RecommendationReasonCode.supportsRoadmapSkill => (
          'courses.reasons.supportsRoadmapSkill',
          reason.params['skill']
        ),
      RecommendationReasonCode.matchesTargetCareer => (
          'courses.reasons.matchesTargetCareer',
          reason.params['skill']
        ),
      RecommendationReasonCode.levelSuitable => (
          'courses.reasons.levelSuitable',
          reason.params['level']
        ),
      RecommendationReasonCode.freeCourse => (
          'courses.reasons.freeCourse',
          reason.params['provider']
        ),
    };
    return key.tr(args: [parameter ?? '']);
  }
}
