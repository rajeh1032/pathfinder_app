import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/course_enrollment.dart';
import '../../domain/entities/course_mutation.dart';
import '../../domain/entities/courses_page.dart';
import '../../domain/entities/courses_query.dart';
import '../../domain/repositories/courses_repository.dart';
import '../data_sources/remote/courses_remote_data_source.dart';

@LazySingleton(as: CoursesRepository)
class CoursesRepositoryImpl implements CoursesRepository {
  const CoursesRepositoryImpl(this._remote, this._networkInfo);

  final CoursesRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, CoursesPage>> getCourses(CoursesQuery query) =>
      _execute(() async => (await _remote.getCourses(query)).toEntity());

  @override
  Future<Either<Failure, Course>> getCourseDetails(String courseId) => _execute(
      () async => (await _remote.getCourseDetails(courseId)).toEntity());

  @override
  Future<Either<Failure, RecommendedCoursesResult>> getRecommendedCourses(
    int limit,
  ) =>
      _execute(
        () async => (await _remote.getRecommendedCourses(limit)).toEntity(),
      );

  @override
  Future<Either<Failure, CoursesPage>> getSavedCourses(int page, int limit) =>
      _execute(
          () async => (await _remote.getSavedCourses(page, limit)).toEntity());

  @override
  Future<Either<Failure, CoursesPage>> getEnrollments(int page, int limit) =>
      _execute(
          () async => (await _remote.getEnrollments(page, limit)).toEntity());

  @override
  Future<Either<Failure, SavedCourseResult>> saveCourse(String courseId) =>
      _execute(() async => (await _remote.saveCourse(courseId)).toEntity());

  @override
  Future<Either<Failure, SavedCourseResult>> unsaveCourse(String courseId) =>
      _execute(() async => (await _remote.unsaveCourse(courseId)).toEntity());

  @override
  Future<Either<Failure, EnrollmentMutationResult>> enrollCourse(
    String courseId,
  ) =>
      _execute(() async => (await _remote.enrollCourse(courseId)).toEntity());

  @override
  Future<Either<Failure, EnrollmentMutationResult>> updateEnrollment(
    String courseId, {
    int? progress,
    EnrollmentStatus? status,
  }) =>
      _execute(
        () async => (await _remote.updateEnrollment(
          courseId,
          progress: progress,
          status: status,
        ))
            .toEntity(),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }
    try {
      return Right(await action());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException {
      return const Left(ServerFailure(ErrorMessages.server));
    }
  }
}
