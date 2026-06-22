import '../../domain/entities/work_experience.dart';

class WorkExperienceModel {
  const WorkExperienceModel({
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
  final String? startDate;
  final String? endDate;
  final bool isCurrent;
  final String? description;
  final List<String> skills;
  final int displayOrder;

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      id: json['id'] as String? ?? '',
      profileId: json['profile_id'] as String? ?? '',
      jobTitle: json['job_title'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      employmentType: json['employment_type'] as String?,
      location: json['location'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      isCurrent: (json['is_current'] as bool?) ?? false,
      description: json['description'] as String?,
      skills: (json['skills'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 0,
    );
  }

  WorkExperience toEntity() {
    return WorkExperience(
      id: id,
      profileId: profileId,
      jobTitle: jobTitle,
      companyName: companyName,
      employmentType: employmentType,
      location: location,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
      skills: skills,
      displayOrder: displayOrder,
    );
  }

  /// Serializes only the provided (non-null) fields so PATCH can send a
  /// partial subset. When [isCurrent] is true, `end_date` is forced to null.
  static Map<String, dynamic> inputToJson(WorkExperienceInput input) {
    final map = <String, dynamic>{};
    if (input.jobTitle != null) map['job_title'] = input.jobTitle;
    if (input.companyName != null) map['company_name'] = input.companyName;
    if (input.employmentType != null) {
      map['employment_type'] = input.employmentType;
    }
    if (input.location != null) map['location'] = input.location;
    if (input.startDate != null) map['start_date'] = input.startDate;
    if (input.isCurrent != null) map['is_current'] = input.isCurrent;
    if (input.description != null) map['description'] = input.description;
    if (input.skills != null) map['skills'] = input.skills;
    if (input.displayOrder != null) map['display_order'] = input.displayOrder;

    // Never send end_date when the role is current.
    if (input.isCurrent == true) {
      map['end_date'] = null;
    } else if (input.endDate != null) {
      map['end_date'] = input.endDate;
    }
    return map;
  }
}
