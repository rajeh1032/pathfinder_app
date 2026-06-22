import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_cubit_factory.dart';
import '../cubit/jobs_state.dart';
import '../../domain/entities/job_match.dart';
import '../widgets/job_details/about_section.dart';
import '../widgets/job_details/ai_recommendation_card.dart';
import '../widgets/job_details/apply_bottom_bar.dart';
import '../widgets/job_details/hero_preview.dart';
import '../widgets/job_details/job_tags.dart';
import '../widgets/job_details/job_title_block.dart';
import '../widgets/job_details/needs_section.dart';
import '../widgets/job_details/overview_tab.dart';
import '../widgets/job_details/skill_section.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({
    super.key,
    required this.jobId,
    this.initialMatch,
  });

  final String? jobId;
  final JobMatch? initialMatch;

  @override
  Widget build(BuildContext context) {
    if (jobId == null || jobId!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('routes.jobDetails'.tr()),
        ),
        body: const Center(child: Text('Missing job id')),
      );
    }

    return BlocProvider(
      create: (_) => createJobsCubit()..loadJobDetails(jobId!),
      child: _JobDetailsBody(
        jobId: jobId!,
        initialMatch: initialMatch,
      ),
    );
  }
}

class _JobDetailsBody extends StatelessWidget {
  const _JobDetailsBody({
    required this.jobId,
    required this.initialMatch,
  });

  final String jobId;
  final JobMatch? initialMatch;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final requiredSkillColor = _softTint(
      context,
      colorScheme.secondary,
      lightAlpha: .22,
      darkAlpha: .34,
    );
    final missingSkillColor = _softTint(
      context,
      colorScheme.error,
      lightAlpha: .14,
      darkAlpha: .30,
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.jobDetails'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('common.actionReady'.tr())),
              );
            },
            icon: const Icon(Icons.share_outlined),
          ),
          BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              final isSaved = state.savedJobIds.contains(jobId);
              return IconButton(
                onPressed: state.isSaving
                    ? null
                    : () => context.read<JobsCubit>().toggleSave(jobId),
                icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<JobsCubit, JobsState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.isApplying != current.isApplying,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final job = state.selectedJob;
          final match = initialMatch;
          final hasCvAnalysis = match?.cvId != null;
          if (state.status == JobsStatus.failure || job == null) {
            return Center(
              child: OutlinedButton(
                onPressed: () =>
                    context.read<JobsCubit>().loadJobDetails(jobId),
                child: const Text('Retry'),
              ),
            );
          }

          final tags = [
            if (job.category != null) job.category!,
            if (job.level != null) job.level!,
            if (job.employmentType != null) job.employmentType!,
          ];

          return SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: JobHeroPreview(showAiBadge: hasCvAnalysis),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md.w,
                    AppSpacing.md.h,
                    AppSpacing.md.w,
                    MediaQuery.paddingOf(context).bottom + 150.h,
                  ),
                  sliver: SliverList.list(
                    children: [
                      JobTags(labels: tags.isEmpty ? ['Job'] : tags),
                      SizedBox(height: AppSpacing.md.h),
                      JobTitleBlock(
                        title: job.title,
                        company: job.company,
                        location: job.location,
                        certificateProvider: job.certificateProvider,
                        duration: job.duration,
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                      if (hasCvAnalysis) ...[
                        AiRecommendationCard(
                          percentage: match!.matchPercentage,
                          reason: match.reason,
                        ),
                        SizedBox(height: AppSpacing.xxl.h),
                      ],
                      const OverviewTab(),
                      SizedBox(height: AppSpacing.lg.h),
                      AboutSection(description: job.description),
                      SizedBox(height: AppSpacing.lg.h),
                      NeedsSection(items: job.requiredSkills),
                      SizedBox(height: AppSpacing.lg.h),
                      DetailsSkillSection(
                        title: 'jobs.common.requiredSkills'.tr(),
                        skills: job.requiredSkills,
                        color: requiredSkillColor,
                        textColor: colorScheme.secondary,
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                      if (hasCvAnalysis)
                        DetailsSkillSection(
                          title: 'jobs.common.missingSkills'.tr(),
                          skills: match!.missingSkills,
                          color: missingSkillColor,
                          textColor: colorScheme.error,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          return ApplyBottomBar(
            isSaved: state.savedJobIds.contains(jobId),
            isSaving: state.isSaving,
            isApplying: state.isApplying,
            onToggleSave: () => context.read<JobsCubit>().toggleSave(jobId),
            onApply: () async {
              await context.read<JobsCubit>().applyToJob(jobId);
              if (context.mounted) {
                Navigator.of(context).pushNamed(
                  AppRoutes.coverLetterGenerator,
                  arguments: jobId,
                );
              }
            },
          );
        },
      ),
    );
  }
}

Color _softTint(
  BuildContext context,
  Color tint, {
  required double lightAlpha,
  required double darkAlpha,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final isDark = colorScheme.brightness == Brightness.dark;

  return Color.alphaBlend(
    tint.withValues(alpha: isDark ? darkAlpha : lightAlpha),
    colorScheme.surface,
  );
}
