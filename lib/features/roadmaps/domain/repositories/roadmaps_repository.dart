import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../entities/roadmap_status.dart';

abstract class RoadmapsRepository {
  Future<Either<Failure, RoadmapStatus>> getMyRoadmap();

  Future<Either<Failure, GenerateRoadmapResult>> generateRoadmap({
    bool forceRegenerate = false,
  });

  Future<Either<Failure, Roadmap>> getRoadmapDetails(String roadmapId);

  Future<Either<Failure, Roadmap>> updateStepProgress({
    required String roadmapId,
    required String stepId,
    required int progress,
    bool? isCompleted,
  });
}
