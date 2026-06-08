import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course.dart';
import '../repositories/courses_repository.dart';

class GetCourseDetailsUseCase {
  const GetCourseDetailsUseCase(this._repository);

  final CoursesRepository _repository;

  Future<Either<Failure, Course>> call(String id) {
    if (id.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('courses.invalidId')));
    }

    return _repository.getCourseDetails(id);
  }
}
