import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'interview_score_ring.dart';
import 'interview_skill_bar.dart';

class InterviewResultTitleHeader extends StatelessWidget {
  const InterviewResultTitleHeader({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'interview.seniorFrontendArchitect'.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'interview.resultMeta'.tr(
                  namedArgs: {'minutes': '45', 'date': 'June 12, 2024'},
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'interview.technicalRound'.tr(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class InterviewResultSummaryCard extends StatelessWidget {
  const InterviewResultSummaryCard({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(child: InterviewScoreRing(score: 82, previousScore: 74)),
    );
  }
}

class InterviewSkillsGrid extends StatelessWidget {
  const InterviewSkillsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 98,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const [
          _SkillBarItem(titleKey: 'interview.technicalKnowledge', percent: 90, value: 0.9),
          _SkillBarItem(titleKey: 'interview.problemSolving', percent: 85, value: 0.85),
          _SkillBarItem(titleKey: 'interview.communication', percent: 70, value: 0.7),
          _SkillBarItem(titleKey: 'interview.systemDesign', percent: 75, value: 0.75),
          _SkillBarItem(titleKey: 'interview.behavioral', percent: 65, value: 0.65),
        ][index];
      },
    );
  }
}

class _SkillBarItem extends StatelessWidget {
  const _SkillBarItem({
    required this.titleKey,
    required this.percent,
    required this.value,
  });

  final String titleKey;
  final int percent;
  final double value;

  @override
  Widget build(BuildContext context) {
    return InterviewSkillBar(
      title: titleKey.tr(),
      percent: percent,
      value: value,
    );
  }
}
