import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';
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
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14111827),
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
                  color: AppColors.primaryDark,
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
            color: AppColors.secondarySoft,
            textColor: AppColors.secondaryDark,
          ),
          SizedBox(height: AppSpacing.md.h),
          MatchingSkillSection(
            title: 'jobs.common.missingSkillsUpper'.tr(),
            skills: ['jobs.skills.graphql'.tr()],
            color: Color(0xFFFFE4E6),
            textColor: AppColors.error,
          ),
          SizedBox(height: AppSpacing.lg.h),
          const JobInsightBox(),
          SizedBox(height: AppSpacing.md.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.aiTertiary,
                borderRadius: BorderRadius.circular(AppRadius.md.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D6366F1),
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
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                  'jobs.common.applyNow'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
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
