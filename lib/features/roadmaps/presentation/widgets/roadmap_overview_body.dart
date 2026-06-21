import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/roadmap.dart';
import 'roadmap_course_sections.dart';

class RoadmapOverviewBody extends StatelessWidget {
  const RoadmapOverviewBody({
    required this.roadmap,
    required this.onOpenDetails,
    required this.onViewAllCourses,
    super.key,
  });

  final Roadmap roadmap;
  final VoidCallback onOpenDetails;
  final VoidCallback onViewAllCourses;

  @override
  Widget build(BuildContext context) {
    final courses = _uniqueCourses(roadmap);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _Progress(roadmap: roadmap),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: onOpenDetails,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.chevron_right, size: 18),
            label: Text('roadmaps.openDetails'.tr()),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        RoadmapCourseSections(
          courses: courses,
          onViewAllCourses: onViewAllCourses,
        ),
        const SizedBox(height: AppSpacing.xl),
        CustomButton(
          labelKey: 'roadmaps.viewAllCourses',
          onPressed: onViewAllCourses,
          variant: CustomButtonVariant.outline,
          icon: Icons.school_outlined,
          height: 52,
        ),
      ],
    );
  }

  List<RoadmapCourse> _uniqueCourses(Roadmap roadmap) {
    final coursesById = <String, RoadmapCourse>{};
    for (final step in roadmap.steps) {
      for (final course in step.recommendedCourses) {
        coursesById.putIfAbsent(course.id, () => course);
      }
    }
    return coursesById.values.toList(growable: false);
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                roadmap.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleLarge(colors.onSurface),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'roadmaps.progressValue'.tr(args: ['${roadmap.progress}']),
              style: AppTextStyles.labelMedium(colors.primary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: roadmap.progress / 100,
          ),
        ),
      ],
    );
  }
}
