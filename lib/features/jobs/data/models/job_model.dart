import '../../domain/entities/job.dart';

class JobModel extends Job {
  const JobModel({
    required super.id,
    required super.title,
    required super.company,
    required super.location,
    required super.description,
    required super.requiredSkills,
    super.applyUrl,
    super.salaryRange,
    super.level,
    super.category,
    super.employmentType,
    super.companyLogoUrl,
    super.thumbnailUrl,
    super.certificateProvider,
    super.duration,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: _string(json['id']),
      title: _string(json['title'], fallback: 'Untitled Job'),
      company: _string(json['company'], fallback: 'Unknown Company'),
      location: _string(json['location'], fallback: 'Remote'),
      description: _string(json['description']),
      requiredSkills: _stringList(json['required_skills']),
      applyUrl: _nullableString(json['apply_url']),
      salaryRange: _nullableString(json['salary_range']),
      level: _nullableString(json['level']),
      category: _nullableString(json['category']),
      employmentType: _nullableString(json['employment_type']),
      companyLogoUrl: _nullableString(json['company_logo_url']),
      thumbnailUrl: _nullableString(json['thumbnail_url']),
      certificateProvider: _nullableString(json['certificate_provider']),
      duration: _nullableString(json['duration']),
    );
  }
}

String _string(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString();
  return text.isEmpty ? fallback : text;
}

String? _nullableString(Object? value) {
  if (value == null) return null;
  final text = value.toString();
  return text.isEmpty ? null : text;
}

List<String> _stringList(Object? value) {
  if (value is List) {
    return value
        .map((item) => item.toString())
        .where((item) => item.trim().isNotEmpty)
        .toList();
  }
  return const [];
}
