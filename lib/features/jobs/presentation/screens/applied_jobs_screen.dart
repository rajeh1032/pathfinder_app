import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_cubit_factory.dart';
import '../cubit/jobs_state.dart';
import '../widgets/applied_jobs/applied_job_card.dart';
import '../widgets/applied_jobs/applied_jobs_header.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createJobsCubit()..loadAppliedJobs(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('routes.appliedJobs'.tr()),
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
                    onPressed: context.read<JobsCubit>().loadAppliedJobs,
                    child: Text(state.errorMessage ?? 'Retry'),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: context.read<JobsCubit>().loadAppliedJobs,
                child: ListView(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  children: [
                    const AppliedJobsHeader(),
                    SizedBox(height: AppSpacing.md.h),
                    if (state.appliedJobs.isEmpty)
                      Center(child: Text('common.empty'.tr())),
                    for (var i = 0; i < state.appliedJobs.length; i++) ...[
                      AppliedJobCard(
                        appliedJob: state.appliedJobs[i],
                        accent: i.isEven
                            ? AppliedJobAccent.primary
                            : AppliedJobAccent.secondary,
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
