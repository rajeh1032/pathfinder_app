import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewHistoryTrendCard extends StatelessWidget {
  const InterviewHistoryTrendCard({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'interview.performanceTrend'.tr(),
                  style: AppTextStyles.titleLarge(colorScheme.onSurface),
                ),
              ),
              Text(
                'interview.growthLabel'.tr(namedArgs: {'value': '14'}),
                style: AppTextStyles.labelLarge(colorScheme.primary),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg.h),
          SizedBox(
            width: double.infinity,
            height: 180.h,
            child: CustomPaint(
              painter: _TrendChartPainter(colorScheme: colorScheme),
              child: const SizedBox.expand(),
            ),
          ),
          SizedBox(height: AppSpacing.xs.h),
          Row(
            children: const [
              Expanded(child: _TrendAxisLabel(label: '74%')),
              Expanded(child: _TrendAxisLabel(label: '78%')),
              Expanded(child: _TrendAxisLabel(label: '82%')),
              Expanded(child: _TrendAxisLabel(label: '84%')),
              Expanded(child: _TrendAxisLabel(label: '88%')),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  const _TrendChartPainter({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final points = <double>[0.74, 0.78, 0.82, 0.84, 0.88];
    final linePaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final fillPaint = Paint()
      ..color = colorScheme.primary.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final dotPaint = Paint()..color = colorScheme.primary;
    final accentPaint = Paint()..color = colorScheme.tertiary;

    final chartLeft = 16.w;
    final chartRight = size.width - 12.w;
    final chartTop = 16.h;
    final chartBottom = size.height - 28.h;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;
    final step = chartWidth / (points.length - 1);

    final path = Path();
    final fillPath = Path();
    for (var index = 0; index < points.length; index++) {
      final x = chartLeft + (step * index);
      final y = chartBottom - (chartHeight * points[index]);
      if (index == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, chartBottom);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
      if (index != 0 && index != points.length - 1) {
        canvas.drawCircle(
          Offset(x, y),
          5.r,
          index.isEven ? accentPaint : dotPaint,
        );
      }
    }
    fillPath
      ..lineTo(chartRight, chartBottom)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.colorScheme != colorScheme;
  }
}

class _TrendAxisLabel extends StatelessWidget {
  const _TrendAxisLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: AppTextStyles.bodySmall(
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
