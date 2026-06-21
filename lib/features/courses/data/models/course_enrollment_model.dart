import '../../domain/entities/course_enrollment.dart';
import 'course_model_parsing.dart';

class CourseEnrollmentModel {
  const CourseEnrollmentModel({
    required this.id,
    required this.status,
    required this.progress,
    this.enrolledAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseEnrollmentModel.fromJson(Map<String, dynamic> json) {
    final progress = requiredInt(json, 'progress', min: 0);
    if (progress > 100) throw const FormatException('Invalid progress');
    return CourseEnrollmentModel(
      id: requiredString(json, 'id'),
      status: _status(requiredString(json, 'status')),
      progress: progress,
      enrolledAt: nullableDate(json['enrolledAt']),
      completedAt: nullableDate(json['completedAt']),
      createdAt: nullableDate(json['createdAt']),
      updatedAt: nullableDate(json['updatedAt']),
    );
  }

  final String id;
  final EnrollmentStatus status;
  final int progress;
  final DateTime? enrolledAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CourseEnrollment toEntity() => CourseEnrollment(
        id: id,
        status: status,
        progress: progress,
        enrolledAt: enrolledAt,
        completedAt: completedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static EnrollmentStatus _status(String value) => switch (value) {
        'active' => EnrollmentStatus.active,
        'paused' => EnrollmentStatus.paused,
        'completed' => EnrollmentStatus.completed,
        'cancelled' => EnrollmentStatus.cancelled,
        _ => throw const FormatException('Invalid enrollment status'),
      };
}
