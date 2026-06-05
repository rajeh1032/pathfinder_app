import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';

class RoadmapsTopPicks extends StatelessWidget {
  const RoadmapsTopPicks({
    required this.recommendations,
    required this.savedCourseIds,
    required this.onSaveTap,
    super.key,
  });

  final List<RoadmapCourseRecommendation> recommendations;
  final Set<String> savedCourseIds;
  final ValueChanged<String> onSaveTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'roadmaps.topPicksTitle'.tr(),
                    style: AppTextStyles.titleLarge(colors.onSurface),
                  ),
                  Text(
                    'roadmaps.topPicksSubtitle'.tr(),
                    style: AppTextStyles.bodySmall(
                      colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.courses),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('roadmaps.viewAll'.tr()),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = 280.8.w;
            final cardHeight = 280.h;

            return SizedBox(
              height: cardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recommendations.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  return _RecommendationCard(
                    item: recommendations[index],
                    isSaved: savedCourseIds.contains(recommendations[index].id),
                    onSaveTap: () => onSaveTap(recommendations[index].id),
                    width: cardWidth,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.item,
    required this.isSaved,
    required this.onSaveTap,
    required this.width,
  });

  final RoadmapCourseRecommendation item;
  final bool isSaved;
  final VoidCallback onSaveTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.courseDetails,
          arguments: RouteArguments(id: item.id),
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: BorderSide(
              color: colors.outlineVariant.withValues(alpha: .35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    item.imageAsset,
                    width: double.infinity,
                    height: width * .46,
                    fit: BoxFit.cover,
                  ),
                  PositionedDirectional(
                    top: AppSpacing.sm,
                    start: AppSpacing.sm,
                    child: _AiMatchPill(label: item.matchLabel.tr()),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.providerKey.tr(),
                      style: AppTextStyles.labelSmall(
                        colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      item.titleKey.tr(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: colors.primary),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          item.ratingKey.tr(),
                          style: AppTextStyles.labelSmall(
                            colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          item.durationKey.tr(),
                          style: AppTextStyles.labelSmall(
                            colors.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onSaveTap,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          child: CircleAvatar(
                            backgroundColor: colors.primaryContainer,
                            child: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: colors.primary,
                            ),
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

class _AiMatchPill extends StatelessWidget {
  const _AiMatchPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(Icons.auto_awesome, size: 13, color: colors.primary),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: AppTextStyles.labelSmall(colors.primary)),
          ],
        ),
      ),
    );
  }
}
