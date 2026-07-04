import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/courses_page.dart';
import '../../domain/entities/courses_query.dart';
import '../../domain/use_cases/get_courses_use_case.dart';
import '../../domain/use_cases/get_enrollments_use_case.dart';
import '../../domain/use_cases/get_recommended_courses_use_case.dart';
import '../../domain/use_cases/get_saved_courses_use_case.dart';
import '../../domain/use_cases/save_course_use_case.dart';
import 'courses_catalog_state.dart';

@injectable
class CoursesCatalogCubit extends Cubit<CoursesCatalogState> {
  CoursesCatalogCubit(
    this._getCourses,
    this._getRecommended,
    this._getSaved,
    this._getEnrollments,
    this._save,
    this._unsave,
  ) : super(const CoursesCatalogState());

  final GetCoursesUseCase _getCourses;
  final GetRecommendedCoursesUseCase _getRecommended;
  final GetSavedCoursesUseCase _getSaved;
  final GetEnrollmentsUseCase _getEnrollments;
  final SaveCourseUseCase _save;
  final UnsaveCourseUseCase _unsave;
  bool _loading = false;

  Future<void> loadInitial() => _load(reset: true);

  Future<void> selectTab(CoursesCatalogTab tab) async {
    if (isClosed) return;
    if (tab == state.tab && state.status != CoursesCatalogStatus.initial) {
      return;
    }
    emit(state.copyWith(tab: tab, query: const CoursesQuery()));
    await _load(reset: true);
  }

  Future<void> refresh() => _load(reset: true, refreshing: true);

  Future<void> search(String value) {
    if (isClosed) return Future.value();
    final text = value.trim();
    emit(state.copyWith(
      query: state.query.copyWith(
        page: 1,
        q: text,
        clearQuery: text.isEmpty,
      ),
    ));
    return _load(reset: true);
  }

  Future<void> applyFilters(CoursesQuery query) {
    if (isClosed) return Future.value();
    emit(state.copyWith(query: query.copyWith(page: 1)));
    return _load(reset: true);
  }

  Future<void> loadMore() async {
    final pagination = state.pagination;
    if (_loading || pagination?.hasNextPage != true) return;
    await _load(reset: false, page: pagination!.nextPage);
  }

  Future<void> toggleSave(Course course) async {
    if (isClosed || state.savingIds.contains(course.id)) return;
    final previous = state;
    final desired = !course.isSaved;
    emit(_withSaved(previous, course.id, desired).copyWith(
      savingIds: {...previous.savingIds, course.id},
      clearFeedback: true,
    ));
    final result = desired ? await _save(course.id) : await _unsave(course.id);
    if (isClosed) return;
    result.fold(
      (_) => emit(previous.copyWith(
        savingIds: {...previous.savingIds}..remove(course.id),
        feedbackKey: 'courses.saveFailed',
        feedbackSerial: previous.feedbackSerial + 1,
      )),
      (saved) {
        var updated = _withSaved(state, course.id, saved.isSaved);
        if (!saved.isSaved && state.tab == CoursesCatalogTab.saved) {
          updated = updated.copyWith(
            courses: updated.courses
                .where((item) => item.id != course.id)
                .toList(growable: false),
            status: updated.courses.length == 1
                ? CoursesCatalogStatus.empty
                : CoursesCatalogStatus.success,
          );
        }
        emit(updated.copyWith(
          savingIds: {...state.savingIds}..remove(course.id),
          feedbackKey: saved.isSaved ? 'courses.saved' : 'courses.unsaved',
          feedbackSerial: state.feedbackSerial + 1,
        ));
      },
    );
  }

  Future<void> _load({
    required bool reset,
    bool refreshing = false,
    int? page,
  }) async {
    if (isClosed || _loading) return;
    _loading = true;
    final targetPage = reset ? 1 : page ?? 1;
    emit(state.copyWith(
      status:
          reset && !refreshing ? CoursesCatalogStatus.loading : state.status,
      isRefreshing: refreshing,
      isLoadingMore: !reset,
      clearError: true,
    ));
    final result = switch (state.tab) {
      CoursesCatalogTab.discover =>
        await _getCourses(state.query.copyWith(page: targetPage)),
      CoursesCatalogTab.saved => await _getSaved(targetPage, state.query.limit),
      CoursesCatalogTab.learning =>
        await _getEnrollments(targetPage, state.query.limit),
      CoursesCatalogTab.recommended => null,
    };
    if (isClosed) return;
    if (state.tab == CoursesCatalogTab.recommended) {
      await _loadRecommended();
    } else {
      result!.fold(_emitFailure, (value) => _emitPage(value, reset));
    }
    _loading = false;
  }

  Future<void> _loadRecommended() async {
    final result = await _getRecommended();
    if (isClosed) return;
    result.fold(_emitFailure, (value) {
      emit(state.copyWith(
        status: value.courses.isEmpty
            ? CoursesCatalogStatus.empty
            : CoursesCatalogStatus.success,
        recommendations: value.courses,
        courses: const [],
        requiredAction: value.requiredAction,
        clearRequiredAction: value.requiredAction == null,
        targetCareer: value.targetCareer,
        clearTargetCareer: value.targetCareer == null,
        clearPagination: true,
        isRefreshing: false,
        isLoadingMore: false,
      ));
    });
  }

  void _emitPage(CoursesPage page, bool reset) {
    final courses = reset ? page.courses : [...state.courses, ...page.courses];
    emit(state.copyWith(
      status: courses.isEmpty
          ? CoursesCatalogStatus.empty
          : CoursesCatalogStatus.success,
      courses: courses,
      recommendations: const [],
      pagination: page.pagination,
      clearRequiredAction: true,
      clearTargetCareer: true,
      isRefreshing: false,
      isLoadingMore: false,
    ));
  }

  void _emitFailure(Failure failure) {
    final status = switch (failure) {
      NetworkFailure() => CoursesCatalogStatus.networkError,
      UnauthorizedFailure() => CoursesCatalogStatus.unauthorized,
      _ => CoursesCatalogStatus.error,
    };
    final key = switch (failure) {
      NetworkFailure() => 'courses.networkError',
      UnauthorizedFailure() => 'courses.unauthorized',
      ValidationFailure() => failure.message,
      _ => 'courses.serverError',
    };
    emit(state.copyWith(
      status: status,
      errorKey: key,
      isRefreshing: false,
      isLoadingMore: false,
    ));
  }

  CoursesCatalogState _withSaved(
    CoursesCatalogState current,
    String id,
    bool saved,
  ) =>
      current.copyWith(
        courses: current.courses
            .map((item) => item.id == id ? item.copyWith(isSaved: saved) : item)
            .toList(growable: false),
        recommendations: current.recommendations
            .map((item) => item.course.id == id
                ? item.copyWith(course: item.course.copyWith(isSaved: saved))
                : item)
            .toList(growable: false),
      );
}
