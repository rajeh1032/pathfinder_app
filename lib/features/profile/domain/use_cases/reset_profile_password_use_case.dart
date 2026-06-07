import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

class ResetProfilePasswordUseCase {
  const ResetProfilePasswordUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String currentPassword,
    required String newPassword,
  }) {
    return _repository.resetPassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
