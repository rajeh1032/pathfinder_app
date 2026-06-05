import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course.dart';
import '../repositories/courses_repository.dart';

class GetCoursesUseCase {
  const GetCoursesUseCase(this._repository);

  final CoursesRepository _repository;

  Future<Either<Failure, List<Course>>> call() {
    return _repository.getCourses();
  }
}
