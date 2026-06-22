import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/features/home/presentation/widgets/skill_chip.dart';

class HomeSkillGapSection extends StatelessWidget {
  final List<String> skills;

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
              'home.skillGapAnalysis'.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'home.viewAll'.tr(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
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
          children: skills
              .asMap()
              .entries
              .map((entry) => SkillChip(skill: entry.value, index: entry.key))
              .toList(),
        ),
      ],
    );
  }
}
