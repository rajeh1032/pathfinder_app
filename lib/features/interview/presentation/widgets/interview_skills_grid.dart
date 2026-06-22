import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/interview_skill_breakdown.dart';
import 'interview_skill_bar.dart';

class InterviewSkillsGrid extends StatelessWidget {
  const InterviewSkillsGrid({required this.skills, super.key});

  final List<InterviewSkillBreakdown> skills;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 98,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        final percent = skill.score.clamp(0, 100).round();
        return InterviewSkillBar(
          title: skill.skillName,
          percent: percent,
          value: skill.progress,
        );
      },
    );
  }
}
