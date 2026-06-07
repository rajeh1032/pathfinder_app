import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/profile.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        super(const EditProfileInitial());

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  Future<void> loadProfile() async {
    emit(const EditProfileLoading());
    final result = await _getProfileUseCase();
    result.fold(
      (failure) => emit(EditProfileError(messageKey: failure.message)),
      (profile) => emit(EditProfileReady(profile: profile)),
    );
  }

  void selectAvatar(String avatarPath) {
    final currentState = state;
    if (currentState is! EditProfileReady) return;
    emit(currentState.copyWith(
      profile: currentState.profile.copyWith(avatarAsset: avatarPath),
    ));
  }

  void removeAvatar() {
    final currentState = state;
    if (currentState is! EditProfileReady) return;
    emit(currentState.copyWith(
      profile: currentState.profile.copyWith(
        avatarAsset: AppAssets.profileAlexJenkins,
      ),
    ));
  }

  Future<void> submit({
    required String fullName,
    required String headline,
    required String email,
    required String location,
    required String bio,
  }) async {
    final currentState = state;
    if (currentState is! EditProfileReady) return;

    final profile = currentState.profile.copyWith(
      fullNameKey: fullName.trim(),
      headlineKey: headline.trim(),
      emailKey: email.trim(),
      locationKey: location.trim(),
      bioKey: bio.trim(),
    );

    if (!_isValid(profile)) {
      emit(const EditProfileError(messageKey: 'profile.editValidationError'));
      emit(currentState);
      return;
    }

    emit(currentState.copyWith(isSubmitting: true));
    final result = await _updateProfileUseCase(profile);
    result.fold(
      (failure) => emit(EditProfileError(messageKey: failure.message)),
      (updatedProfile) {
        emit(EditProfileSaved(profile: updatedProfile));
        emit(EditProfileReady(profile: updatedProfile));
      },
    );
  }

  bool _isValid(Profile profile) {
    return profile.fullNameKey.trim().isNotEmpty &&
        profile.headlineKey.trim().isNotEmpty &&
        profile.emailKey.trim().contains('@');
  }
}
