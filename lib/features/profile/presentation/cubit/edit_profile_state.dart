import 'package:equatable/equatable.dart';

import '../../domain/entities/profile.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

class EditProfileReady extends EditProfileState {
  const EditProfileReady({
    required this.profile,
    this.isSubmitting = false,
  });

  final Profile profile;
  final bool isSubmitting;

  EditProfileReady copyWith({
    Profile? profile,
    bool? isSubmitting,
  }) {
    return EditProfileReady(
      profile: profile ?? this.profile,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [profile, isSubmitting];
}

class EditProfileSaved extends EditProfileState {
  const EditProfileSaved({required this.profile});

  final Profile profile;

  @override
  List<Object?> get props => [profile];
}

class EditProfileError extends EditProfileState {
  const EditProfileError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}
