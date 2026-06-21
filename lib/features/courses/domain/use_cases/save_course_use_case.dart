import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course_mutation.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class SaveCourseUseCase {
  const SaveCourseUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, SavedCourseResult>> call(String id) =>
      id.trim().isEmpty
          ? Future.value(const Left(ValidationFailure('courses.invalidId')))
          : _repository.saveCourse(id.trim());
}

@lazySingleton
class UnsaveCourseUseCase {
  const UnsaveCourseUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, SavedCourseResult>> call(String id) =>
      id.trim().isEmpty
          ? Future.value(const Left(ValidationFailure('courses.invalidId')))
          : _repository.unsaveCourse(id.trim());
}
