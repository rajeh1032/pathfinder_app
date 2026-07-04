import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/roadmap.dart';
import 'roadmap_course_sections.dart';
import 'roadmap_progress_header.dart';

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
        RoadmapProgressHeader(roadmap: roadmap),
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
