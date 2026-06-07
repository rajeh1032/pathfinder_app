import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class RecommendedCourseCard extends StatelessWidget {
  const RecommendedCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final thumbnailSize = 62.4.w;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.courseDetails,
        arguments: const RouteArguments(id: 'react-patterns'),
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'roadmaps.aiRecommended'.tr(),
                      style: AppTextStyles.labelSmall(colors.primary),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: Image.asset(
                      AppAssets.roadmapCourseThumbnail,
                      width: thumbnailSize,
                      height: thumbnailSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Text(
                'roadmaps.headlessUi'.tr(),
                style: AppTextStyles.titleSmall(colors.onSurface),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  Chip(label: Text('roadmaps.shortCourseDuration'.tr())),
                  Chip(label: Text('roadmaps.advanced'.tr())),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primary, colors.tertiary],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Text(
                  'roadmaps.continueLearning'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelLarge(colors.surface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
