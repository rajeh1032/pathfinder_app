import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class GetCourseDetailsUseCase {
  const GetCourseDetailsUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, Course>> call(String courseId) {
    final id = courseId.trim();
    if (id.isEmpty) {
      return Future.value(const Left(ValidationFailure('courses.invalidId')));
    }
    return _repository.getCourseDetails(id);
  }
}
