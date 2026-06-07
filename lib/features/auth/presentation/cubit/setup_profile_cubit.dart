import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'setup_profile_state.dart';

@injectable
class SetupProfileCubit extends Cubit<SetupProfileState> {
  SetupProfileCubit() : super(const SetupProfileState());

  // ─── Step 1 field updates ─────────────────────────────────────────────────

  void updateFullName(String value) =>
      emit(state.copyWith(fullName: value, status: SetupProfileStatus.initial));

  void updateLocation(String value) =>
      emit(state.copyWith(location: value, status: SetupProfileStatus.initial));

  void updateYearsOfExperience(String value) => emit(state.copyWith(
      yearsOfExperience: value, status: SetupProfileStatus.initial));

  // ─── Step 2 field updates ─────────────────────────────────────────────────

  void updateDegreeLevel(String value) => emit(
      state.copyWith(degreeLevel: value, status: SetupProfileStatus.initial));

  void updateUniversity(String value) => emit(
      state.copyWith(university: value, status: SetupProfileStatus.initial));

  void updateMajor(String value) =>
      emit(state.copyWith(major: value, status: SetupProfileStatus.initial));

  // ─── Step 3 field updates ─────────────────────────────────────────────────

  void updateTargetJobTitle(String value) => emit(state.copyWith(
      targetJobTitle: value, status: SetupProfileStatus.initial));

  void updateCurrentStatus(String value) => emit(
      state.copyWith(currentStatus: value, status: SetupProfileStatus.initial));

  // ─── Navigation ───────────────────────────────────────────────────────────

  void nextStep() {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void goToStep(int step) {
    assert(step >= 0 && step <= 2, 'Step must be between 0 and 2');
    emit(state.copyWith(currentStep: step));
  }

  // ─── Submit ───────────────────────────────────────────────────────────────

  Future<void> submit() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: SetupProfileStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: SetupProfileStatus.success));
  }

  void resetError() => emit(state.copyWith(status: SetupProfileStatus.initial));

  void resetState() => emit(const SetupProfileState());
}
