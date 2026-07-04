import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/roadmap.dart';

class RoadmapImpactCards extends StatelessWidget {
  const RoadmapImpactCards({required this.insights, super.key});

  final RoadmapInsights insights;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern(context.locale.languageCode);
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        if (insights.projectedSalaryIncrease > 0)
          _ImpactCard(
            icon: Icons.trending_up,
            value: 'roadmaps.percentageValue'.tr(
              args: [formatter.format(insights.projectedSalaryIncrease)],
            ),
            label: 'roadmaps.salaryIncrease'.tr(),
          ),
        if (insights.matchingSeniorRoles > 0)
          _ImpactCard(
            icon: Icons.business_center_outlined,
            value: formatter.format(insights.matchingSeniorRoles),
            label: 'roadmaps.matchingRoles'.tr(),
          ),
      ],
    );
  }
}

class _ImpactCard extends StatelessWidget {
  const _ImpactCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 150,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: colors.primary),
              const SizedBox(height: AppSpacing.sm),
              Text(value, style: AppTextStyles.titleMedium(colors.primary)),
              Text(
                label,
                style: AppTextStyles.bodySmall(colors.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
