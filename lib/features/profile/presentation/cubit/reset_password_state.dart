import 'package:equatable/equatable.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordSubmitting extends ResetPasswordState {
  const ResetPasswordSubmitting();
}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}
