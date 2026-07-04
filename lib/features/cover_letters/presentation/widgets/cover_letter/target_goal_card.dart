import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class TargetGoalCard extends StatelessWidget {
  const TargetGoalCard({
    super.key,
    this.title,
    this.progress = 0,
    this.selectedSkills = const [],
    this.remainingSkills = const [],
  });

  final String? title;
  final double progress;
  final List<String> selectedSkills;
  final List<String> remainingSkills;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'coverLetter.goal.label'.tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .8,
                          ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      title?.trim().isNotEmpty == true
                          ? title!
                          : 'Selected role',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 62.w,
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _pillTint(context, colorScheme.secondary, alpha: .15),
                  borderRadius: BorderRadius.circular(AppRadius.pill.r),
                  border: Border.all(
                    color: colorScheme.secondary.withValues(alpha: .40),
                  ),
                ),
                child: Text(
                  '${(progress.clamp(0.0, 1.0) * 100).round()}%\nReady',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          ProgressTrack(value: progress),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).round()}%',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          if (selectedSkills.isNotEmpty || remainingSkills.isNotEmpty)
            Wrap(
              spacing: AppSpacing.sm.w,
              runSpacing: AppSpacing.sm.h,
              children: [
                for (final skill in selectedSkills.take(4))
                  MiniSkillStatus(label: skill, active: true),
                for (final skill in remainingSkills.take(4))
                  MiniSkillStatus(label: skill),
              ],
            ),
        ],
      ),
    );
  }
}

Color _pillTint(BuildContext context, Color tint, {required double alpha}) {
  return Color.alphaBlend(
    tint.withValues(alpha: alpha),
    Theme.of(context).colorScheme.surface,
  );
}

class ProgressTrack extends StatelessWidget {
  const ProgressTrack({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill.r),
      child: SizedBox(
        height: 8.h,
        child: LinearProgressIndicator(
          value: value,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}

class MiniSkillStatus extends StatelessWidget {
  const MiniSkillStatus({super.key, required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            color: active
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.outlineVariant,
            size: 14.sp,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
