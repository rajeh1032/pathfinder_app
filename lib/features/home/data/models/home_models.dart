import '../../domain/entites/home_entity.dart';

class HomeRoadmapModel {
  const HomeRoadmapModel({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
  });

  final String id;
  final String title;
  final int progress;
  final String status;

  factory HomeRoadmapModel.fromJson(Map<String, dynamic> json) {
    return HomeRoadmapModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      progress: (json['progress'] as num?)?.round() ?? 0,
      status: json['status'] as String? ?? 'active',
    );
  }

  HomeRoadmapEntity toEntity() => HomeRoadmapEntity(
        id: id,
        title: title,
        progress: progress,
        status: status,
      );
}

class HomeJobMatchModel {
  const HomeJobMatchModel({
    required this.jobId,
    required this.jobTitle,
    required this.company,
    required this.matchPercentage,
    this.salaryRange,
    required this.isRemote,
    this.imageUrl,
  });

  final String jobId;
  final String jobTitle;
  final String company;
  final int matchPercentage;
  final String? salaryRange;
  final bool isRemote;
  final String? imageUrl;

  factory HomeJobMatchModel.fromJson(Map<String, dynamic> json) {
    final job = switch (json) {
      {'jobs': final Map<String, dynamic> jobs} => jobs,
      {'job': final Map<String, dynamic> job} => job,
      _ => json,
    };
    final location = job['location']?.toString() ?? '';

    return HomeJobMatchModel(
      jobId: json['job_id']?.toString() ?? job['id']?.toString() ?? '',
      jobTitle: job['title']?.toString() ?? '',
      company: job['company']?.toString() ?? '',
      matchPercentage: (json['match_percentage'] as num?)?.round() ?? 0,
      salaryRange: job['salary_range']?.toString(),
      isRemote: job['is_remote'] as bool? ??
          location.toLowerCase().contains('remote'),
      imageUrl: job['thumbnail_url']?.toString() ??
          job['company_logo_url']?.toString(),
    );
  }

  HomeJobMatchEntity toEntity() => HomeJobMatchEntity(
        jobId: jobId,
        jobTitle: jobTitle,
        company: company,
        matchPercentage: matchPercentage,
        salaryRange: salaryRange,
        isRemote: isRemote,
        imageUrl: imageUrl,
      );
}
