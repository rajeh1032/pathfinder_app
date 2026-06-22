import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class GetMyProfileUseCase {
  const GetMyProfileUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, UserProfile>> call() => _repository.getMyProfile();
}
