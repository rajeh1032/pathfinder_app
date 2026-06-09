import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class RoadmapsProgress extends StatelessWidget {
  const RoadmapsProgress({super.key});

  static const _progressValue = .64;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.roadmapDetails,
        arguments: const RouteArguments(id: 'react-mastery'),
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'roadmaps.currentTitle'.tr(),
                    style: AppTextStyles.titleSmall(colors.onSurface),
                  ),
                ),
                Text(
                  'roadmaps.currentProgress'.tr(),
                  style: AppTextStyles.labelSmall(
                    colors.primary.withValues(alpha: .95),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            LayoutBuilder(
              builder: (context, constraints) {
                final progressWidth = constraints.maxWidth * _progressValue;

                return Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer.withValues(alpha: .9),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: progressWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colors.primary, colors.tertiary],
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
