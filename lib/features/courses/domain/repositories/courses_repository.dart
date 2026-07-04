import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course.dart';
import '../entities/course_enrollment.dart';
import '../entities/course_mutation.dart';
import '../entities/courses_page.dart';
import '../entities/courses_query.dart';

abstract class CoursesRepository {
  Future<Either<Failure, CoursesPage>> getCourses(CoursesQuery query);
  Future<Either<Failure, Course>> getCourseDetails(String courseId);
  Future<Either<Failure, RecommendedCoursesResult>> getRecommendedCourses(
    int limit,
  );
  Future<Either<Failure, CoursesPage>> getSavedCourses(int page, int limit);
  Future<Either<Failure, CoursesPage>> getEnrollments(int page, int limit);
  Future<Either<Failure, SavedCourseResult>> saveCourse(String courseId);
  Future<Either<Failure, SavedCourseResult>> unsaveCourse(String courseId);
  Future<Either<Failure, EnrollmentMutationResult>> enrollCourse(
    String courseId,
  );
  Future<Either<Failure, EnrollmentMutationResult>> updateEnrollment(
    String courseId, {
    int? progress,
    EnrollmentStatus? status,
  });
}
