import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../../../core/widgets/app_gradient_title.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../data/repositories/demo_roadmaps_repository.dart';
import '../../domain/entities/roadmap.dart';
import '../../domain/use_cases/get_roadmap_details_use_case.dart';
import '../../domain/use_cases/get_roadmaps_use_case.dart';
import '../../domain/use_cases/update_roadmap_step_use_case.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import '../widgets/roadmap_impact_cards.dart';
import '../widgets/roadmap_timeline.dart';

class RoadmapDetailsScreen extends StatelessWidget {
  const RoadmapDetailsScreen({this.roadmapId, super.key});

  final String? roadmapId;

  @override
  Widget build(BuildContext context) {
    final repository = DemoRoadmapsRepository();
    return BlocProvider(
      create: (_) => RoadmapsCubit(
        getRoadmapsUseCase: GetRoadmapsUseCase(repository),
        getRoadmapDetailsUseCase: GetRoadmapDetailsUseCase(repository),
        updateRoadmapStepUseCase: UpdateRoadmapStepUseCase(repository),
      )..loadRoadmapDetails(roadmapId ?? 'react-mastery'),
      child: const _RoadmapDetailsView(),
    );
  }
}

class _RoadmapDetailsView extends StatelessWidget {
  const _RoadmapDetailsView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: const AppGradientTitle(),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.notifications,
              ),
              icon: Icon(Icons.notifications, color: colors.tertiary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<RoadmapsCubit, RoadmapsState>(
          builder: (context, state) {
            if (state is RoadmapDetailsSuccess) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  _RoadmapHero(roadmap: state.roadmap),
                  const SizedBox(height: AppSpacing.xl),
                  RoadmapTimeline(
                    roadmap: state.roadmap,
                    updatingStepId: state.updatingStepId,
                    onStepTap: (stepId) => _toggleStep(context, stepId),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const RoadmapImpactCards(),
                ],
              );
            }

            if (state is RoadmapsError) {
              return AppErrorView(
                message: state.messageKey.tr(),
                onRetry: () => context
                    .read<RoadmapsCubit>()
                    .loadRoadmapDetails('react-mastery'),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> _toggleStep(BuildContext context, String stepId) async {
    final completed =
        await context.read<RoadmapsCubit>().toggleStepStatus(stepId);
    if (!context.mounted) return;

    final messageKey = switch (completed) {
      true => 'roadmaps.stepCompleted',
      false => 'roadmaps.stepReopened',
      null => 'roadmaps.stepLocked',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(messageKey.tr())),
    );
  }
}

class _RoadmapHero extends StatelessWidget {
  const _RoadmapHero({required this.roadmap});

  final Roadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(
              label: Text(
                roadmap.typeKey.tr(),
                style: AppTextStyles.labelSmall(colors.surface),
              ),
              backgroundColor: colors.primary,
              side: BorderSide.none,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 14,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  roadmap.durationKey.tr(),
                  style: AppTextStyles.labelMedium(
                    colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          roadmap.titleKey.tr(),
          style: AppTextStyles.headlineLarge(colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.sm),
        LinearProgressIndicator(
          minHeight: 8,
          value: roadmap.progressValue,
          backgroundColor: colors.primaryContainer,
          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          roadmap.progressLabelKey.tr(),
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
        ),
      ],
    );
  }
}
