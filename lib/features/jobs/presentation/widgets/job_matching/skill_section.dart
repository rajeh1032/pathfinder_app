import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class MatchingSkillSection extends StatelessWidget {
  const MatchingSkillSection({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
              ),
        ),
        SizedBox(height: AppSpacing.sm.h),
        Wrap(
          spacing: AppSpacing.sm.w,
          runSpacing: AppSpacing.sm.h,
          children: skills
              .map(
                (skill) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppRadius.pill.r),
                    border: Border.all(
                      color: textColor.withValues(alpha: .38),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
