import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState());

  final LoginUseCase _loginUseCase;

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, status: LoginStatus.initial));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, status: LoginStatus.initial));

  void togglePasswordVisibility() =>
      emit(state.copyWith(passwordVisible: !state.passwordVisible));

  Future<void> loginWithEmail() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await _loginUseCase(
      email: state.email.trim(),
      password: state.password,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: LoginStatus.success));
  }
}
