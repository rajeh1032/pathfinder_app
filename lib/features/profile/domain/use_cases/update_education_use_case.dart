import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/education_entry.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class UpdateEducationUseCase {
  const UpdateEducationUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, EducationEntry>> call(
    String id,
    EducationInput input,
  ) =>
      _repository.updateEducation(id, input);
}
