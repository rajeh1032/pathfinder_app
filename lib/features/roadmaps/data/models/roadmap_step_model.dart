import '../../domain/entities/roadmap.dart';
import 'model_parsing.dart';
import 'roadmap_course_model.dart';

class RoadmapStepModel {
  const RoadmapStepModel({
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

  factory RoadmapStepModel.fromJson(Map<String, dynamic> json) {
    final progress = requiredInt(json, 'progress', min: 0, max: 100);
    final isCompleted = json['isCompleted'];
    if (isCompleted is! bool || isCompleted != (progress == 100)) {
      throw const FormatException('Invalid step completion state');
    }
    final completedAtValue = nullableString(json['completedAt']);
    final completedAt = completedAtValue == null
        ? null
        : DateTime.tryParse(completedAtValue);
    if (completedAtValue != null && completedAt == null) {
      throw const FormatException('Invalid completedAt');
    }
    return RoadmapStepModel(
      id: requiredString(json, 'id'),
      title: requiredString(json, 'title'),
      description: requiredString(json, 'description'),
      status: stepStatusFromJson(json['status']),
      progress: progress,
      isCompleted: isCompleted,
      completedAt: completedAt,
      duration: requiredString(json, 'duration'),
      level: requiredString(json, 'level'),
      isAiRecommended: json['isAiRecommended'] is bool
          ? json['isAiRecommended'] as bool
          : false,
      recommendedCourses: mapList(json['recommendedCourses'], 'courses')
          .map(RoadmapCourseModel.fromJson)
          .toList(growable: false),
    );
  }

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
  final List<RoadmapCourseModel> recommendedCourses;

  RoadmapStep toEntity() => RoadmapStep(
        id: id,
        title: title,
        description: description,
        status: status,
        progress: progress,
        isCompleted: isCompleted,
        completedAt: completedAt,
        duration: duration,
        level: level,
        isAiRecommended: isAiRecommended,
        recommendedCourses: List.unmodifiable(
          recommendedCourses.map((course) => course.toEntity()),
        ),
      );
}
