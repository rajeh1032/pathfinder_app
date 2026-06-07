import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'interview_skill_bar.dart';

class InterviewSkillsGrid extends StatelessWidget {
  const InterviewSkillsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const skills = <({String titleKey, int percent, double value})>[
      (titleKey: 'interview.technicalKnowledge', percent: 90, value: 0.9),
      (titleKey: 'interview.problemSolving', percent: 85, value: 0.85),
      (titleKey: 'interview.communication', percent: 70, value: 0.7),
      (titleKey: 'interview.systemDesign', percent: 75, value: 0.75),
      (titleKey: 'interview.behavioral', percent: 65, value: 0.65),
    ];

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
        return InterviewSkillBar(
          title: skill.titleKey,
          percent: skill.percent,
          value: skill.value,
        );
      },
    );
  }
}
