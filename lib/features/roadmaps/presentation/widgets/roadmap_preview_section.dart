import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import 'roadmap_progress_header.dart';

/// Compact career-roadmap preview for the profile tab. Backed by the
/// roadmaps feature's [RoadmapsCubit] (`/v1/roadmaps/me`).
class RoadmapPreviewSection extends StatelessWidget {
  const RoadmapPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<RoadmapsCubit, RoadmapsState>(
      builder: (context, state) {
        return switch (state.status) {
          RoadmapsStatus.initial ||
          RoadmapsStatus.loading =>
            const _SectionShell(child: _LoadingRow()),
          RoadmapsStatus.active ||
          RoadmapsStatus.regenerating ||
          RoadmapsStatus.detailLoaded ||
          RoadmapsStatus.detailLoading =>
            state.roadmap == null
                ? const SizedBox.shrink()
                : _SectionShell(
                    onViewAll: () =>
                        Navigator.pushNamed(context, AppRoutes.roadmaps),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.roadmapDetails,
                        arguments: RouteArguments(id: state.roadmap!.id),
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: RoadmapProgressHeader(roadmap: state.roadmap!),
                    ),
                  ),
          RoadmapsStatus.networkError ||
          RoadmapsStatus.unauthorized ||
          RoadmapsStatus.error =>
            _SectionShell(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (state.errorKey ?? 'roadmaps.genericError').tr(),
                      style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                    ),
                  ),
                  TextButton(
                    onPressed: context.read<RoadmapsCubit>().retry,
                    child: Text('common.retry'.tr()),
                  ),
                ],
              ),
            ),
          // Empty / upload-cv / generation required: invite the user in.
          _ => _SectionShell(
              onViewAll: () =>
                  Navigator.pushNamed(context, AppRoutes.roadmaps),
              child: Text(
                'roadmaps.generateBody'.tr(),
                style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
              ),
            ),
        };
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
                Icon(Icons.route_outlined, color: colors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'roadmaps.title'.tr(),
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
