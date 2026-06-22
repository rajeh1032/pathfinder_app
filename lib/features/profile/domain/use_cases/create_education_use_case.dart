import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/education_entry.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class CreateEducationUseCase {
  const CreateEducationUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<Either<Failure, EducationEntry>> call(EducationInput input) =>
      _repository.createEducation(input);
}
