import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class MatchScoreCard extends StatelessWidget {
  const MatchScoreCard({
    super.key,
    required this.score,
    required this.description,
  });

  final int score;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        children: [
          SizedBox(
            width: 86.w,
            height: 86.h,
            child: ScoreRing(score: score),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            score >= 80 ? 'coverLetter.match.strong'.tr() : 'AI review',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class ScoreRing extends StatelessWidget {
  const ScoreRing({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomPaint(
      painter: ScoreRingPainter(
        value: (score / 100).clamp(0.0, 1.0),
        backgroundColor: colorScheme.primaryContainer,
        foregroundStart: colorScheme.primary,
        foregroundEnd: colorScheme.tertiary,
      ),
      child: Center(
        child: Text(
          '$score%',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
    );
  }
}

class ScoreRingPainter extends CustomPainter {
  const ScoreRingPainter({
    required this.value,
    required this.backgroundColor,
    required this.foregroundStart,
    required this.foregroundEnd,
  });

  final double value;
  final Color backgroundColor;
  final Color foregroundStart;
  final Color foregroundEnd;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 7.0;
    final rect = Offset.zero & size;
    final inset = stroke / 2;
    final arcRect = rect.deflate(inset);
    final background = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    final foreground = Paint()
      ..shader = LinearGradient(
        colors: [foregroundStart, foregroundEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;

    canvas.drawArc(arcRect, 0, 6.28318, false, background);
    canvas.drawArc(arcRect, -1.5708, 6.28318 * value, false, foreground);
  }

  @override
  bool shouldRepaint(covariant ScoreRingPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundStart != foregroundStart ||
        oldDelegate.foregroundEnd != foregroundEnd;
  }
}
