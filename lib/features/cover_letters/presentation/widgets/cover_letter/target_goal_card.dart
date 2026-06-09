import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class TargetGoalCard extends StatelessWidget {
  const TargetGoalCard({super.key});

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
                      'coverLetter.goal.title'.tr(),
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
                  'coverLetter.goal.complete'.tr(),
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
          const ProgressTrack(value: .65),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '65%',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Row(
            children: [
              const MiniSkillStatus(
                labelKey: 'coverLetter.goal.advancedPatterns',
                active: true,
              ),
              SizedBox(width: AppSpacing.sm.w),
              const MiniSkillStatus(
                labelKey: 'coverLetter.goal.systemDesign',
              ),
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
  const MiniSkillStatus(
      {super.key, required this.labelKey, this.active = false});

  final String labelKey;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              labelKey.tr(),
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
