import 'package:dartz/dartz.dart';
import 'package:pathfinder_app/features/auth/domain/entities/register_data.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthSession>> register({
  required RegisterRegistrationData registrationData,
});
}
