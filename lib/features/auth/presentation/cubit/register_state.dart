import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String email;
  final String password;
  final bool passwordVisible;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.email = '',
    this.password = '',
    this.passwordVisible = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? email,
    String? password,
    bool? passwordVisible,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading => status == RegisterStatus.loading;
  bool get isSuccess => status == RegisterStatus.success;
  bool get isFailure => status == RegisterStatus.failure;
  bool get canSubmit => email.isNotEmpty && password.length >= 6;

  @override
  List<Object?> get props =>
      [status, email, password, passwordVisible, errorMessage];
}
