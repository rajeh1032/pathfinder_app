import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/courses_page.dart';
import '../repositories/courses_repository.dart';

@lazySingleton
class GetSavedCoursesUseCase {
  const GetSavedCoursesUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, CoursesPage>> call(int page, int limit) =>
      _repository.getSavedCourses(page, limit);
}
