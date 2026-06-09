import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, Profile>> call(Profile profile) {
    return _repository.updateProfile(profile);
  }
}
