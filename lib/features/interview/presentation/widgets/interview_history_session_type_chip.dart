import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewHistorySessionTypeChip extends StatelessWidget {
  const InterviewHistorySessionTypeChip({
    required this.label,
    required this.accentColor,
    super.key,
  });

  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall(accentColor).copyWith(
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
