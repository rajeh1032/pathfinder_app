import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../cubit/roadmaps_cubit.dart';
import '../cubit/roadmaps_state.dart';
import '../widgets/roadmap_details_body.dart';

class RoadmapDetailsScreen extends StatelessWidget {
  const RoadmapDetailsScreen({this.roadmapId, super.key});

  final String? roadmapId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RoadmapsCubit>()..loadRoadmapDetails(roadmapId),
      child: const _RoadmapDetailsView(),
    );
  }
}

class _RoadmapDetailsView extends StatelessWidget {
  const _RoadmapDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoadmapsCubit, RoadmapsState>(
      listenWhen: (previous, current) =>
          previous.feedbackSerial != current.feedbackSerial,
      listener: (context, state) {
        final key = state.feedbackKey;
        if (key == null) return;
        if (key == 'roadmaps.regenerationSuccess') {
          Navigator.pop(context, true);
        } else if (key == 'roadmaps.updateFailed' ||
            key == 'roadmaps.regenerationFailed') {
          CustomSnackbar.showErrorKey(context: context, messageKey: key);
        } else {
          CustomSnackbar.showInfoKey(context: context, messageKey: key);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('roadmaps.detailsTitle'.tr()),
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<RoadmapsCubit, RoadmapsState>(
            builder: (context, state) {
              if (state.status == RoadmapsStatus.detailLoaded ||
                  state.status == RoadmapsStatus.regenerating) {
                return RoadmapDetailsBody(
                  roadmap: state.roadmap!,
                  updatingStepId: state.updatingStepId,
                  onStepTap: context.read<RoadmapsCubit>().toggleStepCompletion,
                  isCreating: state.status == RoadmapsStatus.regenerating,
                  onCreateNew: () => _confirmCreateNew(context),
                );
              }
              if (state.status == RoadmapsStatus.empty) {
                return AppEmptyView(message: 'roadmaps.empty'.tr());
              }
              if (_isError(state.status)) {
                return AppErrorView(
                  message: (state.errorKey ?? 'roadmaps.genericError').tr(),
                  onRetry: context.read<RoadmapsCubit>().retry,
                );
              }
              return Semantics(
                label: 'roadmaps.loadingDetails'.tr(),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isError(RoadmapsStatus status) =>
      status == RoadmapsStatus.networkError ||
      status == RoadmapsStatus.unauthorized ||
      status == RoadmapsStatus.error;

  Future<void> _confirmCreateNew(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('roadmaps.regenerateConfirmTitle'.tr()),
        content: Text('roadmaps.regenerateConfirmBody'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text('roadmaps.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('roadmaps.createNewRoadmap'.tr()),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<RoadmapsCubit>().regenerateRoadmap();
    }
  }
}
