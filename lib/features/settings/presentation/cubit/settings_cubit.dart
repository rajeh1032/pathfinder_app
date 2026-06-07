import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/settings_preferences.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/get_settings_preferences_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/update_career_goal_use_case.dart';
import '../../domain/use_cases/update_mentor_tone_use_case.dart';
import '../../domain/use_cases/update_settings_preference_use_case.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required GetSettingsPreferencesUseCase getPreferencesUseCase,
    required UpdateSettingsPreferenceUseCase updatePreferenceUseCase,
    required UpdateMentorToneUseCase updateMentorToneUseCase,
    required UpdateCareerGoalUseCase updateCareerGoalUseCase,
    required SignOutUseCase signOutUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
  })  : _getPreferencesUseCase = getPreferencesUseCase,
        _updatePreferenceUseCase = updatePreferenceUseCase,
        _updateMentorToneUseCase = updateMentorToneUseCase,
        _updateCareerGoalUseCase = updateCareerGoalUseCase,
        _signOutUseCase = signOutUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        super(const SettingsInitial());

  final GetSettingsPreferencesUseCase _getPreferencesUseCase;
  final UpdateSettingsPreferenceUseCase _updatePreferenceUseCase;
  final UpdateMentorToneUseCase _updateMentorToneUseCase;
  final UpdateCareerGoalUseCase _updateCareerGoalUseCase;
  final SignOutUseCase _signOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  Future<void> loadSettings() async {
    emit(const SettingsLoading());
    final result = await _getPreferencesUseCase();
    result.fold(
      (failure) => emit(SettingsError(messageKey: failure.message)),
      (preferences) => emit(SettingsSuccess(preferences: preferences)),
    );
  }

  Future<void> togglePreference({
    required SettingsPreferenceKey key,
    required bool enabled,
  }) async {
    final currentState = state;
    if (currentState is! SettingsSuccess) return;

    emit(currentState.copyWith(
      preferences:
          _optimisticPreference(currentState.preferences, key, enabled),
    ));

    final result = await _updatePreferenceUseCase(key: key, enabled: enabled);
    result.fold(
      (failure) => emit(SettingsError(messageKey: failure.message)),
      (preferences) => emit(SettingsSuccess(preferences: preferences)),
    );
  }

  Future<bool> signOut() {
    return _runAccountAction(() => _signOutUseCase());
  }

  Future<bool> updateMentorTone(String mentorToneKey) {
    return _runPreferenceAction(
      optimisticUpdate: (preferences) =>
          preferences.copyWith(mentorToneKey: mentorToneKey),
      action: () => _updateMentorToneUseCase(mentorToneKey),
    );
  }

  Future<bool> updateCareerGoal(String careerGoalKey) {
    return _runPreferenceAction(
      optimisticUpdate: (preferences) =>
          preferences.copyWith(careerGoalKey: careerGoalKey),
      action: () => _updateCareerGoalUseCase(careerGoalKey),
    );
  }

  Future<bool> deleteAccount() {
    return _runAccountAction(() => _deleteAccountUseCase());
  }

  SettingsPreferences _optimisticPreference(
    SettingsPreferences preferences,
    SettingsPreferenceKey key,
    bool enabled,
  ) {
    return switch (key) {
      SettingsPreferenceKey.aiTrainingData =>
        preferences.copyWith(aiTrainingData: enabled),
      SettingsPreferenceKey.pushNotifications =>
        preferences.copyWith(pushNotifications: enabled),
      SettingsPreferenceKey.emailDigests =>
        preferences.copyWith(emailDigests: enabled),
    };
  }

  Future<bool> _runAccountAction(
    Future<Either<Failure, Unit>> Function() action,
  ) async {
    final currentState = state;
    if (currentState is SettingsSuccess) {
      emit(currentState.copyWith(isSubmitting: true));
    }

    final result = await action();

    final latestState = state;
    if (latestState is SettingsSuccess) {
      emit(latestState.copyWith(isSubmitting: false));
    }

    return result.fold(
      (failure) {
        emit(const SettingsError());
        return false;
      },
      (_) => true,
    );
  }

  Future<bool> _runPreferenceAction({
    required SettingsPreferences Function(SettingsPreferences preferences)
        optimisticUpdate,
    required Future<Either<Failure, SettingsPreferences>> Function() action,
  }) async {
    final currentState = state;
    if (currentState is! SettingsSuccess) return false;

    emit(currentState.copyWith(
      preferences: optimisticUpdate(currentState.preferences),
      isSubmitting: true,
    ));

    final result = await action();
    return result.fold(
      (failure) {
        emit(SettingsError(messageKey: failure.message));
        return false;
      },
      (preferences) {
        emit(SettingsSuccess(preferences: preferences, isSubmitting: false));
        return true;
      },
    );
  }
}
