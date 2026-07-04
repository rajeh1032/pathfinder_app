import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import '../widgets/roadmap_overview_body.dart';
import '../widgets/roadmap_required_action_view.dart';

class RoadmapsScreen extends StatelessWidget {
  const RoadmapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RoadmapsCubit>()..loadMyRoadmap(),
      child: const _RoadmapsView(),
    );
  }
}

class _RoadmapsView extends StatelessWidget {
  const _RoadmapsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoadmapsCubit, RoadmapsState>(
      listenWhen: (previous, current) =>
          previous.feedbackSerial != current.feedbackSerial,
      listener: (context, state) {
        final key = state.feedbackKey;
        if (key == null) return;
        if (key == 'roadmaps.regenerationFailed') {
          CustomSnackbar.showErrorKey(context: context, messageKey: key);
        } else {
          CustomSnackbar.showSuccessKey(context: context, messageKey: key);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(title: Text('roadmaps.title'.tr())),
        body: SafeArea(
          top: false,
          child: BlocBuilder<RoadmapsCubit, RoadmapsState>(
            builder: (context, state) => _content(context, state),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, RoadmapsState state) {
    switch (state.status) {
      case RoadmapsStatus.uploadCvRequired:
        return RoadmapRequiredActionView(
          titleKey: 'roadmaps.noCvTitle',
          bodyKey: 'roadmaps.noCvBody',
          buttonKey: 'roadmaps.uploadCvAction',
          icon: Icons.description_outlined,
          onPressed: () => _openCvUpload(context),
        );
      case RoadmapsStatus.generationRequired:
      case RoadmapsStatus.generating:
        return RoadmapRequiredActionView(
          titleKey: 'roadmaps.generateTitle',
          bodyKey: 'roadmaps.generateBody',
          buttonKey: state.status == RoadmapsStatus.generating
              ? 'roadmaps.generating'
              : 'roadmaps.generateAction',
          icon: Icons.auto_awesome,
          isLoading: state.status == RoadmapsStatus.generating,
          onPressed: context.read<RoadmapsCubit>().generateRoadmap,
        );
      case RoadmapsStatus.active:
      case RoadmapsStatus.regenerating:
        return RoadmapOverviewBody(
          roadmap: state.roadmap!,
          onOpenDetails: () => _openDetails(context, state.roadmap!.id),
          onViewAllCourses: () => Navigator.pushNamed(
            context,
            AppRoutes.courses,
          ),
        );
      case RoadmapsStatus.empty:
        return AppEmptyView(message: 'roadmaps.empty'.tr());
      case RoadmapsStatus.networkError:
      case RoadmapsStatus.unauthorized:
      case RoadmapsStatus.error:
        return AppErrorView(
          message: (state.errorKey ?? 'roadmaps.genericError').tr(),
          onRetry: context.read<RoadmapsCubit>().retry,
        );
      default:
        return Semantics(
          label: 'roadmaps.loading'.tr(),
          child: const Center(child: CircularProgressIndicator()),
        );
    }
  }

  Future<void> _openDetails(BuildContext context, String roadmapId) async {
    final changed = await Navigator.pushNamed<Object?>(
      context,
      AppRoutes.roadmapDetails,
      arguments: RouteArguments(id: roadmapId),
    );
    if (changed == true && context.mounted) {
      await context.read<RoadmapsCubit>().loadMyRoadmap();
    }
  }

  Future<void> _openCvUpload(BuildContext context) async {
    final refreshed = await Navigator.pushNamed(
      context,
      AppRoutes.cvUpload,
    );
    if (context.mounted && refreshed == true) {
      await context.read<RoadmapsCubit>().loadMyRoadmap();
    }
  }
}
