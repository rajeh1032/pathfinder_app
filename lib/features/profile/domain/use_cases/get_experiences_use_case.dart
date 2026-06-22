import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/work_experience.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class GetExperiencesUseCase {
  const GetExperiencesUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, List<WorkExperience>>> call() =>
      _repository.getExperiences();
}
