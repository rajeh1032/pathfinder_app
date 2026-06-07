import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/settings_preferences.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsPreferenceUseCase {
  const UpdateSettingsPreferenceUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, SettingsPreferences>> call({
    required SettingsPreferenceKey key,
    required bool enabled,
  }) {
    return _repository.updatePreference(key: key, enabled: enabled);
  }
}
