import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  final bool passwordVisible;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.passwordVisible = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? email,
    String? password,
    String? confirmPassword,
    bool? passwordVisible,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading => status == RegisterStatus.loading;
  bool get isSuccess => status == RegisterStatus.success;
  bool get isFailure => status == RegisterStatus.failure;

  bool get canSubmit =>
      email.isNotEmpty && password.length >= 6 && password == confirmPassword;

  @override
  List<Object?> get props =>
      [status, email, password, confirmPassword, passwordVisible, errorMessage];
}
