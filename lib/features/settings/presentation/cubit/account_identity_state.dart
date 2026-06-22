import 'package:equatable/equatable.dart';

enum AccountIdentityStatus { initial, loading, success, failure }

/// Real account identity shown in the settings header: the user's name,
/// target career path title and email (decoded from the access token).
class AccountIdentityState extends Equatable {
  const AccountIdentityState({
    this.status = AccountIdentityStatus.initial,
    this.name,
    this.careerPath,
    this.email,
  });

  final AccountIdentityStatus status;
  final String? name;
  final String? careerPath;
  final String? email;

  bool get isSuccess => status == AccountIdentityStatus.success;

  AccountIdentityState copyWith({
    AccountIdentityStatus? status,
    String? name,
    String? careerPath,
    String? email,
  }) {
    return AccountIdentityState(
      status: status ?? this.status,
      name: name ?? this.name,
      careerPath: careerPath ?? this.careerPath,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, name, careerPath, email];
}
