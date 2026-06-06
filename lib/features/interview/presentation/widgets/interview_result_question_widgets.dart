import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InterviewResultQuestionTile extends StatelessWidget {
  const InterviewResultQuestionTile({
    required this.titleKey,
    this.titleArgs,
    this.score,
    this.statusKey,
    this.feedbackKey,
    this.suggestionKey,
    this.expanded = false,
    super.key,
  });

  final String titleKey;
  final Map<String, String>? titleArgs;
  final String? score;
  final String? statusKey;
  final String? feedbackKey;
  final String? suggestionKey;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
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
          titleKey.tr(namedArgs: titleArgs),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          if (score != null || statusKey != null)
            Row(
              children: [
                Text(
                  '${'interview.scoreLabel'.tr()} ${score ?? ''}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(width: 12),
                if (statusKey != null)
                  Text(
                    '${'interview.statusLabel'.tr()} ${statusKey!.tr()}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
          if (feedbackKey != null) ...[
            const SizedBox(height: 10),
            Text(
              '${'interview.aiFeedbackLabel'.tr()} ${feedbackKey!.tr()}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
            ),
          ],
          if (suggestionKey != null) ...[
            const SizedBox(height: 10),
            Text(
              '${'interview.suggestedLabel'.tr()} ${suggestionKey!.tr()}',
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
