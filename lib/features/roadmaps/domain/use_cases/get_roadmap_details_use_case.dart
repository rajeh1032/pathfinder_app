import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../repositories/roadmaps_repository.dart';

class GetRoadmapDetailsUseCase {
  const GetRoadmapDetailsUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, Roadmap>> call(String id) {
    if (id.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('roadmaps.invalidId')));
    }

    return _repository.getRoadmapDetails(id);
  }
}
