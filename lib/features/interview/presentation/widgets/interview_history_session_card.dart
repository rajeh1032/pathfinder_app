import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/interview_history_item.dart';
import 'interview_history_score_ring.dart';
import 'interview_history_session_meta_item.dart';
import 'interview_history_session_type_chip.dart';
import 'interview_result_labels.dart';

class InterviewHistorySessionCard extends StatelessWidget {
  const InterviewHistorySessionCard({
    required this.item,
    this.onViewResults,
    this.onRetake,
    super.key,
  });

  final InterviewHistoryItem item;
  final VoidCallback? onViewResults;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accentColor = _accentColor(colorScheme);
    final score = item.overallScore?.round() ?? 0;
    final insight = item.quickAiInsight;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
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
                          label: InterviewResultLabels.interviewTypeLabel(
                            item.interviewType,
                          ),
                          accentColor: accentColor,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        Text(
                          item.careerPathTitle ??
                              InterviewResultLabels.interviewTypeLabel(
                                item.interviewType,
                              ),
                          style: AppTextStyles.headlineSmall(
                              colorScheme.onSurface),
                        ),
                        SizedBox(height: AppSpacing.xs.h),
                        Text(
                          _completedLabel(),
                          style: AppTextStyles.bodyMedium(
                            colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (item.isCompleted) ...[
                    SizedBox(width: AppSpacing.md.w),
                    InterviewHistoryScoreRing(
                      score: score,
                      accentColor: accentColor,
                    ),
                  ],
                ],
              ),
              SizedBox(height: AppSpacing.md.h),
              Wrap(
                spacing: AppSpacing.lg.w,
                runSpacing: AppSpacing.sm.h,
                children: [
                  InterviewHistorySessionMetaItem(
                    icon: Icons.help_outline_rounded,
                    label: 'interview.questionsCount'.tr(
                      namedArgs: {'count': '${item.totalQuestions}'},
                    ),
                  ),
                  if (item.durationMinutes != null)
                    InterviewHistorySessionMetaItem(
                      icon: Icons.schedule_rounded,
                      label: 'interview.minutesCount'.tr(
                        namedArgs: {'minutes': '${item.durationMinutes}'},
                      ),
                    ),
                ],
              ),
              if (insight != null && insight.isNotEmpty) ...[
                SizedBox(height: AppSpacing.md.h),
                _InsightBox(insight: insight, accentColor: accentColor),
              ],
              SizedBox(height: AppSpacing.md.h),
              _buildActions(context, isWide),
            ],
          );
        },
      ),
    );
  }

  Color _accentColor(ColorScheme colorScheme) {
    switch (item.interviewType) {
      case 'behavioral':
        return colorScheme.tertiary;
      case 'mock_hr':
        return colorScheme.secondary;
      default:
        return colorScheme.primary;
    }
  }

  String _completedLabel() {
    final raw = item.completedAt;
    if (raw == null || raw.isEmpty) return '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return '';
    return 'interview.completedOn'.tr(
      namedArgs: {'date': DateFormatter.format(parsed.toLocal())},
    );
  }

  Widget _buildActions(BuildContext context, bool isWide) {
    final viewButton = AppButton(
      label: 'interview.viewResults'.tr(),
      onPressed: item.isCompleted ? onViewResults : null,
    );
    final retakeButton = OutlinedButton(
      onPressed: onRetake,
      child: Text('interview.retakeInterview'.tr()),
    );

    if (isWide) {
      return Row(
        children: [
          Expanded(child: viewButton),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(child: retakeButton),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(width: double.infinity, child: viewButton),
        SizedBox(height: AppSpacing.sm.h),
        SizedBox(width: double.infinity, child: retakeButton),
      ],
    );
  }
}

class _InsightBox extends StatelessWidget {
  const _InsightBox({required this.insight, required this.accentColor});

  final String insight;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: accentColor.withValues(alpha: 0.35)),
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
                  'interview.quickInsightLabel'.tr(),
                  style: AppTextStyles.labelLarge(accentColor),
                ),
                SizedBox(height: AppSpacing.xs.h),
                Text(
                  insight,
                  style: AppTextStyles.bodyMedium(colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
