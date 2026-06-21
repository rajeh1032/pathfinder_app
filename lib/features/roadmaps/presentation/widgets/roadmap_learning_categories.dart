import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class RoadmapLearningCategories extends StatelessWidget {
  const RoadmapLearningCategories({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final categories = <(String, IconData)>[
      ('roadmaps.categoryDevelopment', Icons.developer_mode_rounded),
      ('roadmaps.categoryDesign', Icons.palette_outlined),
      ('roadmaps.categoryDataScience', Icons.analytics_outlined),
      ('roadmaps.categorySoftSkills', Icons.psychology_alt_outlined),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'roadmaps.categoriesTitle'.tr(),
          style: AppTextStyles.titleLarge(context.colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.65,
          ),
          itemBuilder: (_, index) {
            final category = categories[index];
            final (background, foreground) = switch (index) {
              0 => (context.colors.primaryContainer, context.colors.primary),
              1 => (context.colors.tertiaryContainer, context.colors.tertiary),
              2 => (
                  context.colors.secondaryContainer,
                  context.colors.secondary
                ),
              _ => (
                  context.colors.error.withValues(alpha: .12),
                  context.colors.error
                ),
            };
            return Card(
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.square(
                        dimension: 44,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Icon(
                            category.$2,
                            size: 24,
                            color: foreground,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        category.$1.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium(
                          context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
