import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course_enrollment.dart';
import '../entities/course_mutation.dart';
import '../repositories/courses_repository.dart';

class UpdateEnrollmentParams {
  const UpdateEnrollmentParams({
    required this.courseId,
    this.progress,
    this.status,
  });
  final String courseId;
  final int? progress;
  final EnrollmentStatus? status;
}

@lazySingleton
class UpdateEnrollmentUseCase {
  const UpdateEnrollmentUseCase(this._repository);
  final CoursesRepository _repository;

  Future<Either<Failure, EnrollmentMutationResult>> call(
    UpdateEnrollmentParams params,
  ) {
    if (params.courseId.trim().isEmpty) return _invalid('courses.invalidId');
    if (params.progress == null && params.status == null) {
      return _invalid('courses.noEnrollmentChanges');
    }
    final progress = params.progress;
    final status = params.status;
    if (progress != null && (progress < 0 || progress > 100)) {
      return _invalid('courses.invalidProgress');
    }
    if (status == EnrollmentStatus.completed && progress != 100) {
      return _invalid('courses.inconsistentEnrollment');
    }
    if (progress == 100 && status != EnrollmentStatus.completed) {
      return _invalid('courses.inconsistentEnrollment');
    }
    if (progress != null &&
        progress < 100 &&
        status == EnrollmentStatus.completed) {
      return _invalid('courses.inconsistentEnrollment');
    }
    return _repository.updateEnrollment(
      params.courseId.trim(),
      progress: progress,
      status: status,
    );
  }

  Future<Either<Failure, EnrollmentMutationResult>> _invalid(String key) =>
      Future.value(Left(ValidationFailure(key)));
}
