import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_app/core/errors/failures.dart';
import 'package:pathfinder_app/features/courses/domain/entities/courses_page.dart';
import 'package:pathfinder_app/features/courses/domain/entities/courses_query.dart';
import 'package:pathfinder_app/features/courses/domain/repositories/courses_repository.dart';
import 'package:pathfinder_app/features/courses/domain/use_cases/get_courses_use_case.dart';
import 'package:pathfinder_app/features/courses/domain/use_cases/get_enrollments_use_case.dart';
import 'package:pathfinder_app/features/courses/domain/use_cases/get_recommended_courses_use_case.dart';
import 'package:pathfinder_app/features/courses/domain/use_cases/get_saved_courses_use_case.dart';
import 'package:pathfinder_app/features/courses/domain/use_cases/save_course_use_case.dart';
import 'package:pathfinder_app/features/courses/presentation/cubit/courses_catalog_cubit.dart';

void main() {
  test('does not emit when a pending load completes after close', () async {
    final repository = _PendingCoursesRepository();
    final cubit = CoursesCatalogCubit(
      GetCoursesUseCase(repository),
      GetRecommendedCoursesUseCase(repository),
      GetSavedCoursesUseCase(repository),
      GetEnrollmentsUseCase(repository),
      SaveCourseUseCase(repository),
      UnsaveCourseUseCase(repository),
    );

    final load = cubit.loadInitial();
    await cubit.close();
    repository.completeLoad();

    await expectLater(load, completes);
  });
}

class _PendingCoursesRepository implements CoursesRepository {
  final _loadCompleter = Completer<Either<Failure, CoursesPage>>();

  @override
  Future<Either<Failure, CoursesPage>> getCourses(CoursesQuery query) =>
      _loadCompleter.future;

  void completeLoad() {
    _loadCompleter.complete(const Right(CoursesPage(
      courses: [],
      pagination: Pagination(
        page: 1,
        limit: 20,
        totalItems: 0,
        totalPages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    )));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
