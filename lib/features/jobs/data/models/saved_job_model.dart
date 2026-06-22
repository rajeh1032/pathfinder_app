import '../../domain/entities/saved_job.dart';

class SavedJobModel {
  const SavedJobModel({
    required this.id,
    required this.title,
    this.company,
    this.location,
    this.jobType,
    this.logoUrl,
  });

  final String id;
  final String title;
  final String? company;
  final String? location;
  final String? jobType;
  final String? logoUrl;

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    // Some backends wrap the saved row as { job: {...}, saved_at }.
    final job = json['job'];
    final source = job is Map<String, dynamic> ? job : json;

    return SavedJobModel(
      id: _read(source, ['id', '_id', 'job_id', 'jobId']) ?? '',
      title: _read(source, ['title', 'job_title', 'jobTitle', 'name']) ?? '',
      company: _read(
        source,
        ['company_name', 'companyName', 'company', 'organization'],
      ),
      location: _read(source, ['location', 'city', 'address']),
      jobType: _read(
        source,
        ['employment_type', 'employmentType', 'job_type', 'jobType', 'type'],
      ),
      logoUrl: _read(
        source,
        ['logo_url', 'logoUrl', 'company_logo', 'companyLogo', 'logo'],
      ),
    );
  }

  SavedJob toEntity() => SavedJob(
        id: id,
        title: title,
        company: company,
        location: location,
        jobType: jobType,
        logoUrl: logoUrl,
      );

  static String? _read(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }
}
