import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../data/repositories/demo_roadmaps_repository.dart';
import '../../domain/use_cases/get_roadmap_details_use_case.dart';
import '../../domain/use_cases/get_roadmaps_use_case.dart';
import '../../domain/use_cases/update_roadmap_step_use_case.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import '../widgets/roadmaps_body.dart';

class RoadmapsScreen extends StatelessWidget {
  const RoadmapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repository = DemoRoadmapsRepository();
        return RoadmapsCubit(
          getRoadmapsUseCase: GetRoadmapsUseCase(repository),
          getRoadmapDetailsUseCase: GetRoadmapDetailsUseCase(repository),
          updateRoadmapStepUseCase: UpdateRoadmapStepUseCase(repository),
        )..loadRoadmaps();
      },
      child: const _RoadmapsView(),
    );
  }
}

class _RoadmapsView extends StatelessWidget {
  const _RoadmapsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: BlocBuilder<RoadmapsCubit, RoadmapsState>(
          builder: (context, state) {
            if (state is RoadmapsSuccess) {
              return RoadmapsBody(
                recommendations: state.recommendations,
                query: state.query,
                selectedFilter: state.selectedFilter,
                selectedCategoryKey: state.selectedCategoryKey,
                savedCourseIds: state.savedCourseIds,
              );
            }

            if (state is RoadmapsEmpty) {
              return AppErrorView(
                message: 'roadmaps.empty'.tr(),
                onRetry: () => context.read<RoadmapsCubit>().loadRoadmaps(),
              );
            }

            if (state is RoadmapsError) {
              return AppErrorView(
                message: state.messageKey.tr(),
                onRetry: () => context.read<RoadmapsCubit>().loadRoadmaps(),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
