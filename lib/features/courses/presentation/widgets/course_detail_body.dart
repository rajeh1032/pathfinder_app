import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../../../core/widgets/app_gradient_title.dart';
import '../../domain/entities/course.dart';
import '../cubit/courses_state.dart';
import 'course_detail_sections.dart';
import 'course_detail_stats.dart';

class CourseDetailBody extends StatelessWidget {
  const CourseDetailBody({
    required this.course,
    required this.selectedTab,
    required this.isSaved,
    required this.onShareTap,
    required this.onSaveTap,
    required this.onTabSelected,
    super.key,
  });

  final Course course;
  final CourseDetailTab selectedTab;
  final bool isSaved;
  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;
  final ValueChanged<CourseDetailTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: const AppGradientBackButton(),
          title: const AppGradientTitle(titleKey: 'courses.detailsTitle'),
          actions: [
            IconButton(
              onPressed: onShareTap,
              icon: const Icon(
                Icons.ios_share_outlined,
              ),
            ),
            IconButton(
              onPressed: onSaveTap,
              icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Image.asset(
                course.imageAsset,
                height: 191.1.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                top: AppSpacing.sm,
                start: AppSpacing.sm,
                child: CoursePill(
                  icon: Icons.auto_awesome,
                  label: 'courses.aiRecommended'.tr(),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverList.list(
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  CoursePill(label: 'courses.webDevelopment'.tr()),
                  CoursePill(label: course.levelKey.tr()),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                course.titleKey.tr(),
                style: AppTextStyles.headlineMedium(colors.onSurface),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    size: 16,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      course.providerKey.tr(),
                      style: AppTextStyles.bodyMedium(
                        colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              CourseDetailStats(course: course),
              const SizedBox(height: AppSpacing.lg),
              const CourseAiReasonCard(),
              const SizedBox(height: AppSpacing.lg),
              CourseDetailTabs(
                selectedTab: selectedTab,
                onTabSelected: onTabSelected,
              ),
              const SizedBox(height: AppSpacing.lg),
              CourseOverviewSections(selectedTab: selectedTab),
            ],
          ),
        ),
      ],
    );
  }
}

class CoursePill extends StatelessWidget {
  const CoursePill({required this.label, this.icon, super.key});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .45),
        ),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: colors.primary),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: AppTextStyles.labelSmall(colors.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
