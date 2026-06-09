import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/roadmap_course_recommendation.dart';
import '../repositories/roadmaps_repository.dart';

class GetRoadmapsUseCase {
  const GetRoadmapsUseCase(this._repository);

  final RoadmapsRepository _repository;

  Future<Either<Failure, List<RoadmapCourseRecommendation>>> call() {
    return _repository.getRoadmaps();
  }
}
