import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'register_state.dart';

// Factory (not lazySingleton) so each visit to the register screen gets a
// fresh instance and stale email/password from a previous attempt can't leak
// into SetupProfileCubit.
@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, status: RegisterStatus.initial));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, status: RegisterStatus.initial));

  void confirmPasswordChanged(String value) => emit(
      state.copyWith(confirmPassword: value, status: RegisterStatus.initial));

  void togglePasswordVisibility() =>
      emit(state.copyWith(passwordVisible: !state.passwordVisible));

  /// Syncs all three credential fields then advances to the profile-setup
  /// screen. No API call happens here — the actual register request is sent
  /// by [SetupProfileCubit.submit] once the user completes all profile steps.
  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      status: RegisterStatus.initial,
    ));

    if (!state.canSubmit) return;

    emit(state.copyWith(status: RegisterStatus.loading));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(status: RegisterStatus.success));
  }

  Future<void> registerWithGoogle() async {
    emit(state.copyWith(status: RegisterStatus.loading));

    // TODO: wire up to Google sign-in use case
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: RegisterStatus.success));
  }

  void resetState() => emit(const RegisterState());
}
