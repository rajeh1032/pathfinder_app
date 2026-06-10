import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import 'interview_history_score_ring.dart';
import 'interview_history_session_meta_item.dart';
import 'interview_history_session_type_chip.dart';

class InterviewHistorySessionCard extends StatelessWidget {
  const InterviewHistorySessionCard({
    required this.accentColorIndex,
    required this.typeKey,
    required this.titleKey,
    required this.completedDateKey,
    required this.questionsKey,
    required this.minutesKey,
    required this.score,
    required this.insightTitleKey,
    required this.insightDescriptionKey,
    super.key,
  });

  final int accentColorIndex;
  final String typeKey;
  final String titleKey;
  final String completedDateKey;
  final String questionsKey;
  final String minutesKey;
  final int score;
  final String insightTitleKey;
  final String insightDescriptionKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accentColor = accentColorIndex == 0 ? colorScheme.primary : colorScheme.tertiary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 480;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterviewHistorySessionTypeChip(
                          label: typeKey.tr(),
                          accentColor: accentColor,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        Text(
                          titleKey.tr(),
                          style: AppTextStyles.headlineSmall(colorScheme.onSurface),
                        ),
                        SizedBox(height: AppSpacing.xs.h),
                        Text(
                          completedDateKey.tr(
                            namedArgs: {
                              'date': 'June 12, 2025',
                            },
                          ),
                          style: AppTextStyles.bodyMedium(
                            colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  InterviewHistoryScoreRing(
                    score: score,
                    accentColor: accentColor,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md.h),
              Wrap(
                spacing: AppSpacing.lg.w,
                runSpacing: AppSpacing.sm.h,
                children: [
                  InterviewHistorySessionMetaItem(
                    icon: Icons.help_outline_rounded,
                    label: questionsKey.tr(namedArgs: {'count': '10'}),
                  ),
                  InterviewHistorySessionMetaItem(
                    icon: Icons.schedule_rounded,
                    label: minutesKey.tr(namedArgs: {'minutes': '45'}),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.md.w),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.auto_awesome_rounded, color: accentColor, size: 22.sp),
                    SizedBox(width: AppSpacing.sm.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insightTitleKey.tr(),
                            style: AppTextStyles.labelLarge(accentColor),
                          ),
                          SizedBox(height: AppSpacing.xs.h),
                          Text(
                            insightDescriptionKey.tr(),
                            style: AppTextStyles.bodyMedium(colorScheme.onSurface),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.md.h),
              isWide
                  ? Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'interview.viewResults'.tr(),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm.w),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('interview.retakeInterview'.tr()),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: 'interview.viewResults'.tr(),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('interview.retakeInterview'.tr()),
                          ),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
