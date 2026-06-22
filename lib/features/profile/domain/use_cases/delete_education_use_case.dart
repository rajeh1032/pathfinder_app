import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class DeleteEducationUseCase {
  const DeleteEducationUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, bool>> call(String id) =>
      _repository.deleteEducation(id);
}
