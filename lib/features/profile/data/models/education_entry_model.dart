import '../../domain/entities/education_entry.dart';

class EducationEntryModel {
  const EducationEntryModel({
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
  final String? startDate;
  final String? endDate;
  final bool isCurrent;
  final String? grade;
  final String? description;
  final int displayOrder;

  factory EducationEntryModel.fromJson(Map<String, dynamic> json) {
    return EducationEntryModel(
      id: json['id'] as String? ?? '',
      profileId: json['profile_id'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      degree: json['degree'] as String?,
      fieldOfStudy: json['field_of_study'] as String?,
      educationLevelId: json['education_level_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      isCurrent: (json['is_current'] as bool?) ?? false,
      grade: json['grade'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 0,
    );
  }

  EducationEntry toEntity() {
    return EducationEntry(
      id: id,
      profileId: profileId,
      institution: institution,
      degree: degree,
      fieldOfStudy: fieldOfStudy,
      educationLevelId: educationLevelId,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      grade: grade,
      description: description,
      displayOrder: displayOrder,
    );
  }

  /// Serializes only the provided (non-null) fields for create/update.
  static Map<String, dynamic> inputToJson(EducationInput input) {
    final map = <String, dynamic>{};
    if (input.institution != null) map['institution'] = input.institution;
    if (input.degree != null) map['degree'] = input.degree;
    if (input.fieldOfStudy != null) map['field_of_study'] = input.fieldOfStudy;
    if (input.startDate != null) map['start_date'] = input.startDate;
    if (input.endDate != null) map['end_date'] = input.endDate;
    if (input.grade != null) map['grade'] = input.grade;
    if (input.description != null) map['description'] = input.description;
    return map;
  }
}
