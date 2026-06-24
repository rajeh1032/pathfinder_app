import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class ApplyBottomBar extends StatelessWidget {
  const ApplyBottomBar({
    super.key,
    required this.isSaved,
    required this.isSaving,
    required this.isApplying,
    required this.onToggleSave,
    required this.onApply,
  });

  final bool isSaved;
  final bool isSaving;
  final bool isApplying;
  final VoidCallback onToggleSave;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md.w,
        AppSpacing.sm.h,
        AppSpacing.md.w,
        MediaQuery.paddingOf(context).bottom + AppSpacing.sm.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: .08),
            blurRadius: 22,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              final colors = Theme.of(context).colorScheme;

              return InkWell(
                onTap: isSaving ? null : onToggleSave,
                onLongPress: () => Navigator.of(context).pushNamed(
                  AppRoutes.savedJobs,
                ),
                borderRadius: BorderRadius.circular(AppRadius.md.r),
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isSaved ? colors.primary : colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md.r),
                    border: Border.all(
                      color: isSaved ? colors.primary : colors.primaryContainer,
                    ),
                  ),
                  child: isSaving
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: isSaved ? colors.onPrimary : colors.primary,
                          ),
                        )
                      : Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? colors.onPrimary : colors.primary,
                        ),
                ),
              );
            },
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.md.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .shadow
                        .withValues(alpha: .2),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: SizedBox(
                height: 50.h,
                child: TextButton(
                  onPressed: isApplying ? null : onApply,
                  child: isApplying
                      ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : Text(
                          'jobs.common.applyNow'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
