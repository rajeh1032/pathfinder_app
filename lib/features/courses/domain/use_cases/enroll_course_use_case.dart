import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course_mutation.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class EnrollCourseUseCase {
  const EnrollCourseUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, EnrollmentMutationResult>> call(String id) =>
      id.trim().isEmpty
          ? Future.value(const Left(ValidationFailure('courses.invalidId')))
          : _repository.enrollCourse(id.trim());
}
