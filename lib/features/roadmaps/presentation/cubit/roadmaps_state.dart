import 'package:equatable/equatable.dart';

import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_status.dart';

enum RoadmapsStatus {
  initial,
  loading,
  uploadCvRequired,
  generationRequired,
  generating,
  regenerating,
  active,
  detailLoading,
  detailLoaded,
  empty,
  networkError,
  unauthorized,
  error,
}

class RoadmapsState extends Equatable {
  const RoadmapsState({
    this.status = RoadmapsStatus.initial,
    this.roadmap,
    this.requiredAction,
    this.updatingStepId,
    this.errorKey,
    this.feedbackKey,
    this.feedbackSerial = 0,
  });

  final RoadmapsStatus status;
  final Roadmap? roadmap;
  final RequiredRoadmapAction? requiredAction;
  final String? updatingStepId;
  final String? errorKey;
  final String? feedbackKey;
  final int feedbackSerial;

  bool get isGenerating =>
      status == RoadmapsStatus.generating ||
      status == RoadmapsStatus.regenerating;

  RoadmapsState copyWith({
    RoadmapsStatus? status,
    Roadmap? roadmap,
    bool clearRoadmap = false,
    RequiredRoadmapAction? requiredAction,
    bool clearRequiredAction = false,
    String? updatingStepId,
    bool clearUpdatingStep = false,
    String? errorKey,
    bool clearError = false,
    String? feedbackKey,
    bool clearFeedback = false,
    int? feedbackSerial,
  }) {
    return RoadmapsState(
      status: status ?? this.status,
      roadmap: clearRoadmap ? null : roadmap ?? this.roadmap,
      requiredAction: clearRequiredAction
          ? null
          : requiredAction ?? this.requiredAction,
      updatingStepId:
          clearUpdatingStep ? null : updatingStepId ?? this.updatingStepId,
      errorKey: clearError ? null : errorKey ?? this.errorKey,
      feedbackKey: clearFeedback ? null : feedbackKey ?? this.feedbackKey,
      feedbackSerial: feedbackSerial ?? this.feedbackSerial,
    );
  }

  @override
  List<Object?> get props => [
        status,
        roadmap,
        requiredAction,
        updatingStepId,
        errorKey,
        feedbackKey,
        feedbackSerial,
      ];
}
