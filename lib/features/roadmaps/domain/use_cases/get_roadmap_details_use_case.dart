import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../repositories/roadmaps_repository.dart';

@lazySingleton
class GetRoadmapDetailsUseCase {
  const GetRoadmapDetailsUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, Roadmap>> call(String roadmapId) {
    if (roadmapId.trim().isEmpty) {
      return Future.value(
        const Left(ValidationFailure('roadmaps.invalidRoadmapId')),
      );
    }
    return _repository.getRoadmapDetails(roadmapId.trim());
  }
}
