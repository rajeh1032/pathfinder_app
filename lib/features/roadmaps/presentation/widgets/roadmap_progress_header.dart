import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/roadmap.dart';

/// Roadmap title + progress summary. Shared between the roadmaps overview
/// screen and the profile roadmap preview so both use the same UI.
class RoadmapProgressHeader extends StatelessWidget {
  const RoadmapProgressHeader({required this.roadmap, super.key});

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
