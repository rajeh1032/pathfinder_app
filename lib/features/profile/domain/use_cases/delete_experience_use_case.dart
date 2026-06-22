import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class DeleteExperienceUseCase {
  const DeleteExperienceUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, String>> call(String id) =>
      _repository.deleteExperience(id);
}
