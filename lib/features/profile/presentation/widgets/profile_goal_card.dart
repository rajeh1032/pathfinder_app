import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';

class ProfileGoalCard extends StatelessWidget {
  const ProfileGoalCard({required this.goal, super.key});

  final ProfileGoal goal;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: .18),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.primary.withValues(alpha: .24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('profile.targetGoal').toUpperCase(),
                        style: AppTextStyles.labelSmall(colors.primary),
                      ),
                      Text(
                        context.tr(goal.titleKey),
                        style: AppTextStyles.titleLarge(colors.onSurface),
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      context.tr(goal.progressLabelKey),
                      style: AppTextStyles.labelMedium(colors.primary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final progressWidth = constraints.maxWidth * goal.progress;

                return Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
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
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(context.tr(goal.progressLabelKey),
                    style: AppTextStyles.labelMedium(colors.primary)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _SkillList(
                    icon: Icons.check_circle,
                    skillKeys: goal.completedSkillKeys,
                    color: colors.tertiary,
                  ),
                ),
                Expanded(
                  child: _SkillList(
                    icon: Icons.radio_button_unchecked,
                    skillKeys: goal.pendingSkillKeys,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillList extends StatelessWidget {
  const _SkillList({
    required this.icon,
    required this.skillKeys,
    required this.color,
  });

  final IconData icon;
  final List<String> skillKeys;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillKeys
          .map(
            (key) => Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      context.tr(key),
                      style: AppTextStyles.bodySmall(context.colors.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
