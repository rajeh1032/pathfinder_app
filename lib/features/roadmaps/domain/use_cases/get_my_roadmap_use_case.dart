import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap_status.dart';
import '../repositories/roadmaps_repository.dart';

@lazySingleton
class GetMyRoadmapUseCase {
  const GetMyRoadmapUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, RoadmapStatus>> call() => _repository.getMyRoadmap();
}
