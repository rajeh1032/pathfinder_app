import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_cubit_factory.dart';
import '../cubit/jobs_state.dart';
import '../widgets/job_matching/boost_match_card.dart';
import '../widgets/job_matching/filter_chips.dart';
import '../widgets/job_matching/job_library_shortcuts.dart';
import '../widgets/job_matching/job_match_card.dart';
import '../widgets/job_matching/jobs_header.dart';
import '../widgets/job_matching/search_field.dart';

class JobMatchingScreen extends StatelessWidget {
  const JobMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createJobsCubit()..loadMatching(),
      child: const _JobMatchingBody(),
    );
  }
}

class _JobMatchingBody extends StatelessWidget {
  const _JobMatchingBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<JobsCubit>().loadMatching(),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: JobsHeader()),
              SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                sliver: SliverList.list(
                  children: [
                    const JobSearchField(),
                    SizedBox(height: AppSpacing.md.h),
                    const JobFilterChips(),
                    SizedBox(height: AppSpacing.md.h),
                    const JobLibraryShortcuts(),
                    SizedBox(height: AppSpacing.md.h),
                    BlocBuilder<JobsCubit, JobsState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (state.status == JobsStatus.failure) {
                          return _JobsMessage(
                            message:
                                state.errorMessage ?? 'Failed to load jobs',
                            onRetry: context.read<JobsCubit>().loadMatching,
                          );
                        }

                        if (state.matches.isEmpty) {
                          return _JobsMessage(
                            message: 'No matched jobs yet',
                            onRetry: context.read<JobsCubit>().loadMatching,
                          );
                        }

                        final visibleMatches = state.visibleMatches;
                        if (visibleMatches.isEmpty) {
                          return _JobsMessage(
                            message: 'No jobs match your search',
                            onRetry: context.read<JobsCubit>().clearSearch,
                            buttonText: 'Clear search',
                          );
                        }

                        return Column(
                          children: [
                            for (final match in visibleMatches) ...[
                              JobMatchCard(match: match),
                              SizedBox(height: AppSpacing.md.h),
                            ],
                          ],
                        );
                      },
                    ),
                    SizedBox(height: AppSpacing.lg.h),
                    const BoostMatchCard(),
                    SizedBox(height: AppSpacing.lg.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobsMessage extends StatelessWidget {
  const _JobsMessage({
    required this.message,
    required this.onRetry,
    this.buttonText = 'Retry',
  });

  final String message;
  final VoidCallback onRetry;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xl.h),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
