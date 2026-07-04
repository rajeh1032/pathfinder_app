import '../../domain/entities/course_mutation.dart';
import 'course_enrollment_model.dart';
import 'course_model_parsing.dart';

class SavedCourseResultModel {
  const SavedCourseResultModel({
    required this.courseId,
    required this.isSaved,
    this.alreadySaved,
    this.wasSaved,
  });

  factory SavedCourseResultModel.fromJson(Map<String, dynamic> json) {
    final alreadySaved = json['alreadySaved'];
    final wasSaved = json['wasSaved'];
    if (alreadySaved != null && alreadySaved is! bool) {
      throw const FormatException('Invalid alreadySaved');
    }
    if (wasSaved != null && wasSaved is! bool) {
      throw const FormatException('Invalid wasSaved');
    }
    return SavedCourseResultModel(
      courseId: requiredString(json, 'courseId'),
      isSaved: requiredBool(json, 'isSaved'),
      alreadySaved: alreadySaved as bool?,
      wasSaved: wasSaved as bool?,
    );
  }

  final String courseId;
  final bool isSaved;
  final bool? alreadySaved;
  final bool? wasSaved;

  SavedCourseResult toEntity() => SavedCourseResult(
        courseId: courseId,
        isSaved: isSaved,
        alreadySaved: alreadySaved,
        wasSaved: wasSaved,
      );
}

class EnrollmentMutationResultModel {
  const EnrollmentMutationResultModel({
    required this.courseId,
    required this.enrollment,
    this.alreadyEnrolled,
  });

  factory EnrollmentMutationResultModel.fromJson(Map<String, dynamic> json) {
    final already = json['alreadyEnrolled'];
    if (already != null && already is! bool) {
      throw const FormatException('Invalid alreadyEnrolled');
    }
    return EnrollmentMutationResultModel(
      courseId: requiredString(json, 'courseId'),
      enrollment: CourseEnrollmentModel.fromJson(
        requiredMap(json['enrollment'], 'enrollment'),
      ),
      alreadyEnrolled: already as bool?,
    );
  }

  final String courseId;
  final CourseEnrollmentModel enrollment;
  final bool? alreadyEnrolled;

  EnrollmentMutationResult toEntity() => EnrollmentMutationResult(
        courseId: courseId,
        enrollment: enrollment.toEntity(),
        alreadyEnrolled: alreadyEnrolled,
      );
}
