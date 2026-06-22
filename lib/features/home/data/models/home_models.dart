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
  });

  final String jobId;
  final String jobTitle;
  final String company;
  final int matchPercentage;
  final String? salaryRange;
  final bool isRemote;

  factory HomeJobMatchModel.fromJson(Map<String, dynamic> json) {
    final job = json['job'] as Map<String, dynamic>? ?? json;
    return HomeJobMatchModel(
      jobId: json['job_id'] as String? ?? job['id'] as String? ?? '',
      jobTitle: job['title'] as String? ?? '',
      company: job['company'] as String? ?? '',
      matchPercentage: (json['match_percentage'] as num?)?.round() ?? 0,
      salaryRange: job['salary_range'] as String?,
      isRemote: job['is_remote'] as bool? ?? false,
    );
  }

  HomeJobMatchEntity toEntity() => HomeJobMatchEntity(
        jobId: jobId,
        jobTitle: jobTitle,
        company: company,
        matchPercentage: matchPercentage,
        salaryRange: salaryRange,
        isRemote: isRemote,
      );
}
