class HomeUserEntity {
  final String name;
  final String? avatarUrl;
  final String? targetRole;

  const HomeUserEntity({
    required this.name,
    this.avatarUrl,
    this.targetRole,
  });
}

class HomeRoadmapEntity {
  final String id;
  final String title;
  final int progress;
  final String status;

  const HomeRoadmapEntity({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
  });

  factory HomeRoadmapEntity.fromJson(Map<String, dynamic> json) {
    return HomeRoadmapEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      progress: json['progress'] as int? ?? 0,
      status: json['status'] as String? ?? 'active',
    );
  }
}

class HomeJobMatchEntity {
  final String jobId;
  final String jobTitle;
  final String company;
  final int matchPercentage;
  final String? salaryRange;
  final bool isRemote;

  const HomeJobMatchEntity({
    required this.jobId,
    required this.jobTitle,
    required this.company,
    required this.matchPercentage,
    this.salaryRange,
    this.isRemote = false,
  });

  factory HomeJobMatchEntity.fromJson(Map<String, dynamic> json) {
    final job = json['job'] as Map<String, dynamic>? ?? json;
    return HomeJobMatchEntity(
      jobId: json['job_id'] as String? ?? job['id'] as String? ?? '',
      jobTitle: job['title'] as String? ?? '',
      company: job['company'] as String? ?? '',
      matchPercentage: json['match_percentage'] as int? ?? 0,
      salaryRange: job['salary_range'] as String?,
      isRemote: (job['employment_type'] as String?)
          ?.toLowerCase()
          .contains('remote') ??
          false,
    );
  }
}

class HomeSummaryEntity {
  final HomeUserEntity user;
  final int? cvScore;
  final String? analyzedRole;
  final List<String> missingSkills;
  final HomeRoadmapEntity? roadmap;
  final List<HomeJobMatchEntity> jobMatches;

  const HomeSummaryEntity({
    required this.user,
    this.cvScore,
    this.analyzedRole,
    this.missingSkills = const [],
    this.roadmap,
    this.jobMatches = const [],
  });
}