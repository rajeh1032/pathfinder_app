import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class GeneratedDraftCard extends StatelessWidget {
  const GeneratedDraftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md.w,
              AppSpacing.md.h,
              AppSpacing.md.w,
              AppSpacing.sm.h,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'coverLetter.draft.title'.tr(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const Spacer(),
                Text(
                  'coverLetter.draft.wordCount'.tr(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Theme.of(context).colorScheme.outline),
          Padding(
            padding: EdgeInsets.all(AppSpacing.md.w),
            child: Text(
              'coverLetter.draft.body'.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.65,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Divider(height: 1, color: Theme.of(context).colorScheme.outline),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.sm.w,
              AppSpacing.xs.h,
              AppSpacing.sm.w,
              AppSpacing.xs.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DraftAction(
                  icon: Icons.copy_outlined,
                  labelKey: 'coverLetter.draft.copy',
                ),
                DraftAction(
                  icon: Icons.edit_outlined,
                  labelKey: 'coverLetter.draft.edit',
                ),
                DraftAction(
                  icon: Icons.replay_outlined,
                  labelKey: 'coverLetter.draft.regenerate',
                ),
                DraftAction(
                  icon: Icons.download_outlined,
                  labelKey: 'coverLetter.draft.pdf',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DraftAction extends StatelessWidget {
  const DraftAction({super.key, required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        visualDensity: VisualDensity.compact,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      icon: Icon(icon, size: 14.sp),
      label: Text(
        labelKey.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
