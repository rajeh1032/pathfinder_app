import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, status: LoginStatus.initial));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, status: LoginStatus.initial));

  void togglePasswordVisibility() =>
      emit(state.copyWith(passwordVisible: !state.passwordVisible));

  Future<void> loginWithEmail() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(status: LoginStatus.loading));

    // TODO: wire up to auth use case / repository
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success — replace with real result handling
    emit(state.copyWith(status: LoginStatus.success));
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));

    // TODO: wire up to Google sign-in use case
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: LoginStatus.success));
  }
}