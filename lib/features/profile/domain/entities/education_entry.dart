import 'package:equatable/equatable.dart';

/// A single education record (table `profile_education`).
class EducationEntry extends Equatable {
  const EducationEntry({
    required this.id,
    required this.profileId,
    required this.institution,
    this.degree,
    this.fieldOfStudy,
    this.educationLevelId,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.grade,
    this.description,
    this.displayOrder = 0,
  });

  final String id;
  final String profileId;
  final String institution;
  final String? degree;
  final String? fieldOfStudy;
  final String? educationLevelId;
  final String? startDate; // 'YYYY-MM-DD'
  final String? endDate; // 'YYYY-MM-DD'
  final bool isCurrent;
  final String? grade;
  final String? description;
  final int displayOrder;

  @override
  List<Object?> get props => [
        id,
        profileId,
        institution,
        degree,
        fieldOfStudy,
        educationLevelId,
        startDate,
        endDate,
        isCurrent,
        grade,
        description,
        displayOrder,
      ];
}

/// Write payload for creating/updating an education record.
class EducationInput extends Equatable {
  const EducationInput({
    this.institution,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.grade,
    this.description,
  });

  final String? institution;
  final String? degree;
  final String? fieldOfStudy;
  final String? startDate;
  final String? endDate;
  final String? grade;
  final String? description;

  @override
  List<Object?> get props => [
        institution,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        grade,
        description,
      ];
}
