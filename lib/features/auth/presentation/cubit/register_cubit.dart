import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, status: RegisterStatus.initial));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, status: RegisterStatus.initial));

  void togglePasswordVisibility() =>
      emit(state.copyWith(passwordVisible: !state.passwordVisible));

  Future<void> register({
    required String email,
    required String password,
  }) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(status: RegisterStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

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
