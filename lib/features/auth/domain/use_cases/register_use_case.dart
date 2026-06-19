import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_session.dart';
import '../entities/register_data.dart'; // الـ Entity اللي عملناه
import '../repositories/auth_repository.dart';

@lazySingleton
class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, AuthSession>> call({
    required RegisterRegistrationData registrationData,
  }) {
    return _repository.register(registrationData: registrationData);
  }
}
