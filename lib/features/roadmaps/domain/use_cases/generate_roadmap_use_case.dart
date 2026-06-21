import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap_status.dart';
import '../repositories/roadmaps_repository.dart';

@lazySingleton
class GenerateRoadmapUseCase {
  const GenerateRoadmapUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, GenerateRoadmapResult>> call({
    bool forceRegenerate = false,
  }) =>
      _repository.generateRoadmap(forceRegenerate: forceRegenerate);
}
