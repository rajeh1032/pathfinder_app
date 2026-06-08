import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/job_details/about_section.dart';
import '../widgets/job_details/ai_recommendation_card.dart';
import '../widgets/job_details/apply_bottom_bar.dart';
import '../widgets/job_details/hero_preview.dart';
import '../widgets/job_details/job_tags.dart';
import '../widgets/job_details/job_title_block.dart';
import '../widgets/job_details/needs_section.dart';
import '../widgets/job_details/overview_tab.dart';
import '../widgets/job_details/skill_section.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final requiredSkillColor = _softTint(
      context,
      colorScheme.secondary,
      lightAlpha: .22,
      darkAlpha: .34,
    );
    final missingSkillColor = _softTint(
      context,
      colorScheme.error,
      lightAlpha: .14,
      darkAlpha: .30,
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.jobDetails'.tr()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: JobHeroPreview()),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md.w,
                AppSpacing.md.h,
                AppSpacing.md.w,
                MediaQuery.paddingOf(context).bottom + 150.h,
              ),
              sliver: SliverList.list(
                children: [
                  const JobTags(),
                  SizedBox(height: AppSpacing.md.h),
                  const JobTitleBlock(),
                  SizedBox(height: AppSpacing.lg.h),
                  const AiRecommendationCard(),
                  SizedBox(height: AppSpacing.xxl.h),
                  const OverviewTab(),
                  SizedBox(height: AppSpacing.lg.h),
                  const AboutSection(),
                  SizedBox(height: AppSpacing.lg.h),
                  const NeedsSection(),
                  SizedBox(height: AppSpacing.lg.h),
                  DetailsSkillSection(
                    title: 'jobs.common.requiredSkills'.tr(),
                    skills: [
                      'jobs.skills.systemDesign'.tr(),
                      'jobs.skills.figma'.tr(),
                      'jobs.skills.react'.tr(),
                    ],
                    color: requiredSkillColor,
                    textColor: colorScheme.secondary,
                  ),
                  SizedBox(height: AppSpacing.lg.h),
                  DetailsSkillSection(
                    title: 'jobs.common.missingSkills'.tr(),
                    skills: ['jobs.skills.graphql'.tr()],
                    color: missingSkillColor,
                    textColor: colorScheme.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ApplyBottomBar(),
    );
  }
}

Color _softTint(
  BuildContext context,
  Color tint, {
  required double lightAlpha,
  required double darkAlpha,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final isDark = colorScheme.brightness == Brightness.dark;

  return Color.alphaBlend(
    tint.withValues(alpha: isDark ? darkAlpha : lightAlpha),
    colorScheme.surface,
  );
}
