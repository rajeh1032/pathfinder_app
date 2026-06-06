import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();

  Future<Either<Failure, Profile>> updateProfile(Profile profile);

  Future<Either<Failure, Unit>> resetPassword({
    required String currentPassword,
    required String newPassword,
  });
}
