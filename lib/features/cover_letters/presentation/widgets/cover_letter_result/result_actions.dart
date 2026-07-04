import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../domain/entities/cover_letter.dart';
import '../cover_letter/shared_widgets.dart';

class ResultActions extends StatelessWidget {
  const ResultActions({
    super.key,
    required this.onSaveDraft,
    required this.onExportPdf,
    this.insights = const [],
  });

  final VoidCallback onSaveDraft;
  final VoidCallback onExportPdf;
  final List<CoverLetterInsight> insights;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle('coverLetter.result.improvement'.tr()),
          SizedBox(height: AppSpacing.sm.h),
          if (insights.isEmpty) ...[
            Text(
              'No AI review insights returned yet.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ] else
            for (final insight in insights)
              _ImprovementItem(
                insight.message,
                type: insight.type,
              ),
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
  const _ImprovementItem(
    this.text, {
    this.type = 'info',
  });

  final String text;
  final String type;

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
          Icon(_iconForType(type), color: colors.primary, size: 18.sp),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Text(
              text,
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

  IconData _iconForType(String value) {
    return switch (value) {
      'success' => Icons.check_circle_outline,
      'warning' => Icons.warning_amber_rounded,
      _ => Icons.tips_and_updates_outlined,
    };
  }
}
