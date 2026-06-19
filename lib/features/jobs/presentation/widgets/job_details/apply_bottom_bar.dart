import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../saved_jobs/saved_jobs_state.dart';

class ApplyBottomBar extends StatelessWidget {
  const ApplyBottomBar({super.key});

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
          ValueListenableBuilder<Set<String>>(
            valueListenable: SavedJobsState.savedIds,
            builder: (context, savedIds, _) {
              final colors = Theme.of(context).colorScheme;
              final isSaved = savedIds.contains(SavedJobsState.primaryJobId);

              return InkWell(
                onTap: () => SavedJobsState.toggle(SavedJobsState.primaryJobId),
                onLongPress: () =>
                    Navigator.of(context).pushNamed(AppRoutes.savedJobs),
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
                  child: Icon(
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
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterGenerator),
                  child: Text(
                    'jobs.common.applyNow'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
