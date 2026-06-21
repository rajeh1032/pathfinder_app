import 'package:equatable/equatable.dart';

enum EnrollmentStatus { active, paused, completed, cancelled }

class CourseEnrollment extends Equatable {
  const CourseEnrollment({
    required this.id,
    required this.status,
    required this.progress,
    this.enrolledAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final EnrollmentStatus status;
  final int progress;
  final DateTime? enrolledAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        status,
        progress,
        enrolledAt,
        completedAt,
        createdAt,
        updatedAt,
      ];
}
