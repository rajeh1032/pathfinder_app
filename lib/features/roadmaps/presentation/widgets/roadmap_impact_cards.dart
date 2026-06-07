import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class RoadmapImpactCards extends StatelessWidget {
  const RoadmapImpactCards({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(
          child: _ImpactCard(
            icon: Icons.trending_up,
            valueKey: 'roadmaps.salaryIncreaseValue',
            labelKey: 'roadmaps.salaryIncrease',
            backgroundColor: colors.secondaryContainer,
            foregroundColor: colors.secondary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _ImpactCard(
            icon: Icons.business_center_outlined,
            valueKey: 'roadmaps.matchingRolesValue',
            labelKey: 'roadmaps.matchingRoles',
            backgroundColor: colors.tertiaryContainer,
            foregroundColor: colors.tertiary,
          ),
        ),
      ],
    );
  }
}

class _ImpactCard extends StatelessWidget {
  const _ImpactCard({
    required this.icon,
    required this.valueKey,
    required this.labelKey,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final String valueKey;
  final String labelKey;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: foregroundColor),
            const SizedBox(height: AppSpacing.sm),
            Text(
              valueKey.tr(),
              style: AppTextStyles.titleMedium(foregroundColor),
            ),
            Text(labelKey.tr(),
                style: AppTextStyles.bodySmall(foregroundColor)),
          ],
        ),
      ),
    );
  }
}
