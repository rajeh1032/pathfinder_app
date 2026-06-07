import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/roadmap.dart';
import 'roadmap_recommended_course_card.dart';

class RoadmapTimeline extends StatelessWidget {
  const RoadmapTimeline({
    required this.roadmap,
    required this.onStepTap,
    this.updatingStepId,
    super.key,
  });

  final Roadmap roadmap;
  final ValueChanged<String> onStepTap;
  final String? updatingStepId;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MarkersColumn(steps: roadmap.steps),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              children: [
                for (final step in roadmap.steps) ...[
                  _MilestoneSection(
                    step: step,
                    isUpdating: updatingStepId == step.id,
                    onTap: () => onStepTap(step.id),
                  ),
                  if (step != roadmap.steps.last)
                    const SizedBox(height: AppSpacing.xl),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkersColumn extends StatelessWidget {
  const _MarkersColumn({required this.steps});

  final List<RoadmapStep> steps;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        for (final step in steps) ...[
          _Marker(
            icon:
                step.status == RoadmapStepStatus.completed ? Icons.check : null,
            color: step.status == RoadmapStepStatus.upcoming
                ? colors.outlineVariant
                : colors.primary,
          ),
          if (step != steps.last)
            Expanded(child: VerticalDivider(color: colors.outlineVariant)),
        ],
      ],
    );
  }
}

class _MilestoneSection extends StatelessWidget {
  const _MilestoneSection({
    required this.step,
    required this.isUpdating,
    required this.onTap,
  });

  final RoadmapStep step;
  final bool isUpdating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Opacity(
      opacity: step.status == RoadmapStepStatus.upcoming ? .65 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(step.titleKey.tr(),
              style: AppTextStyles.titleLarge(colors.onSurface)),
          Text(
            _statusLabelKey(step.status).tr(),
            style: AppTextStyles.labelSmall(colors.primary),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (step.hasRecommendedCourse) ...[
            const RecommendedCourseCard(),
            const SizedBox(height: AppSpacing.md),
          ],
          _StepCard(
            step: step,
            isUpdating: isUpdating,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  String _statusLabelKey(RoadmapStepStatus status) {
    return switch (status) {
      RoadmapStepStatus.completed => 'roadmaps.statusCompleted',
      RoadmapStepStatus.inProgress => 'roadmaps.statusInProgress',
      RoadmapStepStatus.upcoming => 'roadmaps.statusUpcoming',
    };
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.isUpdating,
    required this.onTap,
  });

  final RoadmapStep step;
  final bool isUpdating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: isUpdating ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Icon(_leadingIcon, color: colors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.titleKey.tr(),
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    Text(
                      step.bodyKey.tr(),
                      style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (isUpdating)
                const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(_trailingIcon, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }

  IconData get _leadingIcon {
    return switch (step.status) {
      RoadmapStepStatus.completed => Icons.web_asset_outlined,
      RoadmapStepStatus.inProgress => Icons.speed_outlined,
      RoadmapStepStatus.upcoming => Icons.security_outlined,
    };
  }

  IconData get _trailingIcon {
    return switch (step.status) {
      RoadmapStepStatus.completed => Icons.check_circle_outline,
      RoadmapStepStatus.inProgress => Icons.play_circle_outline,
      RoadmapStepStatus.upcoming => Icons.lock_outline,
    };
  }
}

class _Marker extends StatelessWidget {
  const _Marker({required this.color, this.icon});

  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(
        dimension: 24,
        child: icon == null
            ? Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox.square(dimension: 8),
                ),
              )
            : Icon(icon, size: 12, color: colors.surface),
      ),
    );
  }
}
