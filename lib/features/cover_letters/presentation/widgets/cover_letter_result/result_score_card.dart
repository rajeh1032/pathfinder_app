import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../cover_letter/shared_widgets.dart';

class ResultScoreCard extends StatelessWidget {
  const ResultScoreCard({
    super.key,
    required this.score,
    required this.description,
  });

  final int score;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SurfaceCard(
      child: Row(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.primary, width: 6.w),
            ),
            child: Text(
              '$score%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'coverLetter.result.scoreLabel'.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                SizedBox(height: AppSpacing.xs.h),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Icon(Icons.auto_awesome, color: colors.primary),
        ],
      ),
    );
  }
}
