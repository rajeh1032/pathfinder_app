import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/reset_profile_password_use_case.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({
    required ResetProfilePasswordUseCase resetPasswordUseCase,
  })  : _resetPasswordUseCase = resetPasswordUseCase,
        super(const ResetPasswordInitial());

  final ResetProfilePasswordUseCase _resetPasswordUseCase;

  Future<void> submit({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword ||
        currentPassword.length < 6 ||
        newPassword.length < 8) {
      emit(const ResetPasswordError(
        messageKey: 'profile.passwordValidationError',
      ));
      emit(const ResetPasswordInitial());
      return;
    }

    emit(const ResetPasswordSubmitting());
    final result = await _resetPasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(ResetPasswordError(messageKey: failure.message)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }
}
