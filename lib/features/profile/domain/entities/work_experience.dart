import 'package:equatable/equatable.dart';

/// A single work/training experience (table `profile_experiences`).
class WorkExperience extends Equatable {
  const WorkExperience({
    required this.id,
    required this.profileId,
    required this.jobTitle,
    required this.companyName,
    this.employmentType,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.description,
    this.skills = const [],
    this.displayOrder = 0,
  });

  final String id;
  final String profileId;
  final String jobTitle;
  final String companyName;
  final String? employmentType;
  final String? location;
  final String? startDate; // 'YYYY-MM-DD'
  final String? endDate; // 'YYYY-MM-DD'
  final bool isCurrent;
  final String? description;
  final List<String> skills;
  final int displayOrder;

  @override
  List<Object?> get props => [
        id,
        profileId,
        jobTitle,
        companyName,
        employmentType,
        location,
        startDate,
        endDate,
        isCurrent,
        description,
        skills,
        displayOrder,
      ];
}

/// Write payload for creating/updating an experience. Only non-null fields
/// are serialized so PATCH can send a partial subset.
class WorkExperienceInput extends Equatable {
  const WorkExperienceInput({
    this.jobTitle,
    this.companyName,
    this.employmentType,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
    this.skills,
    this.displayOrder,
  });

  final String? jobTitle;
  final String? companyName;
  final String? employmentType;
  final String? location;
  final String? startDate;
  final String? endDate;
  final bool? isCurrent;
  final String? description;
  final List<String>? skills;
  final int? displayOrder;

  @override
  List<Object?> get props => [
        jobTitle,
        companyName,
        employmentType,
        location,
        startDate,
        endDate,
        isCurrent,
        description,
        skills,
        displayOrder,
      ];
}
