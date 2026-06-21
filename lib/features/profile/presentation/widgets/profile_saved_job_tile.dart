import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';

class ProfileSavedJobTile extends StatelessWidget {
  const ProfileSavedJobTile({
    required this.job,
    required this.accentSeed,
    required this.isSaved,
    required this.onToggleSaved,
    super.key,
  });

  final ProfileSavedJob job;
  final int accentSeed;
  final bool isSaved;
  final ValueChanged<String> onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accentColors = [
      colors.primary,
      colors.tertiary,
      colors.secondary,
    ];
    final accentColor = accentColors[accentSeed % accentColors.length];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compactLayout = constraints.maxWidth < 320;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: .6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: compactLayout
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(
                                color: colors.outlineVariant.withValues(
                                  alpha: .45,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(5.w),
                            child: Image.asset(
                              job.logoAsset,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr(job.titleKey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.titleSmall(
                                    colors.onSurface,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  context.tr(job.companyKey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyMedium(
                                    colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            context.tr(job.modeKey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelMedium(accentColor),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => onToggleSaved(job.id),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              child: Icon(
                                isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(
                            color: colors.outlineVariant.withValues(alpha: .45),
                          ),
                        ),
                        padding: EdgeInsets.all(6.w),
                        child: Image.asset(
                          job.logoAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(job.titleKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleSmall(
                                colors.onSurface,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              context.tr(job.companyKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyMedium(
                                colors.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              context.tr(job.modeKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelMedium(accentColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () => onToggleSaved(job.id),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
