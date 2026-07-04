import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewHistoryStatsCard extends StatelessWidget {
  const InterviewHistoryStatsCard({
    required this.totalInterviews,
    required this.averageScore,
    required this.bestScore,
    required this.latestScore,
    super.key,
  });

  final String totalInterviews;
  final String averageScore;
  final String bestScore;
  final String latestScore;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
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
          final isWide = constraints.maxWidth >= 520;
          return GridView.count(
            crossAxisCount: isWide ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.sm.h,
            crossAxisSpacing: AppSpacing.sm.w,
            childAspectRatio: isWide ? 1.5 : 1.15,
            children: [
              _HistoryStatTile(
                icon: Icons.event_note_rounded,
                iconColorKey: _HistoryStatColor.primary,
                labelKey: 'interview.totalInterviewsLabel',
                valueText: totalInterviews,
              ),
              _HistoryStatTile(
                icon: Icons.show_chart_rounded,
                iconColorKey: _HistoryStatColor.secondary,
                labelKey: 'interview.averageScoreLabel',
                valueText: averageScore,
              ),
              _HistoryStatTile(
                icon: Icons.emoji_events_rounded,
                iconColorKey: _HistoryStatColor.tertiary,
                labelKey: 'interview.bestScoreLabel',
                valueText: bestScore,
              ),
              _HistoryStatTile(
                icon: Icons.access_time_rounded,
                iconColorKey: _HistoryStatColor.primary,
                labelKey: 'interview.latestScoreLabel',
                valueText: latestScore,
              ),
            ],
          );
        },
      ),
    );
  }
}

enum _HistoryStatColor { primary, secondary, tertiary }

class _HistoryStatTile extends StatelessWidget {
  const _HistoryStatTile({
    required this.icon,
    required this.iconColorKey,
    required this.labelKey,
    required this.valueText,
  });

  final IconData icon;
  final _HistoryStatColor iconColorKey;
  final String labelKey;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = switch (iconColorKey) {
      _HistoryStatColor.primary => colorScheme.primary,
      _HistoryStatColor.secondary => colorScheme.secondary,
      _HistoryStatColor.tertiary => colorScheme.tertiary,
    };

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelKey.tr(),
                style: AppTextStyles.bodySmall(
                  colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                valueText,
                style: AppTextStyles.headlineSmall(colorScheme.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
