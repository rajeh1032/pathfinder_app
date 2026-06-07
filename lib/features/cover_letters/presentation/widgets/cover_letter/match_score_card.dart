import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class MatchScoreCard extends StatelessWidget {
  const MatchScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        children: [
          SizedBox(
            width: 86.w,
            height: 86.h,
            child: ScoreRing(score: 87),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'coverLetter.match.strong'.tr(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            'coverLetter.match.description'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral600,
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
    return CustomPaint(
      painter: ScoreRingPainter(value: score / 100),
      child: Center(
        child: Text(
          '$score%',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.neutral900,
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
    );
  }
}

class ScoreRingPainter extends CustomPainter {
  const ScoreRingPainter({required this.value});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 7.0;
    final rect = Offset.zero & size;
    final inset = stroke / 2;
    final arcRect = rect.deflate(inset);
    final background = Paint()
      ..color = AppColors.primarySoft
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    final foreground = Paint()
      ..shader = AppGradients.aiTertiary.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;

    canvas.drawArc(arcRect, 0, 6.28318, false, background);
    canvas.drawArc(arcRect, -1.5708, 6.28318 * value, false, foreground);
  }

  @override
  bool shouldRepaint(covariant ScoreRingPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
