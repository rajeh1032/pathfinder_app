import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../notifications/data/services/push_messaging_service_factory.dart';
import '../../domain/entities/settings_preferences.dart';
import '../../domain/repositories/settings_repository.dart';

class DemoSettingsRepository implements SettingsRepository {
  const DemoSettingsRepository(this._tokenStorage);

  final TokenStorage _tokenStorage;

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
    try {
      // Best-effort: drop this device's push token before clearing the
      // session, so the backend stops targeting it.
      try {
        await createPushMessagingService().unregisterDevice();
      } catch (_) {
        // Ignore push cleanup failures during sign-out.
      }

      await _tokenStorage.clearTokens();
      return const Right(unit);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    await _tokenStorage.clearTokens();
    return const Right(unit);
  }
}
