import 'package:equatable/equatable.dart';

class HomeUserEntity extends Equatable {
  const HomeUserEntity({required this.name, this.avatarUrl, this.targetRole});

  final String name;
  final String? avatarUrl;
  final String? targetRole;

  @override
  List<Object?> get props => [name, avatarUrl, targetRole];
}

class HomeRoadmapEntity extends Equatable {
  const HomeRoadmapEntity({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
  });

  final String id;
  final String title;
  final int progress;
  final String status;

  @override
  List<Object?> get props => [id, title, progress, status];
}

class HomeJobMatchEntity extends Equatable {
  const HomeJobMatchEntity({
    required this.jobId,
    required this.jobTitle,
    required this.company,
    required this.matchPercentage,
    this.salaryRange,
    this.isRemote = false,
  });

  final String jobId;
  final String jobTitle;
  final String company;
  final int matchPercentage;
  final String? salaryRange;
  final bool isRemote;

  @override
  List<Object?> get props => [
        jobId,
        jobTitle,
        company,
        matchPercentage,
        salaryRange,
        isRemote,
      ];
}

class HomeSummaryEntity extends Equatable {
  const HomeSummaryEntity({
    required this.user,
    this.cvScore,
    this.analyzedRole,
    this.missingSkills = const [],
    this.roadmap,
    this.jobMatches = const [],
  });

  final HomeUserEntity user;
  final int? cvScore;
  final String? analyzedRole;
  final List<String> missingSkills;
  final HomeRoadmapEntity? roadmap;
  final List<HomeJobMatchEntity> jobMatches;

  @override
  List<Object?> get props => [
        user,
        cvScore,
        analyzedRole,
        missingSkills,
        roadmap,
        jobMatches,
      ];
}
