import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class InterviewHistoryScoreRing extends StatelessWidget {
  const InterviewHistoryScoreRing({
    required this.score,
    required this.accentColor,
    super.key,
  });

  final int score;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: 72.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: 72.w,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 6,
              backgroundColor:
                  colorScheme.primaryContainer.withValues(alpha: 0.55),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
          Text(
            '$score%',
            style: AppTextStyles.titleLarge(colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
