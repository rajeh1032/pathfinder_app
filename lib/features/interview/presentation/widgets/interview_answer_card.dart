import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterviewAnswerCard extends StatelessWidget {
  const InterviewAnswerCard({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130.h,
            child: TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'interview.answerHint'.tr(),
                hintMaxLines: 2,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.bodyLarge(colorScheme.onSurface),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Icon(Icons.mic_rounded, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
