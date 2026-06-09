import 'package:equatable/equatable.dart';

enum SetupProfileStatus { initial, loading, success, failure }

class SetupProfileState extends Equatable {
  final int currentStep;

  // Step 1 – Basic Info
  final String fullName;
  final String location;
  final String yearsOfExperience;

  // Step 2 – Education
  final String degreeLevel;
  final String university;
  final String major;

  // Step 3 – Career Goal
  final String targetJobTitle;
  final String currentStatus; // e.g. "Actively Looking"

  final SetupProfileStatus status;
  final String? errorMessage;

  const SetupProfileState({
    this.currentStep = 0,
    this.fullName = '',
    this.location = '',
    this.yearsOfExperience = '',
    this.degreeLevel = '',
    this.university = '',
    this.major = '',
    this.targetJobTitle = '',
    this.currentStatus = '',
    this.status = SetupProfileStatus.initial,
    this.errorMessage,
  });

  bool get isLoading => status == SetupProfileStatus.loading;
  bool get isSuccess => status == SetupProfileStatus.success;
  bool get isFailure => status == SetupProfileStatus.failure;
  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == 2;
  bool get canSubmit =>
      fullName.isNotEmpty &&
      location.isNotEmpty &&
      yearsOfExperience.isNotEmpty &&
      degreeLevel.isNotEmpty &&
      university.isNotEmpty &&
      major.isNotEmpty &&
      targetJobTitle.isNotEmpty &&
      currentStatus.isNotEmpty;

  SetupProfileState copyWith({
    int? currentStep,
    String? fullName,
    String? location,
    String? yearsOfExperience,
    String? degreeLevel,
    String? university,
    String? major,
    String? targetJobTitle,
    String? currentStatus,
    SetupProfileStatus? status,
    String? errorMessage,
  }) {
    return SetupProfileState(
      currentStep: currentStep ?? this.currentStep,
      fullName: fullName ?? this.fullName,
      location: location ?? this.location,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      degreeLevel: degreeLevel ?? this.degreeLevel,
      university: university ?? this.university,
      major: major ?? this.major,
      targetJobTitle: targetJobTitle ?? this.targetJobTitle,
      currentStatus: currentStatus ?? this.currentStatus,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        fullName,
        location,
        yearsOfExperience,
        degreeLevel,
        university,
        major,
        targetJobTitle,
        currentStatus,
        status,
        errorMessage,
      ];
}
