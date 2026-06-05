import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';

class RoadmapsTrending extends StatelessWidget {
  const RoadmapsTrending({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'roadmaps.trendingTitle'.tr(),
          style: AppTextStyles.titleLarge(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final course in _trendingCourses) ...[
          _TrendingCourseTile(course: course),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

const _trendingCourses = [
  RoadmapCourseRecommendation(
    id: 'product-management',
    titleKey: 'courses.productManagement',
    providerKey: 'courses.wharton',
    imageAsset: AppAssets.roadmapProductManagement,
    matchLabel: 'courses.beginner',
    ratingKey: 'courses.price49',
    durationKey: 'courses.duration4Weeks',
  ),
  RoadmapCourseRecommendation(
    id: 'machine-learning',
    titleKey: 'courses.machineLearning',
    providerKey: 'courses.stanford',
    imageAsset: AppAssets.roadmapMachineLearning,
    matchLabel: 'courses.advancedLevel',
    ratingKey: 'courses.price120',
    durationKey: 'courses.duration12Weeks',
  ),
  RoadmapCourseRecommendation(
    id: 'uiux-psychology',
    titleKey: 'courses.uiUxPsychology',
    providerKey: 'courses.interactionDesign',
    imageAsset: AppAssets.roadmapUiUxPsychology,
    matchLabel: 'courses.intermediate',
    ratingKey: 'courses.price34',
    durationKey: 'courses.duration6Weeks',
  ),
];

class _TrendingCourseTile extends StatelessWidget {
  const _TrendingCourseTile({required this.course});

  final RoadmapCourseRecommendation course;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final imageSize = 70.2.w;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.courseDetails,
        arguments: RouteArguments(id: course.id),
      ),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Card(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: colors.outlineVariant.withValues(alpha: .35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Image.asset(
                  course.imageAsset,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.matchLabel.tr(),
                      style: AppTextStyles.labelSmall(colors.primary),
                    ),
                    Text(
                      course.titleKey.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    Text(
                      course.providerKey.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelMedium(
                        colors.onSurfaceVariant,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          course.ratingKey.tr(),
                          style: AppTextStyles.titleMedium(colors.primary),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          course.durationKey.tr(),
                          style: AppTextStyles.labelSmall(
                            colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
