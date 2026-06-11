import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ai_insight_card.dart';
import 'cv_score_card.dart';

class HomeScoreInsightRow extends StatelessWidget {
  final int cvScore;

  const HomeScoreInsightRow({super.key, required this.cvScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CV Score card (small)
        CvScoreCard(score: cvScore),
        SizedBox(width: 12.w),
        // AI Career Insight card (expanded)
        Expanded(child: const AiInsightCard()),
      ],
    );
  }
}

