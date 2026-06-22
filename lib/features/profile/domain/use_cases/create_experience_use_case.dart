import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/work_experience.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class CreateExperienceUseCase {
  const CreateExperienceUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, WorkExperience>> call(WorkExperienceInput input) =>
      _repository.createExperience(input);
}
