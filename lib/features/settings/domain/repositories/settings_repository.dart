import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/settings_preferences.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsPreferences>> getPreferences();

  Future<Either<Failure, SettingsPreferences>> updatePreference({
    required SettingsPreferenceKey key,
    required bool enabled,
  });

  Future<Either<Failure, SettingsPreferences>> updateMentorTone(
    String mentorToneKey,
  );

  Future<Either<Failure, SettingsPreferences>> updateCareerGoal(
    String careerGoalKey,
  );

  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, Unit>> deleteAccount();
}
