import 'package:equatable/equatable.dart';

import '../../domain/entities/course.dart';

enum SavedCoursesStatus { initial, loading, success, failure }

class SavedCoursesState extends Equatable {
  const SavedCoursesState({
    this.status = SavedCoursesStatus.initial,
    this.courses = const [],
    this.errorMessage,
  });

  final SavedCoursesStatus status;
  final List<Course> courses;
  final String? errorMessage;

  bool get isLoading => status == SavedCoursesStatus.loading;
  bool get isSuccess => status == SavedCoursesStatus.success;
  bool get isFailure => status == SavedCoursesStatus.failure;

  SavedCoursesState copyWith({
    SavedCoursesStatus? status,
    List<Course>? courses,
    String? errorMessage,
  }) {
    return SavedCoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, courses, errorMessage];
}
