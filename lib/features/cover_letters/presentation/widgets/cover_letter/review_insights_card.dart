import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class ReviewInsightsCard extends StatelessWidget {
  const ReviewInsightsCard({super.key});

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
          InsightItem(
            icon: Icons.check_circle_outline,
            text: 'coverLetter.insights.alignment'.tr(),
            color: successBackground,
            foregroundColor: colorScheme.secondary,
          ),
          InsightItem(
            icon: Icons.check_circle_outline,
            text: 'coverLetter.insights.leadership'.tr(),
            color: successBackground,
            foregroundColor: colorScheme.secondary,
          ),
          InsightItem(
            icon: Icons.warning_amber_rounded,
            text: 'coverLetter.insights.achievements'.tr(),
            color: warningBackground,
            foregroundColor: colorScheme.error,
          ),
          InsightItem(
            icon: Icons.info_outline,
            text: 'coverLetter.insights.reactNative'.tr(),
            color: infoBackground,
            foregroundColor: colorScheme.primary,
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
