import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/settings_repository.dart';

class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, Unit>> call() {
    return _repository.signOut();
  }
}
