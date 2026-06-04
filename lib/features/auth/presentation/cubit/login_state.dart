part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String email;
  final String password;
  final bool passwordVisible;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.email = '',
    this.password = '',
    this.passwordVisible = false,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    bool? passwordVisible,
    String? errorMessage,
  }) =>
      LoginState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        errorMessage: errorMessage,
      );

  bool get isLoading => status == LoginStatus.loading;
  bool get canSubmit => email.isNotEmpty && password.length >= 6;

  @override
  List<Object?> get props =>
      [status, email, password, passwordVisible, errorMessage];
}