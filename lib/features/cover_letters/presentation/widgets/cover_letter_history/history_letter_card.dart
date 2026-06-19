import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../cover_letter/shared_widgets.dart';

class HistoryLetterCard extends StatelessWidget {
  const HistoryLetterCard({
    super.key,
    required this.statusKey,
    required this.dateKey,
  });

  final String statusKey;
  final String dateKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _LetterIcon(),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'coverLetter.result.letterTitle'.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateKey.tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              _StatusPill(statusKey),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'coverLetter.draft.body'.tr(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterResult),
                  child: Text('coverLetter.history.open'.tr()),
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterGenerator),
                  child: Text('coverLetter.history.duplicate'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LetterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 46.w,
      height: 46.w,
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          colors.primary.withValues(alpha: .12),
          colors.surface,
        ),
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      child: Icon(Icons.description_outlined, color: colors.primary),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill(this.labelKey);

  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          colors.secondary.withValues(alpha: .12),
          colors.surface,
        ),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
        border: Border.all(color: colors.secondary.withValues(alpha: .38)),
      ),
      child: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}
