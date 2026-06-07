import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CourseSkillsSection extends StatelessWidget {
  const CourseSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const skills = [
      'courses.skillReactHooks',
      'courses.skillTypescript',
      'courses.skillPerformance',
      'courses.skillComponents',
      'courses.skillDesignPatterns',
    ];
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'courses.skillsTitle'.tr(),
          style: AppTextStyles.titleMedium(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          skills.map((skill) => skill.tr()).join('  |  '),
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class CourseRoadmapImpactCard extends StatelessWidget {
  const CourseRoadmapImpactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'courses.frontendDeveloper'.tr(),
                style: AppTextStyles.titleMedium(colors.onSurface),
              ),
            ),
            Text(
              'courses.impact'.tr(),
              style: AppTextStyles.labelLarge(colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
