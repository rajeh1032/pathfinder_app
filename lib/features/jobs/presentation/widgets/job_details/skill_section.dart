import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'section.dart';

class DetailsSkillSection extends StatelessWidget {
  const DetailsSkillSection({
    super.key,
    required this.title,
    required this.skills,
    required this.color,
    required this.textColor,
  });

  final String title;
  final List<String> skills;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return DetailsSection(
      title: title,
      child: Wrap(
        spacing: AppSpacing.sm.w,
        runSpacing: AppSpacing.sm.h,
        children: skills
            .map(
              (skill) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppRadius.pill.r),
                ),
                child: Text(
                  skill,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: .5,
                      ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
