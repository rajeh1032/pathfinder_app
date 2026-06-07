import 'package:equatable/equatable.dart';

import '../../domain/entities/course.dart';

enum CourseFilter { price, duration, level }

enum CourseDetailTab { overview, curriculum, reviews }

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {
  const CoursesInitial();
}

class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

class CoursesSuccess extends CoursesState {
  const CoursesSuccess({
    required this.courses,
    this.query = '',
    this.selectedFilter,
    this.savedCourseIds = const {},
  });

  final List<Course> courses;
  final String query;
  final CourseFilter? selectedFilter;
  final Set<String> savedCourseIds;

  @override
  List<Object?> get props => [
        courses,
        query,
        selectedFilter,
        savedCourseIds,
      ];
}

class CoursesEmpty extends CoursesState {
  const CoursesEmpty({
    this.query = '',
    this.selectedFilter,
  });

  final String query;
  final CourseFilter? selectedFilter;

  @override
  List<Object?> get props => [query, selectedFilter];
}

class CoursesError extends CoursesState {
  const CoursesError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}

class CourseDetailsSuccess extends CoursesState {
  const CourseDetailsSuccess({
    required this.course,
    this.selectedTab = CourseDetailTab.overview,
    this.isSaved = false,
    this.isEnrolled = false,
  });

  final Course course;
  final CourseDetailTab selectedTab;
  final bool isSaved;
  final bool isEnrolled;

  CourseDetailsSuccess copyWith({
    Course? course,
    CourseDetailTab? selectedTab,
    bool? isSaved,
    bool? isEnrolled,
  }) {
    return CourseDetailsSuccess(
      course: course ?? this.course,
      selectedTab: selectedTab ?? this.selectedTab,
      isSaved: isSaved ?? this.isSaved,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }

  @override
  List<Object?> get props => [course, selectedTab, isSaved, isEnrolled];
}
