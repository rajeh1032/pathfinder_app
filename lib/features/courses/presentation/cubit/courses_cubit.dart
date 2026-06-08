import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/course.dart';
import '../../domain/use_cases/get_course_details_use_case.dart';
import '../../domain/use_cases/get_courses_use_case.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit({
    required GetCoursesUseCase getCoursesUseCase,
    required GetCourseDetailsUseCase getCourseDetailsUseCase,
  })  : _getCoursesUseCase = getCoursesUseCase,
        _getCourseDetailsUseCase = getCourseDetailsUseCase,
        super(const CoursesInitial());

  final GetCoursesUseCase _getCoursesUseCase;
  final GetCourseDetailsUseCase _getCourseDetailsUseCase;
  final Set<String> _savedCourseIds = {};
  final Set<String> _enrolledCourseIds = {};

  List<Course> _allCourses = const [];
  String _query = '';
  CourseFilter? _selectedFilter;

  Future<void> loadCourses() async {
    emit(const CoursesLoading());
    _query = '';
    _selectedFilter = null;
    final result = await _getCoursesUseCase();

    result.fold(
      (failure) => emit(CoursesError(messageKey: failure.message)),
      (courses) {
        _allCourses = courses;
        _emitFilteredCourses();
      },
    );
  }

  Future<void> loadCourseDetails(String id) async {
    emit(const CoursesLoading());
    final result = await _getCourseDetailsUseCase(id);

    result.fold(
      (failure) => emit(CoursesError(messageKey: failure.message)),
      (course) => emit(
        CourseDetailsSuccess(
          course: course,
          isSaved: _savedCourseIds.contains(course.id),
          isEnrolled: _enrolledCourseIds.contains(course.id),
        ),
      ),
    );
  }

  void searchCourses(String query) {
    _query = query.trim();
    _emitFilteredCourses();
  }

  void toggleFilter(CourseFilter filter) {
    _selectedFilter = _selectedFilter == filter ? null : filter;
    _emitFilteredCourses();
  }

  void selectDetailTab(CourseDetailTab tab) {
    final currentState = state;
    if (currentState is! CourseDetailsSuccess) return;
    emit(currentState.copyWith(selectedTab: tab));
  }

  bool toggleSavedCourse(String id) {
    if (_savedCourseIds.contains(id)) {
      _savedCourseIds.remove(id);
    } else {
      _savedCourseIds.add(id);
    }

    final currentState = state;
    if (currentState is CourseDetailsSuccess && currentState.course.id == id) {
      emit(currentState.copyWith(isSaved: _savedCourseIds.contains(id)));
    } else {
      _emitFilteredCourses();
    }

    return _savedCourseIds.contains(id);
  }

  bool enrollInCourse(String id) {
    final isNewEnrollment = _enrolledCourseIds.add(id);
    final currentState = state;
    if (currentState is CourseDetailsSuccess && currentState.course.id == id) {
      emit(currentState.copyWith(isEnrolled: true));
    }

    return isNewEnrollment;
  }

  void _emitFilteredCourses() {
    final filteredCourses = _filteredCourses();
    if (filteredCourses.isEmpty) {
      emit(CoursesEmpty(query: _query, selectedFilter: _selectedFilter));
      return;
    }

    emit(
      CoursesSuccess(
        courses: filteredCourses,
        query: _query,
        selectedFilter: _selectedFilter,
        savedCourseIds: Set.unmodifiable(_savedCourseIds),
      ),
    );
  }

  List<Course> _filteredCourses() {
    final normalizedQuery = _query.toLowerCase();
    final queriedCourses = normalizedQuery.isEmpty
        ? _allCourses
        : _allCourses.where((course) => _matchesQuery(course, normalizedQuery));

    final filtered = queriedCourses.where(_matchesFilter).toList();
    filtered.sort((first, second) {
      return switch (_selectedFilter) {
        CourseFilter.duration =>
          first.durationKey.compareTo(second.durationKey),
        CourseFilter.level => first.levelKey.compareTo(second.levelKey),
        CourseFilter.price => first.priceKey.compareTo(second.priceKey),
        null => first.titleKey.compareTo(second.titleKey),
      };
    });

    return filtered;
  }

  bool _matchesQuery(Course course, String query) {
    return [
      course.id,
      course.titleKey,
      course.providerKey,
      course.levelKey,
    ].any((value) => value.toLowerCase().contains(query));
  }

  bool _matchesFilter(Course course) {
    return switch (_selectedFilter) {
      CourseFilter.level => course.levelKey.contains('advanced'),
      CourseFilter.duration => course.durationKey.contains('12'),
      CourseFilter.price =>
        course.priceKey.contains('49') || course.priceKey.contains('34'),
      null => true,
    };
  }
}
