import 'package:equatable/equatable.dart';

import '../../domain/entities/course.dart';
import '../../domain/entities/course_recommendation.dart';
import '../../domain/entities/courses_page.dart';
import '../../domain/entities/courses_query.dart';

enum CoursesCatalogTab { discover, recommended, saved, learning }

enum CoursesCatalogStatus {
  initial,
  loading,
  success,
  empty,
  networkError,
  unauthorized,
  error,
}

class CoursesCatalogState extends Equatable {
  const CoursesCatalogState({
    this.tab = CoursesCatalogTab.discover,
    this.status = CoursesCatalogStatus.initial,
    this.query = const CoursesQuery(),
    this.courses = const [],
    this.recommendations = const [],
    this.savingIds = const {},
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.feedbackSerial = 0,
    this.pagination,
    this.requiredAction,
    this.targetCareer,
    this.errorKey,
    this.feedbackKey,
  });

  final CoursesCatalogTab tab;
  final CoursesCatalogStatus status;
  final CoursesQuery query;
  final List<Course> courses;
  final List<CourseRecommendation> recommendations;
  final Pagination? pagination;
  final String? requiredAction;
  final String? targetCareer;
  final Set<String> savingIds;
  final bool isRefreshing;
  final bool isLoadingMore;
  final String? errorKey;
  final String? feedbackKey;
  final int feedbackSerial;

  List<Course> get visibleCourses => tab == CoursesCatalogTab.recommended
      ? recommendations.map((item) => item.course).toList(growable: false)
      : courses;

  CoursesCatalogState copyWith({
    CoursesCatalogTab? tab,
    CoursesCatalogStatus? status,
    CoursesQuery? query,
    List<Course>? courses,
    List<CourseRecommendation>? recommendations,
    Pagination? pagination,
    bool clearPagination = false,
    String? requiredAction,
    bool clearRequiredAction = false,
    String? targetCareer,
    bool clearTargetCareer = false,
    Set<String>? savingIds,
    bool? isRefreshing,
    bool? isLoadingMore,
    String? errorKey,
    bool clearError = false,
    String? feedbackKey,
    bool clearFeedback = false,
    int? feedbackSerial,
  }) =>
      CoursesCatalogState(
        tab: tab ?? this.tab,
        status: status ?? this.status,
        query: query ?? this.query,
        courses: courses ?? this.courses,
        recommendations: recommendations ?? this.recommendations,
        pagination: clearPagination ? null : pagination ?? this.pagination,
        requiredAction:
            clearRequiredAction ? null : requiredAction ?? this.requiredAction,
        targetCareer:
            clearTargetCareer ? null : targetCareer ?? this.targetCareer,
        savingIds: savingIds ?? this.savingIds,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        errorKey: clearError ? null : errorKey ?? this.errorKey,
        feedbackKey: clearFeedback ? null : feedbackKey ?? this.feedbackKey,
        feedbackSerial: feedbackSerial ?? this.feedbackSerial,
      );

  @override
  List<Object?> get props => [
        tab,
        status,
        query,
        courses,
        recommendations,
        pagination,
        requiredAction,
        targetCareer,
        savingIds,
        isRefreshing,
        isLoadingMore,
        errorKey,
        feedbackKey,
        feedbackSerial,
      ];
}
