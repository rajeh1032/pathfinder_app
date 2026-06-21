import 'package:equatable/equatable.dart';

import 'course.dart';
import 'course_recommendation.dart';

class Pagination extends Equatable {
  const Pagination({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.nextPage,
    this.previousPage,
  });

  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int? nextPage;
  final int? previousPage;

  @override
  List<Object?> get props => [
        page,
        limit,
        totalItems,
        totalPages,
        hasNextPage,
        hasPreviousPage,
        nextPage,
        previousPage,
      ];
}

class CoursesPage extends Equatable {
  const CoursesPage({required this.courses, required this.pagination});

  final List<Course> courses;
  final Pagination pagination;

  @override
  List<Object?> get props => [courses, pagination];
}

class RecommendedCoursesResult extends Equatable {
  const RecommendedCoursesResult({
    required this.hasRecommendations,
    required this.courses,
    required this.missingSkills,
    this.requiredAction,
    this.targetCareer,
  });

  final bool hasRecommendations;
  final String? requiredAction;
  final String? targetCareer;
  final List<String> missingSkills;
  final List<CourseRecommendation> courses;

  @override
  List<Object?> get props => [
        hasRecommendations,
        requiredAction,
        targetCareer,
        missingSkills,
        courses,
      ];
}
