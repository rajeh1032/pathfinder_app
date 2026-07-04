import 'package:equatable/equatable.dart';

import '../../domain/entities/profile.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({
    required this.profile,
    this.savedCourseIds = const {},
    this.savedJobIds = const {},
  });

  final Profile profile;
  final Set<String> savedCourseIds;
  final Set<String> savedJobIds;

  ProfileSuccess copyWith({
    Profile? profile,
    Set<String>? savedCourseIds,
    Set<String>? savedJobIds,
  }) {
    return ProfileSuccess(
      profile: profile ?? this.profile,
      savedCourseIds: savedCourseIds ?? this.savedCourseIds,
      savedJobIds: savedJobIds ?? this.savedJobIds,
    );
  }

  @override
  List<Object?> get props => [profile, savedCourseIds, savedJobIds];
}

class ProfileEmpty extends ProfileState {
  const ProfileEmpty();
}

class ProfileError extends ProfileState {
  const ProfileError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}
