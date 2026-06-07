import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../repositories/roadmaps_repository.dart';

class UpdateRoadmapStepUseCase {
  const UpdateRoadmapStepUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, Roadmap>> call({
    required String roadmapId,
    required String stepId,
    required RoadmapStepStatus status,
  }) {
    if (roadmapId.trim().isEmpty || stepId.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('roadmaps.invalidId')));
    }

    return _repository.updateRoadmapStep(
      roadmapId: roadmapId,
      stepId: stepId,
      status: status,
    );
  }
}
