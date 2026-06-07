import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/settings_preferences.dart';
import '../../domain/repositories/settings_repository.dart';

class DemoSettingsRepository implements SettingsRepository {
  DemoSettingsRepository();

  static SettingsPreferences _preferences = const SettingsPreferences(
    displayNameKey: 'settings.accountName',
    headlineKey: 'settings.accountHeadline',
    avatarAsset: AppAssets.profileAlexRivera,
    emailKey: 'settings.emailValue',
    phoneKey: 'settings.phoneValue',
    mentorToneKey: 'settings.mentorToneProfessionalValue',
    careerGoalKey: 'settings.careerGoalFrontendValue',
    aiTrainingData: true,
    pushNotifications: true,
    emailDigests: false,
  );

  @override
  Future<Either<Failure, SettingsPreferences>> getPreferences() async {
    return Right(_preferences);
  }

  @override
  Future<Either<Failure, SettingsPreferences>> updatePreference({
    required SettingsPreferenceKey key,
    required bool enabled,
  }) async {
    _preferences = switch (key) {
      SettingsPreferenceKey.aiTrainingData =>
        _preferences.copyWith(aiTrainingData: enabled),
      SettingsPreferenceKey.pushNotifications =>
        _preferences.copyWith(pushNotifications: enabled),
      SettingsPreferenceKey.emailDigests =>
        _preferences.copyWith(emailDigests: enabled),
    };

    return Right(_preferences);
  }

  @override
  Future<Either<Failure, SettingsPreferences>> updateMentorTone(
    String mentorToneKey,
  ) async {
    _preferences = _preferences.copyWith(mentorToneKey: mentorToneKey);
    return Right(_preferences);
  }

  @override
  Future<Either<Failure, SettingsPreferences>> updateCareerGoal(
    String careerGoalKey,
  ) async {
    _preferences = _preferences.copyWith(careerGoalKey: careerGoalKey);
    return Right(_preferences);
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    return const Right(unit);
  }
}
