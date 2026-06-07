import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/roadmaps_cubit.dart';

class RoadmapsCategories extends StatelessWidget {
  const RoadmapsCategories({required this.selectedCategoryKey, super.key});

  final String? selectedCategoryKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final categories = [
      (Icons.code, 'roadmaps.categoryDevelopment'),
      (Icons.palette_outlined, 'roadmaps.categoryDesign'),
      (Icons.insights, 'roadmaps.categoryDataScience'),
      (Icons.psychology_outlined, 'roadmaps.categorySoftSkills'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'roadmaps.categoriesTitle'.tr(),
          style: AppTextStyles.titleLarge(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = 390.w;
            final columns = screenWidth >= 900
                ? 4
                : screenWidth >= 600
                    ? 3
                    : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: columns == 2 ? 1.75 : 1.45,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return _CategoryCard(
                  icon: category.$1,
                  label: category.$2.tr(),
                  selected: selectedCategoryKey == category.$2,
                  onTap: () => context.read<RoadmapsCubit>().selectCategory(
                        category.$2,
                      ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Card(
        color: selected
            ? colors.tertiaryContainer
            : colors.surfaceContainerHighest,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor:
                  selected ? colors.tertiary : colors.primaryContainer,
              child:
                  Icon(icon, color: selected ? colors.surface : colors.primary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(label, style: AppTextStyles.labelMedium(colors.onSurface)),
          ],
        ),
      ),
    );
  }
}
