import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/roadmap.dart';
import 'roadmap_impact_cards.dart';
import 'roadmap_timeline.dart';

class RoadmapDetailsBody extends StatelessWidget {
  const RoadmapDetailsBody({
    required this.roadmap,
    required this.onStepTap,
    required this.onCreateNew,
    required this.isCreating,
    this.updatingStepId,
    super.key,
  });

  final Roadmap roadmap;
  final ValueChanged<String> onStepTap;
  final VoidCallback onCreateNew;
  final bool isCreating;
  final String? updatingStepId;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        _Hero(roadmap: roadmap),
        const SizedBox(height: AppSpacing.xl),
        RoadmapTimeline(
          roadmap: roadmap,
          updatingStepId: updatingStepId,
          onStepTap: onStepTap,
        ),
        if (roadmap.insights.isMeaningful) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(
            'roadmaps.insightsTitle'.tr(),
            style: AppTextStyles.titleLarge(context.colors.onSurface),
          ),
          const SizedBox(height: AppSpacing.md),
          RoadmapImpactCards(insights: roadmap.insights),
        ],
        const SizedBox(height: AppSpacing.xl),
        CustomButton(
          labelKey: 'roadmaps.createNewRoadmap',
          onPressed: isCreating ? null : onCreateNew,
          isLoading: isCreating,
          variant: CustomButtonVariant.outline,
          icon: Icons.auto_awesome_outlined,
          height: 52,
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(label: Text(roadmap.label)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule_outlined,
                    size: 16, color: colors.onSurfaceVariant),
                const SizedBox(width: AppSpacing.xs),
                Text(roadmap.estimatedDuration),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          roadmap.title,
          style: AppTextStyles.headlineLarge(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          roadmap.description,
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'roadmaps.progressValue'.tr(args: ['${roadmap.progress}']),
          style: AppTextStyles.labelLarge(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: roadmap.progress / 100,
          ),
        ),
        if (roadmap.nextStep != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'roadmaps.nextStepValue'.tr(args: [roadmap.nextStep!]),
            style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}
