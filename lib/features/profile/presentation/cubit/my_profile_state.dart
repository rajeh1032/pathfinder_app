import 'package:equatable/equatable.dart';

import '../../domain/entities/education_entry.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/work_experience.dart';

enum MyProfileStatus { initial, loading, success, failure }

class MyProfileState extends Equatable {
  const MyProfileState({
    this.status = MyProfileStatus.initial,
    this.profile,
    this.experiences = const [],
    this.education = const [],
    this.isSaving = false,
    this.errorMessage,
  });

  final MyProfileStatus status;
  final UserProfile? profile;
  final List<WorkExperience> experiences;
  final List<EducationEntry> education;
  final bool isSaving;
  final String? errorMessage;

  bool get isLoading => status == MyProfileStatus.loading;
  bool get isSuccess => status == MyProfileStatus.success;
  bool get isFailure => status == MyProfileStatus.failure;

  MyProfileState copyWith({
    MyProfileStatus? status,
    UserProfile? profile,
    List<WorkExperience>? experiences,
    List<EducationEntry>? education,
    bool? isSaving,
    String? errorMessage,
  }) {
    return MyProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profile,
        experiences,
        education,
        isSaving,
        errorMessage,
      ];
}
