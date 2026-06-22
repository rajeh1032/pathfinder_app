import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/education_entry.dart';
import '../../domain/entities/work_experience.dart';
import '../../domain/use_cases/create_education_use_case.dart';
import '../../domain/use_cases/create_experience_use_case.dart';
import '../../domain/use_cases/delete_education_use_case.dart';
import '../../domain/use_cases/delete_experience_use_case.dart';
import '../../domain/use_cases/get_education_use_case.dart';
import '../../domain/use_cases/get_experiences_use_case.dart';
import '../../domain/use_cases/get_my_profile_use_case.dart';
import '../../domain/use_cases/update_education_use_case.dart';
import '../../domain/use_cases/update_experience_use_case.dart';
import '../../domain/use_cases/update_my_profile_use_case.dart';
import 'my_profile_state.dart';

/// Aggregates the Profiles module: core profile, experiences and education.
@injectable
class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(
    this._getProfile,
    this._updateProfile,
    this._getExperiences,
    this._createExperience,
    this._updateExperience,
    this._deleteExperience,
    this._getEducation,
    this._createEducation,
    this._updateEducation,
    this._deleteEducation,
  ) : super(const MyProfileState());

  final GetMyProfileUseCase _getProfile;
  final UpdateMyProfileUseCase _updateProfile;
  final GetExperiencesUseCase _getExperiences;
  final CreateExperienceUseCase _createExperience;
  final UpdateExperienceUseCase _updateExperience;
  final DeleteExperienceUseCase _deleteExperience;
  final GetEducationUseCase _getEducation;
  final CreateEducationUseCase _createEducation;
  final UpdateEducationUseCase _updateEducation;
  final DeleteEducationUseCase _deleteEducation;

  /// Loads profile + experiences + education together.
  Future<void> load() async {
    emit(state.copyWith(status: MyProfileStatus.loading, errorMessage: null));

    final profileResult = await _getProfile();
    final profileFailure = profileResult.fold((f) => f, (_) => null);
    if (profileFailure != null) {
      emit(state.copyWith(
        status: MyProfileStatus.failure,
        errorMessage: profileFailure.message,
      ));
      return;
    }

    final experiencesResult = await _getExperiences();
    final educationResult = await _getEducation();

    emit(state.copyWith(
      status: MyProfileStatus.success,
      profile: profileResult.fold((_) => null, (p) => p),
      experiences: experiencesResult.fold((_) => state.experiences, (e) => e),
      education: educationResult.fold((_) => state.education, (e) => e),
    ));
  }

  Future<bool> updateProfile(Map<String, dynamic> changes) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    final result = await _updateProfile(changes);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (profile) {
        emit(state.copyWith(isSaving: false, profile: profile));
        return true;
      },
    );
  }

  // ── Experiences ─────────────────────────────────────────────────────────
  Future<bool> addExperience(WorkExperienceInput input) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    final result = await _createExperience(input);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (experience) {
        emit(state.copyWith(
          isSaving: false,
          experiences: [...state.experiences, experience],
        ));
        return true;
      },
    );
  }

  Future<bool> editExperience(String id, WorkExperienceInput input) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    final result = await _updateExperience(id, input);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (updated) {
        emit(state.copyWith(
          isSaving: false,
          experiences: [
            for (final e in state.experiences)
              if (e.id == id) updated else e,
          ],
        ));
        return true;
      },
    );
  }

  Future<bool> removeExperience(String id) async {
    final result = await _deleteExperience(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(
          experiences:
              state.experiences.where((e) => e.id != id).toList(),
        ));
        return true;
      },
    );
  }

  // ── Education ─────────────────────────────────────────────────────────
  Future<bool> addEducation(EducationInput input) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    final result = await _createEducation(input);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (education) {
        emit(state.copyWith(
          isSaving: false,
          education: [...state.education, education],
        ));
        return true;
      },
    );
  }

  Future<bool> editEducation(String id, EducationInput input) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    final result = await _updateEducation(id, input);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (updated) {
        emit(state.copyWith(
          isSaving: false,
          education: [
            for (final e in state.education)
              if (e.id == id) updated else e,
          ],
        ));
        return true;
      },
    );
  }

  Future<bool> removeEducation(String id) async {
    final result = await _deleteEducation(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(
          education: state.education.where((e) => e.id != id).toList(),
        ));
        return true;
      },
    );
  }
}
