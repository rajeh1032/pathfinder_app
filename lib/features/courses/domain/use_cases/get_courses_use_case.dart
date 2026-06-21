import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/courses_page.dart';
import '../entities/courses_query.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class GetCoursesUseCase {
  const GetCoursesUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, CoursesPage>> call(CoursesQuery query) {
    if (query.page < 1 || query.limit < 1 || query.limit > 50) {
      return Future.value(
        const Left(ValidationFailure('courses.validationError')),
      );
    }
    return _repository.getCourses(query);
  }
}
