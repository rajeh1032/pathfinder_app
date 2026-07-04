import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class AiInsightCard extends StatelessWidget {
  const AiInsightCard({super.key, this.role, this.topSkill});

  /// Recommended/analyzed role from the user's latest CV analysis.
  final String? role;

  /// Top missing skill from the user's skill gap analysis.
  final String? topSkill;

  String _insightText() {
    final roleText = role?.trim() ?? '';
    final skillText = topSkill?.trim() ?? '';
    final hasRole = roleText.isNotEmpty;
    final hasSkill = skillText.isNotEmpty;

    if (hasRole && hasSkill) {
      return 'home.aiInsightWithSkill'
          .tr(namedArgs: {'role': roleText, 'skill': skillText});
    }
    if (hasRole) {
      return 'home.aiInsightRoleOnly'.tr(namedArgs: {'role': roleText});
    }
    if (hasSkill) {
      return 'home.aiInsightSkillOnly'.tr(namedArgs: {'skill': skillText});
    }
    return 'home.aiInsightDefault'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + Title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  size: 16.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'home.aiCareerInsight'.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Insight text
          Text(
            _insightText(),
            style:
                AppTextStyles.bodySmall(colorScheme.onSurfaceVariant).copyWith(
              fontSize: 12.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
