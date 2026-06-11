import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../job_matching/skill_section.dart';

class SavedJobCard extends StatelessWidget {
  const SavedJobCard({
    super.key,
    required this.companyKey,
    required this.savedAtKey,
    required this.onRemove,
  });

  final String companyKey;
  final String savedAtKey;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedJobHeader(
            companyKey: companyKey,
            savedAtKey: savedAtKey,
            onRemove: onRemove,
          ),
          SizedBox(height: AppSpacing.md.h),
          _MatchPill(),
          SizedBox(height: AppSpacing.md.h),
          MatchingSkillSection(
            title: 'jobs.common.requiredSkillsUpper'.tr(),
            skills: [
              'jobs.skills.systemDesign'.tr(),
              'jobs.skills.figma'.tr(),
              'jobs.skills.react'.tr(),
            ],
            color: _pillTint(context, colors.secondary, alpha: .14),
            textColor: colors.secondary,
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.jobDetails),
                  child: Text('jobs.saved.primaryAction'.tr()),
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterGenerator),
                  child: Text('jobs.saved.secondaryAction'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SavedJobHeader extends StatelessWidget {
  const _SavedJobHeader({
    required this.companyKey,
    required this.savedAtKey,
    required this.onRemove,
  });

  final String companyKey;
  final String savedAtKey;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: _pillTint(context, colors.primary, alpha: .12),
            borderRadius: BorderRadius.circular(AppRadius.sm.r),
          ),
          child: Icon(Icons.work_outline, color: colors.primary),
        ),
        SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'jobs.common.seniorUxDesigner'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${companyKey.tr()} • ${savedAtKey.tr()}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.close, color: colors.error),
          tooltip: 'common.cancel'.tr(),
        ),
      ],
    );
  }
}

class _MatchPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _pillTint(context, colors.primary, alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: colors.primary.withValues(alpha: .38)),
      ),
      child: Text(
        'jobs.saved.match'.tr(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w900,
            ),
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
