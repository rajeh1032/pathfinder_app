import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/course.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<Course>>> getCourses();

  Future<Either<Failure, Course>> getCourseDetails(String id);
}
