import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/courses_page.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class GetRecommendedCoursesUseCase {
  const GetRecommendedCoursesUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, RecommendedCoursesResult>> call([int limit = 10]) {
    if (limit < 1 || limit > 50) {
      return Future.value(
        const Left(ValidationFailure('courses.validationError')),
      );
    }
    return _repository.getRecommendedCourses(limit);
  }
}
