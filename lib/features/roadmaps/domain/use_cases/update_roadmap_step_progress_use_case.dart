import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../repositories/roadmaps_repository.dart';

class UpdateRoadmapStepProgressParams {
  const UpdateRoadmapStepProgressParams({
    required this.roadmapId,
    required this.stepId,
    required this.progress,
    this.isCompleted,
  });

  final String roadmapId;
  final String stepId;
  final int progress;
  final bool? isCompleted;
}

@lazySingleton
class UpdateRoadmapStepProgressUseCase {
  const UpdateRoadmapStepProgressUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, Roadmap>> call(
    UpdateRoadmapStepProgressParams params,
  ) {
    if (params.roadmapId.trim().isEmpty) {
      return _validation('roadmaps.invalidRoadmapId');
    }
    if (params.stepId.trim().isEmpty) {
      return _validation('roadmaps.invalidStepId');
    }
    if (params.progress < 0 || params.progress > 100) {
      return _validation('roadmaps.invalidProgress');
    }
    final expectedCompleted = params.progress == 100;
    if (params.isCompleted != null &&
        params.isCompleted != expectedCompleted) {
      return _validation('roadmaps.inconsistentProgress');
    }
    return _repository.updateStepProgress(
      roadmapId: params.roadmapId.trim(),
      stepId: params.stepId.trim(),
      progress: params.progress,
      isCompleted: params.isCompleted,
    );
  }

  Future<Either<Failure, Roadmap>> _validation(String key) =>
      Future.value(Left(ValidationFailure(key)));
}
