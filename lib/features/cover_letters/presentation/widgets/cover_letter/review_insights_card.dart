import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../domain/entities/cover_letter.dart';
import 'shared_widgets.dart';

class ReviewInsightsCard extends StatelessWidget {
  const ReviewInsightsCard({
    super.key,
    required this.insights,
  });

  final List<CoverLetterInsight> insights;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final successBackground = _softTint(
      context,
      colorScheme.secondary,
      lightAlpha: .20,
      darkAlpha: .32,
    );
    final warningBackground = _softTint(
      context,
      colorScheme.error,
      lightAlpha: .14,
      darkAlpha: .28,
    );
    final infoBackground = _softTint(
      context,
      colorScheme.primary,
      lightAlpha: .14,
      darkAlpha: .30,
    );

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle('coverLetter.insights.title'.tr()),
          SizedBox(height: AppSpacing.sm.h),
          if (insights.isEmpty)
            Text(
              'No AI insights returned yet.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            )
          else
            for (final insight in insights)
              InsightItem(
                icon: _iconForType(insight.type),
                text: insight.message,
                color: switch (insight.type) {
                  'success' => successBackground,
                  'warning' => warningBackground,
                  _ => infoBackground,
                },
                foregroundColor: switch (insight.type) {
                  'success' => colorScheme.secondary,
                  'warning' => colorScheme.error,
                  _ => colorScheme.primary,
                },
              ),
        ],
      ),
    );
  }
}

IconData _iconForType(String type) {
  return switch (type) {
    'success' => Icons.check_circle_outline,
    'warning' => Icons.warning_amber_rounded,
    _ => Icons.info_outline,
  };
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

class InsightItem extends StatelessWidget {
  const InsightItem({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.foregroundColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: foregroundColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
