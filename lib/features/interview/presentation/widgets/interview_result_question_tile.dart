import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/interview_result_question.dart';
import 'interview_result_labels.dart';

class InterviewResultQuestionTile extends StatelessWidget {
  const InterviewResultQuestionTile({
    required this.question,
    this.expanded = false,
    super.key,
  });

  final InterviewResultQuestion question;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final feedback = question.feedback;
    final suggestion = question.aiSuggestion;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        title: Text(
          'interview.questionNumberTitle'.tr(
            namedArgs: {
              'number': '${question.order}',
              'question': question.question,
            },
          ),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        children: [
          Row(
            children: [
              Text(
                '${'interview.scoreLabel'.tr()} ${question.score.round()}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(width: 12),
              Text(
                '${'interview.statusLabel'.tr()} '
                '${InterviewResultLabels.questionStatusLabel(question.questionStatus)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          if (feedback != null && feedback.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${'interview.aiFeedbackLabel'.tr()} $feedback',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
            ),
          ],
          if (suggestion != null && suggestion.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${'interview.suggestedLabel'.tr()} $suggestion',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
