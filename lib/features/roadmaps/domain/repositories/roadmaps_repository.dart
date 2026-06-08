import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap.dart';
import '../entities/roadmap_course_recommendation.dart';

abstract class RoadmapsRepository {
  Future<Either<Failure, List<RoadmapCourseRecommendation>>> getRoadmaps();

  Future<Either<Failure, Roadmap>> getRoadmapDetails(String id);

  Future<Either<Failure, Roadmap>> updateRoadmapStep({
    required String roadmapId,
    required String stepId,
    required RoadmapStepStatus status,
  });
}
