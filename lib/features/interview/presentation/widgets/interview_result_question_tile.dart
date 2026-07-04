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
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              _InfoChip(
                label:
                    '${'interview.scoreLabel'.tr()} ${question.score.round()}%',
                color: _scoreColor(colorScheme, question.score),
                icon: Icons.bar_chart_rounded,
              ),
              _InfoChip(
                label: InterviewResultLabels.questionStatusLabel(
                  question.questionStatus,
                ),
                color: _statusColor(colorScheme, question.questionStatus),
                icon: _statusIcon(question.questionStatus),
              ),
            ],
          ),
          if (question.options.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            for (var index = 0; index < question.options.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: _ResultOptionRow(
                  text: question.options[index],
                  isCorrect: index == question.correctOptionIndex,
                  isSelected: index == question.selectedOptionIndex,
                ),
              ),
          ],
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

Color _scoreColor(ColorScheme colorScheme, double score) {
  if (score >= 70) return colorScheme.secondary;
  if (score >= 40) return colorScheme.tertiary;
  return colorScheme.error;
}

Color _statusColor(ColorScheme colorScheme, String status) {
  switch (status) {
    case 'passed':
      return colorScheme.secondary;
    case 'needs_improvement':
      return colorScheme.tertiary;
    case 'skipped':
      return colorScheme.error;
    default:
      return colorScheme.outline;
  }
}

IconData _statusIcon(String status) {
  switch (status) {
    case 'passed':
      return Icons.check_circle_rounded;
    case 'needs_improvement':
      return Icons.trending_up_rounded;
    case 'skipped':
      return Icons.fast_forward_rounded;
    default:
      return Icons.help_outline_rounded;
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ResultOptionRow extends StatelessWidget {
  const _ResultOptionRow({
    required this.text,
    required this.isCorrect,
    required this.isSelected,
  });

  final String text;
  final bool isCorrect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWrongSelected = isSelected && !isCorrect;

    // Correct answers are always highlighted; a wrong user choice is flagged.
    final Color accent;
    final IconData? markerIcon;
    if (isCorrect) {
      accent = colorScheme.secondary;
      markerIcon = Icons.check_circle_rounded;
    } else if (isWrongSelected) {
      accent = colorScheme.error;
      markerIcon = Icons.cancel_rounded;
    } else {
      accent = colorScheme.outlineVariant;
      markerIcon = null;
    }

    final highlighted = isCorrect || isWrongSelected;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? accent.withValues(alpha: 0.08)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: highlighted
              ? accent.withValues(alpha: 0.5)
              : colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: highlighted ? accent : colorScheme.onSurface,
                    fontWeight:
                        highlighted ? FontWeight.w600 : FontWeight.w400,
                    height: 1.35,
                  ),
            ),
          ),
          if (markerIcon != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Icon(markerIcon, size: 20, color: accent),
          ],
        ],
      ),
    );
  }
}
