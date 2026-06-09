
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../home_dummy_data.dart';

class HomeSkillGapSection extends StatelessWidget {
  final List<HomeSkillGapModel> skills;

  const HomeSkillGapSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skill Gap Analysis',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Chips
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: skills.map((s) => _SkillChip(skill: s)).toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final HomeSkillGapModel skill;

  const _SkillChip({required this.skill});

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