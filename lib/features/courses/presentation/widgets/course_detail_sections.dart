import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/courses_state.dart';
import 'course_support_sections.dart';

class CourseAiReasonCard extends StatelessWidget {
  const CourseAiReasonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .35)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.auto_awesome, color: colors.tertiary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'courses.aiMatch'.tr(),
                    style: AppTextStyles.labelLarge(colors.tertiary),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'courses.aiReason'.tr(),
                    style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailTabs extends StatelessWidget {
  const CourseDetailTabs({
    required this.selectedTab,
    required this.onTabSelected,
    super.key,
  });

  final CourseDetailTab selectedTab;
  final ValueChanged<CourseDetailTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.lg,
      children: [
        _TabLabel(
          labelKey: 'courses.overview',
          selected: selectedTab == CourseDetailTab.overview,
          onTap: () => onTabSelected(CourseDetailTab.overview),
        ),
        _TabLabel(
          labelKey: 'courses.curriculum',
          selected: selectedTab == CourseDetailTab.curriculum,
          onTap: () => onTabSelected(CourseDetailTab.curriculum),
        ),
        _TabLabel(
          labelKey: 'courses.reviews',
          selected: selectedTab == CourseDetailTab.reviews,
          onTap: () => onTabSelected(CourseDetailTab.reviews),
        ),
      ],
    );
  }
}

class CourseOverviewSections extends StatelessWidget {
  const CourseOverviewSections({required this.selectedTab, super.key});

  final CourseDetailTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return switch (selectedTab) {
      CourseDetailTab.overview => const _OverviewTab(),
      CourseDetailTab.curriculum => const _BulletSection(
          titleKey: 'courses.curriculumTitle',
          itemKeys: [
            'courses.curriculumSetup',
            'courses.curriculumPatterns',
            'courses.curriculumTesting',
          ],
        ),
      CourseDetailTab.reviews => const _BulletSection(
          titleKey: 'courses.reviewsTitle',
          itemKeys: [
            'courses.reviewOne',
            'courses.reviewTwo',
            'courses.reviewThree',
          ],
        ),
    };
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TextSection(
          titleKey: 'courses.aboutTitle',
          bodyKey: 'courses.aboutBody',
        ),
        SizedBox(height: AppSpacing.xl),
        _BulletSection(
          titleKey: 'courses.learnTitle',
          itemKeys: [
            'courses.learnArchitecture',
            'courses.learnPerformance',
            'courses.learnHooks',
          ],
        ),
        SizedBox(height: AppSpacing.xl),
        CourseSkillsSection(),
        SizedBox(height: AppSpacing.xl),
        CourseRoadmapImpactCard(),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.labelKey,
    required this.selected,
    required this.onTap,
  });

  final String labelKey;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = selected ? colors.primary : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Text(labelKey.tr(), style: AppTextStyles.labelLarge(color)),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection({
    required this.titleKey,
    required this.bodyKey,
  });

  final String titleKey;
  final String bodyKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleKey.tr(), style: AppTextStyles.titleMedium(colors.onSurface)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          bodyKey.tr(),
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _BulletSection extends StatelessWidget {
  const _BulletSection({required this.titleKey, required this.itemKeys});

  final String titleKey;
  final List<String> itemKeys;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleKey.tr(), style: AppTextStyles.titleMedium(colors.onSurface)),
        const SizedBox(height: AppSpacing.sm),
        for (final item in itemKeys)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline,
                    size: 16, color: colors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    item.tr(),
                    style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
