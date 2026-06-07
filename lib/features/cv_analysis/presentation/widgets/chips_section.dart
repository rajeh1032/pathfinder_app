import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cv_anaylsis_dummy_model.dart';

class ChipsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<CvSkillChip> chips;

  const ChipsSection({super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.chips,
  });

  Color chipColor(SkillChipType type) {
    switch (type) {
      case SkillChipType.strength:
        return AppColors.success;
      case SkillChipType.weakness:
        return AppColors.warning;
      case SkillChipType.missing:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: iconColor),
            SizedBox(width: AppSpacing.xs.w),
            Text(
              title,
              style: AppTextStyles.titleSmall(colorScheme.onSurface)
                  .copyWith(fontSize: 15.sp),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        Wrap(
          spacing: AppSpacing.sm.w,
          runSpacing: AppSpacing.sm.h,
          children: chips.map((chip) {
            final color = chipColor(chip.type);
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.pill.r),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Text(
                chip.label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
