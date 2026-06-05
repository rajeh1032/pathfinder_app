import 'package:equatable/equatable.dart';

enum RoadmapStepStatus { completed, inProgress, upcoming }

class Roadmap extends Equatable {
  const Roadmap({
    required this.id,
    required this.titleKey,
    required this.typeKey,
    required this.durationKey,
    required this.progressLabelKey,
    required this.progressValue,
    required this.steps,
  });

  final String id;
  final String titleKey;
  final String typeKey;
  final String durationKey;
  final String progressLabelKey;
  final double progressValue;
  final List<RoadmapStep> steps;

  Roadmap copyWith({
    String? id,
    String? titleKey,
    String? typeKey,
    String? durationKey,
    String? progressLabelKey,
    double? progressValue,
    List<RoadmapStep>? steps,
  }) {
    return Roadmap(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      typeKey: typeKey ?? this.typeKey,
      durationKey: durationKey ?? this.durationKey,
      progressLabelKey: progressLabelKey ?? this.progressLabelKey,
      progressValue: progressValue ?? this.progressValue,
      steps: steps ?? this.steps,
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleKey,
        typeKey,
        durationKey,
        progressLabelKey,
        progressValue,
        steps,
      ];
}

class RoadmapStep extends Equatable {
  const RoadmapStep({
    required this.id,
    required this.titleKey,
    required this.bodyKey,
    required this.status,
    this.hasRecommendedCourse = false,
  });

  final String id;
  final String titleKey;
  final String bodyKey;
  final RoadmapStepStatus status;
  final bool hasRecommendedCourse;

  RoadmapStep copyWith({RoadmapStepStatus? status}) {
    return RoadmapStep(
      id: id,
      titleKey: titleKey,
      bodyKey: bodyKey,
      status: status ?? this.status,
      hasRecommendedCourse: hasRecommendedCourse,
    );
  }

  @override
  List<Object?> get props =>
      [id, titleKey, bodyKey, status, hasRecommendedCourse];
}
