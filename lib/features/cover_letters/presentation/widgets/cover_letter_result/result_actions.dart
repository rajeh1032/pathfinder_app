import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../cover_letter/shared_widgets.dart';

class ResultActions extends StatelessWidget {
  const ResultActions({
    super.key,
    required this.onSaveDraft,
    required this.onExportPdf,
  });

  final VoidCallback onSaveDraft;
  final VoidCallback onExportPdf;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle('coverLetter.result.improvement'.tr()),
          SizedBox(height: AppSpacing.sm.h),
          _ImprovementItem('coverLetter.result.noteImpact'),
          _ImprovementItem('coverLetter.result.noteCompany'),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onSaveDraft,
                  icon: const Icon(Icons.save_outlined),
                  label: Text('coverLetter.result.saveDraft'.tr()),
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onExportPdf,
                  icon: const Icon(Icons.download_outlined),
                  label: Text('coverLetter.result.exportPdf'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImprovementItem extends StatelessWidget {
  const _ImprovementItem(this.labelKey);

  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
      padding: EdgeInsets.all(AppSpacing.sm.w),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates_outlined,
              color: colors.primary, size: 18.sp),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Text(
              labelKey.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
