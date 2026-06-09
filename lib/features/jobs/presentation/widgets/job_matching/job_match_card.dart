import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'ai_match_pill.dart';
import 'insight_box.dart';
import 'job_card_header.dart';
import 'skill_section.dart';

class JobMatchCard extends StatelessWidget {
  const JobMatchCard({super.key});

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

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: .08),
            blurRadius: 26,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const JobCardHeader(),
          SizedBox(height: AppSpacing.md.h),
          const AiMatchPill(),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'jobs.matching.salary'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          MatchingSkillSection(
            title: 'jobs.common.requiredSkillsUpper'.tr(),
            skills: [
              'jobs.skills.systemDesign'.tr(),
              'jobs.skills.figma'.tr(),
              'jobs.skills.react'.tr(),
            ],
            color: requiredSkillColor,
            textColor: colorScheme.secondary,
          ),
          SizedBox(height: AppSpacing.md.h),
          MatchingSkillSection(
            title: 'jobs.common.missingSkillsUpper'.tr(),
            skills: ['jobs.skills.graphql'.tr()],
            color: missingSkillColor,
            textColor: colorScheme.error,
          ),
          SizedBox(height: AppSpacing.lg.h),
          const JobInsightBox(),
          SizedBox(height: AppSpacing.md.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.md.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .shadow
                        .withValues(alpha: .25),
                    blurRadius: 18,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.jobDetails,
                ),
                iconAlignment: IconAlignment.end,
                icon: Icon(
                  Icons.arrow_forward,
                  color: colorScheme.onPrimary,
                ),
                label: Text(
                  'jobs.common.applyNow'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
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
