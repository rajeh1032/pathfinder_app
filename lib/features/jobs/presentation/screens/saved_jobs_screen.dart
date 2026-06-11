import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/saved_jobs/saved_job_card.dart';
import '../widgets/saved_jobs/saved_jobs_summary.dart';
import '../widgets/saved_jobs/saved_jobs_state.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.savedJobs'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          children: [
            ValueListenableBuilder<Set<String>>(
              valueListenable: SavedJobsState.savedIds,
              builder: (context, savedIds, _) {
                return Column(
                  children: [
                    SavedJobsSummary(count: savedIds.length),
                    SizedBox(height: AppSpacing.md.h),
                    if (savedIds.contains(SavedJobsState.primaryJobId)) ...[
                      SavedJobCard(
                        companyKey: 'jobs.matching.companyLocation',
                        savedAtKey: 'jobs.saved.savedAt',
                        onRemove: () => SavedJobsState.remove(
                          SavedJobsState.primaryJobId,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md.h),
                    ],
                    if (savedIds.contains(SavedJobsState.architectJobId))
                      SavedJobCard(
                        companyKey: 'coverLetter.selectedRole.companyLocation',
                        savedAtKey: 'jobs.applied.updated',
                        onRemove: () => SavedJobsState.remove(
                          SavedJobsState.architectJobId,
                        ),
                      ),
                    if (savedIds.isEmpty) const _EmptySavedJobs(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySavedJobs extends StatelessWidget {
  const _EmptySavedJobs();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.xl.h),
      child: Column(
        children: [
          Icon(Icons.bookmark_remove_outlined,
              color: colors.onSurfaceVariant, size: 42.sp),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'common.empty'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
