import 'package:equatable/equatable.dart';

class Job extends Equatable {
  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.requiredSkills,
    this.applyUrl,
    this.salaryRange,
    this.level,
    this.category,
    this.employmentType,
    this.companyLogoUrl,
    this.thumbnailUrl,
    this.certificateProvider,
    this.duration,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final List<String> requiredSkills;
  final String? applyUrl;
  final String? salaryRange;
  final String? level;
  final String? category;
  final String? employmentType;
  final String? companyLogoUrl;
  final String? thumbnailUrl;
  final String? certificateProvider;
  final String? duration;

  @override
  List<Object?> get props => [
        id,
        title,
        company,
        location,
        description,
        requiredSkills,
        applyUrl,
        salaryRange,
        level,
        category,
        employmentType,
        companyLogoUrl,
        thumbnailUrl,
        certificateProvider,
        duration,
      ];
}
