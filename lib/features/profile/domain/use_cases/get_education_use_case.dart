import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/education_entry.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class GetEducationUseCase {
  const GetEducationUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, List<EducationEntry>>> call() =>
      _repository.getEducation();
}
