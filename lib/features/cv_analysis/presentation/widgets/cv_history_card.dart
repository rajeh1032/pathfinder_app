import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/cv_anaysis_entity.dart';

class CvHistoryCard extends StatelessWidget {
  const CvHistoryCard({
    super.key,
    required this.item,
    required this.onOpen,
    this.isOpening = false,
  });

  final CvHistoryItemEntity item;
  final VoidCallback onOpen;
  final bool isOpening;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final score = item.analysis?.score;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.md.r),
      child: InkWell(
        onTap: item.hasFile && !isOpening ? onOpen : null,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(AppRadius.sm.r),
                ),
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  color: colors.error,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.originalName.isEmpty
                          ? 'cvHistory.untitled'.tr()
                          : item.originalName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _detailsText(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    Wrap(
                      spacing: AppSpacing.sm.w,
                      runSpacing: AppSpacing.xs.h,
                      children: [
                        _Chip(label: _statusLabel(), icon: Icons.sync_rounded),
                        if (score != null)
                          _Chip(
                            label: 'cvHistory.scoreValue'
                                .tr(args: [score.toString()]),
                            icon: Icons.analytics_outlined,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              isOpening
                  ? SizedBox.square(
                      dimension: 22.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      item.hasFile
                          ? Icons.open_in_new_rounded
                          : Icons.file_present_outlined,
                      color: item.hasFile
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String _detailsText(BuildContext context) {
    final date = DateFormat.yMMMd(context.locale.toString())
        .add_jm()
        .format(item.uploadedAt.toLocal());
    return '$date - ${_formatSize(item.sizeBytes)}';
  }

  String _formatSize(int bytes) {
    if (bytes <= 0) return 'cvHistory.unknownSize'.tr();
    if (bytes < 1024) return 'cvHistory.bytes'.tr(args: [bytes.toString()]);
    if (bytes < 1024 * 1024) {
      return 'cvHistory.kilobytes'
          .tr(args: [(bytes / 1024).toStringAsFixed(1)]);
    }
    return 'cvHistory.megabytes'
        .tr(args: [(bytes / (1024 * 1024)).toStringAsFixed(1)]);
  }

  String _statusLabel() => switch (item.status) {
        'uploaded' => 'cvHistory.statusUploaded'.tr(),
        'parsing' => 'cvHistory.statusParsing'.tr(),
        'analyzing' => 'cvHistory.statusAnalyzing'.tr(),
        'completed' => 'cvHistory.statusCompleted'.tr(),
        'failed' => 'cvHistory.statusFailed'.tr(),
        _ => item.status,
      };
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: colors.primary),
          SizedBox(width: 4.w),
          Text(label, style: AppTextStyles.labelSmall(colors.primary)),
        ],
      ),
    );
  }
}
