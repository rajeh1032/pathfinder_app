import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/saved_job.dart';
import '../../cubit/saved_jobs_cubit.dart';
import '../../cubit/saved_jobs_state.dart';

/// Compact saved-jobs preview for the profile tab: shows up to two saved
/// jobs with a "View All" action. Owned by the jobs feature.
class SavedJobsPreviewSection extends StatelessWidget {
  const SavedJobsPreviewSection({super.key, this.maxItems = 2});

  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SavedJobsCubit, SavedJobsCubitState>(
      builder: (context, state) {
        // Hide entirely while the first load is in flight or if it failed.
        if (state.isLoading && state.jobs.isEmpty) {
          return const _SectionShell(child: _LoadingRow());
        }
        if (state.isFailure && state.jobs.isEmpty) {
          return const SizedBox.shrink();
        }

        final jobs = state.jobs.take(maxItems).toList();

        return _SectionShell(
          onViewAll: () => Navigator.pushNamed(context, AppRoutes.savedJobs),
          child: jobs.isEmpty
              ? Text(
                  'profile.noSavedJobs'.tr(),
                  style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                )
              : Column(
                  children: [
                    for (var i = 0; i < jobs.length; i++) ...[
                      _SavedJobTile(job: jobs[i], accentSeed: i),
                      if (i != jobs.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ),
        );
      },
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({required this.child, this.onViewAll});

  final Widget child;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .7)),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bookmark_border, color: colors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'profile.savedJobs'.tr(),
                    style: AppTextStyles.titleSmall(colors.primary),
                  ),
                ),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    child: Text('profile.viewAll'.tr()),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class _LoadingRow extends StatelessWidget {
  const _LoadingRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _SavedJobTile extends StatelessWidget {
  const _SavedJobTile({required this.job, required this.accentSeed});

  final SavedJob job;
  final int accentSeed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accents = [colors.primary, colors.tertiary, colors.secondary];
    final accent = accents[accentSeed % accents.length];
    final subtitle = [job.company, job.location]
        .where((v) => v != null && v.trim().isNotEmpty)
        .join(' • ');

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.jobDetails,
        arguments: job.id,
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: .35),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.outlineVariant.withValues(alpha: .6)),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              _Logo(logoUrl: job.logoUrl),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSmall(colors.onSurface),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                      ),
                    ],
                    if (job.jobType?.trim().isNotEmpty ?? false) ...[
                      SizedBox(height: 4.h),
                      Text(
                        job.jobType!.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium(accent),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.bookmark, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasLogo = logoUrl != null && logoUrl!.trim().isNotEmpty;

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasLogo
          ? Image.network(
              logoUrl!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.work_outline, color: colors.primary, size: 22),
            )
          : Icon(Icons.work_outline, color: colors.primary, size: 22),
    );
  }
}
