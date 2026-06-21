import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_status.dart';
import '../../domain/use_cases/generate_roadmap_use_case.dart';
import '../../domain/use_cases/get_my_roadmap_use_case.dart';
import '../../domain/use_cases/get_roadmap_details_use_case.dart';
import '../../domain/use_cases/update_roadmap_step_progress_use_case.dart';
import 'roadmaps_state.dart';

@injectable
class RoadmapsCubit extends Cubit<RoadmapsState> {
  RoadmapsCubit(
    this._getMyRoadmap,
    this._generateRoadmap,
    this._getRoadmapDetails,
    this._updateStepProgress,
  ) : super(const RoadmapsState());

  final GetMyRoadmapUseCase _getMyRoadmap;
  final GenerateRoadmapUseCase _generateRoadmap;
  final GetRoadmapDetailsUseCase _getRoadmapDetails;
  final UpdateRoadmapStepProgressUseCase _updateStepProgress;

  String? _lastRoadmapId;

  Future<void> loadMyRoadmap() async {
    if (state.status == RoadmapsStatus.loading) return;
    emit(const RoadmapsState(status: RoadmapsStatus.loading));
    final result = await _getMyRoadmap();
    result.fold(_emitFailure, _emitOverview);
  }

  Future<void> generateRoadmap() => _generate(forceRegenerate: false);

  Future<void> regenerateRoadmap() => _generate(forceRegenerate: true);

  Future<void> _generate({required bool forceRegenerate}) async {
    if (state.isGenerating) return;
    final previousRoadmap = state.roadmap;
    final previousStatus = state.status;
    emit(state.copyWith(
      status: forceRegenerate
          ? RoadmapsStatus.regenerating
          : RoadmapsStatus.generating,
      clearError: true,
      clearFeedback: true,
    ));
    final result = await _generateRoadmap(
      forceRegenerate: forceRegenerate,
    );
    result.fold(
      (failure) {
        if (forceRegenerate && previousRoadmap != null) {
          emit(state.copyWith(
            status: previousStatus == RoadmapsStatus.detailLoaded
                ? RoadmapsStatus.detailLoaded
                : RoadmapsStatus.active,
            roadmap: previousRoadmap,
            feedbackKey: 'roadmaps.regenerationFailed',
            feedbackSerial: state.feedbackSerial + 1,
          ));
        } else {
          _emitFailure(failure);
        }
      },
      (generated) {
        if (generated.roadmap != null) {
          emit(RoadmapsState(
            status: generated.roadmap!.sections.isEmpty
                ? RoadmapsStatus.empty
                : RoadmapsStatus.active,
            roadmap: generated.roadmap,
            feedbackKey: forceRegenerate
                ? 'roadmaps.regenerationSuccess'
                : 'roadmaps.generationSuccess',
            feedbackSerial: state.feedbackSerial + 1,
          ));
          return;
        }
        _emitRequiredAction(generated.requiredAction);
      },
    );
  }

  Future<void> loadRoadmapDetails(String? roadmapId) async {
    final id = roadmapId?.trim() ?? '';
    _lastRoadmapId = id;
    emit(const RoadmapsState(status: RoadmapsStatus.detailLoading));
    final result = await _getRoadmapDetails(id);
    result.fold(
      _emitFailure,
      (roadmap) => emit(RoadmapsState(
        status: roadmap.sections.isEmpty
            ? RoadmapsStatus.empty
            : RoadmapsStatus.detailLoaded,
        roadmap: roadmap,
      )),
    );
  }

  Future<void> toggleStepCompletion(String stepId) async {
    final roadmap = state.roadmap;
    if (state.status != RoadmapsStatus.detailLoaded ||
        roadmap == null ||
        state.updatingStepId != null) {
      return;
    }
    final step = roadmap.steps.cast<RoadmapStep?>().firstWhere(
          (item) => item?.id == stepId,
          orElse: () => null,
        );
    if (step == null || step.status == RoadmapStepStatus.upcoming) {
      _feedback('roadmaps.stepLocked');
      return;
    }
    final completing = !step.isCompleted;
    emit(state.copyWith(
      updatingStepId: stepId,
      clearFeedback: true,
    ));
    final result = await _updateStepProgress(
      UpdateRoadmapStepProgressParams(
        roadmapId: roadmap.id,
        stepId: stepId,
        progress: completing ? 100 : 0,
        isCompleted: completing,
      ),
    );
    result.fold(
      (_) => emit(state.copyWith(
        status: RoadmapsStatus.detailLoaded,
        roadmap: roadmap,
        clearUpdatingStep: true,
        feedbackKey: 'roadmaps.updateFailed',
        feedbackSerial: state.feedbackSerial + 1,
      )),
      (updated) => emit(state.copyWith(
        status: RoadmapsStatus.detailLoaded,
        roadmap: updated,
        clearUpdatingStep: true,
        feedbackKey:
            completing ? 'roadmaps.stepCompleted' : 'roadmaps.stepReopened',
        feedbackSerial: state.feedbackSerial + 1,
      )),
    );
  }

  Future<void> retry() => _lastRoadmapId == null
      ? loadMyRoadmap()
      : loadRoadmapDetails(_lastRoadmapId);

  void _emitOverview(RoadmapStatus overview) {
    if (overview.roadmap != null) {
      emit(RoadmapsState(
        status: overview.roadmap!.sections.isEmpty
            ? RoadmapsStatus.empty
            : RoadmapsStatus.active,
        roadmap: overview.roadmap,
      ));
      return;
    }
    _emitRequiredAction(overview.requiredAction);
  }

  void _emitRequiredAction(RequiredRoadmapAction? action) {
    emit(RoadmapsState(
      status: action == RequiredRoadmapAction.uploadCv
          ? RoadmapsStatus.uploadCvRequired
          : RoadmapsStatus.generationRequired,
      requiredAction: action,
    ));
  }

  void _emitFailure(Failure failure) {
    final status = switch (failure) {
      NetworkFailure() => RoadmapsStatus.networkError,
      UnauthorizedFailure() => RoadmapsStatus.unauthorized,
      _ => RoadmapsStatus.error,
    };
    final key = switch (failure) {
      ValidationFailure() => failure.message,
      NetworkFailure() => 'roadmaps.networkError',
      UnauthorizedFailure() => 'roadmaps.unauthorized',
      _ => 'roadmaps.genericError',
    };
    emit(RoadmapsState(status: status, errorKey: key));
  }

  void _feedback(String key) => emit(state.copyWith(
        feedbackKey: key,
        feedbackSerial: state.feedbackSerial + 1,
      ));
}
