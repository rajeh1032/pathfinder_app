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
    return Column(
      children: [
        for (final section in roadmap.sections) ...[
          _Section(
            section: section,
            updatingStepId: updatingStepId,
            onStepTap: onStepTap,
          ),
          if (section != roadmap.sections.last)
            const SizedBox(height: AppSpacing.xl),
        ],
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.section,
    required this.updatingStepId,
    required this.onStepTap,
  });

  final RoadmapSection section;
  final String? updatingStepId;
  final ValueChanged<String> onStepTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: AppTextStyles.titleLarge(colors.onSurface),
        ),
        Text(
          section.subtitle,
          style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final step in section.items) ...[
          _StepCard(
            step: step,
            isUpdating: updatingStepId == step.id,
            onTap: () => onStepTap(step.id),
          ),
          if (step != section.items.last)
            const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
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
    final locked = step.status == RoadmapStepStatus.upcoming;
    final actionKey = step.isCompleted
        ? 'roadmaps.reopenStep'
        : locked
            ? 'roadmaps.stepLocked'
            : 'roadmaps.markComplete';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(_icon(step.status), color: colors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.title,
                          style: AppTextStyles.titleSmall(colors.onSurface)),
                      Text(
                        step.description,
                        style:
                            AppTextStyles.bodySmall(colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                _Tag(label: _statusKey(step.status).tr()),
                _Tag(label: '${step.progress}%'),
                _Tag(label: step.duration),
                _Tag(label: step.level),
              ],
            ),
            if (step.recommendedCourses.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'roadmaps.recommendedCourses'.tr(),
                style: AppTextStyles.labelLarge(colors.onSurface),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final course in step.recommendedCourses) ...[
                RecommendedCourseCard(course: course),
                if (course != step.recommendedCourses.last)
                  const SizedBox(height: AppSpacing.sm),
              ],
            ],
            const SizedBox(height: AppSpacing.md),
            Semantics(
              button: true,
              label: 'roadmaps.stepActionSemantic'.tr(args: [
                actionKey.tr(),
                step.title,
              ]),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isUpdating ? null : onTap,
                  icon: isUpdating
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(locked ? Icons.lock_outline : Icons.check_circle),
                  label: Text(actionKey.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(RoadmapStepStatus status) => switch (status) {
        RoadmapStepStatus.completed => Icons.check,
        RoadmapStepStatus.inProgress => Icons.play_arrow,
        RoadmapStepStatus.upcoming => Icons.lock_outline,
      };

  String _statusKey(RoadmapStepStatus status) => switch (status) {
        RoadmapStepStatus.completed => 'roadmaps.statusCompleted',
        RoadmapStepStatus.inProgress => 'roadmaps.statusInProgress',
        RoadmapStepStatus.upcoming => 'roadmaps.statusUpcoming',
      };
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Text(label),
        ),
      );
}
