import 'package:equatable/equatable.dart';

enum RoadmapStepStatus { completed, inProgress, upcoming }

class Roadmap extends Equatable {
  const Roadmap({
    required this.id,
    required this.title,
    required this.description,
    required this.label,
    required this.estimatedDuration,
    required this.progress,
    required this.sections,
    required this.insights,
    this.nextStep,
  });

  final String id;
  final String title;
  final String description;
  final String label;
  final String estimatedDuration;
  final int progress;
  final String? nextStep;
  final List<RoadmapSection> sections;
  final RoadmapInsights insights;

  Iterable<RoadmapStep> get steps => sections.expand((section) => section.items);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        label,
        estimatedDuration,
        progress,
        nextStep,
        sections,
        insights,
      ];
}

class RoadmapSection extends Equatable {
  const RoadmapSection({
    required this.title,
    required this.status,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final RoadmapStepStatus status;
  final String subtitle;
  final List<RoadmapStep> items;

  @override
  List<Object?> get props => [title, status, subtitle, items];
}

class RoadmapStep extends Equatable {
  const RoadmapStep({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.isCompleted,
    required this.duration,
    required this.level,
    required this.isAiRecommended,
    required this.recommendedCourses,
    this.completedAt,
  });

  final String id;
  final String title;
  final String description;
  final RoadmapStepStatus status;
  final int progress;
  final bool isCompleted;
  final DateTime? completedAt;
  final String duration;
  final String level;
  final bool isAiRecommended;
  final List<RoadmapCourse> recommendedCourses;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        progress,
        isCompleted,
        completedAt,
        duration,
        level,
        isAiRecommended,
        recommendedCourses,
      ];
}

class RoadmapCourse extends Equatable {
  const RoadmapCourse({
    required this.id,
    required this.title,
    required this.provider,
    this.url,
    this.thumbnailUrl,
    this.videoUrl,
    this.duration,
    this.level,
  });

  final String id;
  final String title;
  final String provider;
  final String? url;
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? duration;
  final String? level;

  @override
  List<Object?> get props => [
        id,
        title,
        provider,
        url,
        thumbnailUrl,
        videoUrl,
        duration,
        level,
      ];
}

class RoadmapInsights extends Equatable {
  const RoadmapInsights({
    required this.projectedSalaryIncrease,
    required this.matchingSeniorRoles,
  });

  final int projectedSalaryIncrease;
  final int matchingSeniorRoles;

  bool get isMeaningful =>
      projectedSalaryIncrease > 0 || matchingSeniorRoles > 0;

  @override
  List<Object?> get props => [projectedSalaryIncrease, matchingSeniorRoles];
}
