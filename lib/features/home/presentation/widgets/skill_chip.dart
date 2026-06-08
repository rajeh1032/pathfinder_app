import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../home_dummy_data.dart';

class SkillChip extends StatelessWidget {
  final HomeSkillGapModel skill;

  const SkillChip({super.key, required this.skill});

  // Assign color per level (maps to priority visually)
  Color _chipColor() {
    switch (skill.level) {
      case SkillLevel.tailwind:
        return AppColors.primary;
      case SkillLevel.nextJs:
        return AppColors.secondary;
      case SkillLevel.testing:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _chipColor();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        skill.skill,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}