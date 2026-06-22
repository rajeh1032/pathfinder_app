import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_cubit_factory.dart';
import '../cubit/jobs_state.dart';
import '../widgets/saved_jobs/saved_job_card.dart';
import '../widgets/saved_jobs/saved_jobs_summary.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createJobsCubit()..loadSavedJobs(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('routes.savedJobs'.tr()),
        ),
        body: SafeArea(
          child: BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == JobsStatus.failure) {
                return Center(
                  child: OutlinedButton(
                    onPressed: context.read<JobsCubit>().loadSavedJobs,
                    child: Text(state.errorMessage ?? 'Retry'),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: context.read<JobsCubit>().loadSavedJobs,
                child: ListView(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  children: [
                    SavedJobsSummary(count: state.savedJobs.length),
                    SizedBox(height: AppSpacing.md.h),
                    if (state.savedJobs.isEmpty) const _EmptySavedJobs(),
                    for (final savedJob in state.savedJobs) ...[
                      SavedJobCard(
                        savedJob: savedJob,
                        onRemove: () async {
                          await context
                              .read<JobsCubit>()
                              .toggleSave(savedJob.job.id);
                          if (context.mounted) {
                            context.read<JobsCubit>().loadSavedJobs();
                          }
                        },
                      ),
                      SizedBox(height: AppSpacing.md.h),
                    ],
                  ],
                ),
              );
            },
          ),
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
