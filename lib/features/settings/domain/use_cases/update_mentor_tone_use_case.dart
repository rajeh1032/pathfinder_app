import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/settings_preferences.dart';
import '../repositories/settings_repository.dart';

class UpdateMentorToneUseCase {
  const UpdateMentorToneUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, SettingsPreferences>> call(String mentorToneKey) {
    return _repository.updateMentorTone(mentorToneKey);
  }
}
