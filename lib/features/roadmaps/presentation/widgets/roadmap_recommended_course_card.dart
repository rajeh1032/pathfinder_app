import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../domain/entities/roadmap.dart';

class RecommendedCourseCard extends StatelessWidget {
  const RecommendedCourseCard({required this.course, super.key});
  final RoadmapCourse course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: 'roadmaps.courseSemantic'.tr(args: [course.title]),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.courseDetails,
          arguments: RouteArguments(id: course.id),
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: SizedBox.square(
                  dimension: 64,
                  child: course.thumbnailUrl == null
                      ? ColoredBox(
                          color: colors.primaryContainer,
                          child: Icon(Icons.school_outlined,
                              color: colors.primary),
                        )
                      : AppCachedImage(url: course.thumbnailUrl!),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.provider,
                      style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
                    ),
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    if (course.duration != null || course.level != null)
                      Text(
                        [course.duration, course.level]
                            .whereType<String>()
                            .join(' • '),
                        style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
