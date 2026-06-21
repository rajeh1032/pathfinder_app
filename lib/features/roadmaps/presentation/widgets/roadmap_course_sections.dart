import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../domain/entities/roadmap.dart';
import 'roadmap_learning_categories.dart';

class RoadmapCourseSections extends StatelessWidget {
  const RoadmapCourseSections({
    required this.courses,
    required this.onViewAllCourses,
    super.key,
  });

  final List<RoadmapCourse> courses;
  final VoidCallback onViewAllCourses;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (courses.isNotEmpty)
            _CourseCarousel(courses: courses, onViewAll: onViewAllCourses),
          if (courses.isNotEmpty) const SizedBox(height: AppSpacing.xl),
          RoadmapLearningCategories(onPressed: onViewAllCourses),
        ],
      );
}

class _CourseCarousel extends StatelessWidget {
  const _CourseCarousel({required this.courses, required this.onViewAll});

  final List<RoadmapCourse> courses;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        (MediaQuery.sizeOf(context).width * .72).clamp(240.0, 300.0).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'roadmaps.topPicksTitle'.tr(),
                    style: AppTextStyles.titleLarge(context.colors.onSurface),
                  ),
                  Text(
                    'roadmaps.topPicksSubtitle'.tr(),
                    style: AppTextStyles.bodySmall(
                      context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: onViewAll,
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.chevron_right, size: 18),
              label: Text('roadmaps.viewAll'.tr()),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (_, index) => SizedBox(
              width: cardWidth,
              child: _CourseCard(course: courses[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final RoadmapCourse course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: 'roadmaps.courseSemantic'.tr(args: [course.title]),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.courseDetails,
            arguments: RouteArguments(id: course.id),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 132,
                width: double.infinity,
                child: course.thumbnailUrl == null
                    ? ColoredBox(
                        color: colors.primaryContainer,
                        child: Icon(
                          Icons.school_outlined,
                          size: 42,
                          color: colors.primary,
                        ),
                      )
                    : AppCachedImage(url: course.thumbnailUrl!),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.provider,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall(
                          colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleSmall(colors.onSurface),
                      ),
                      const Spacer(),
                      if (course.duration != null || course.level != null)
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 16,
                              color: colors.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                [course.duration, course.level]
                                    .whereType<String>()
                                    .join(' • '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmall(
                                  colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
