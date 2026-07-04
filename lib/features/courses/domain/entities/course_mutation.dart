import 'package:equatable/equatable.dart';

import 'course_enrollment.dart';

class SavedCourseResult extends Equatable {
  const SavedCourseResult({
    required this.courseId,
    required this.isSaved,
    this.alreadySaved,
    this.wasSaved,
  });

  final String courseId;
  final bool isSaved;
  final bool? alreadySaved;
  final bool? wasSaved;

  @override
  List<Object?> get props => [courseId, isSaved, alreadySaved, wasSaved];
}

class EnrollmentMutationResult extends Equatable {
  const EnrollmentMutationResult({
    required this.courseId,
    required this.enrollment,
    this.alreadyEnrolled,
  });

  final String courseId;
  final CourseEnrollment enrollment;
  final bool? alreadyEnrolled;

  @override
  List<Object?> get props => [courseId, enrollment, alreadyEnrolled];
}
