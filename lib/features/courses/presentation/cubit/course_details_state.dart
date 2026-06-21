import 'package:equatable/equatable.dart';

import '../../domain/entities/course.dart';
import '../../domain/entities/course_enrollment.dart';

enum CourseDetailsStatus {
  initial,
  loading,
  success,
  networkError,
  unauthorized,
  error,
}

class CourseDetailsState extends Equatable {
  const CourseDetailsState({
    this.status = CourseDetailsStatus.initial,
    this.saveLoading = false,
    this.enrollLoading = false,
    this.updateLoading = false,
    this.changed = false,
    this.feedbackSerial = 0,
    this.course,
    this.stagedProgress,
    this.stagedStatus,
    this.errorKey,
    this.feedbackKey,
  });

  final CourseDetailsStatus status;
  final Course? course;
  final bool saveLoading;
  final bool enrollLoading;
  final bool updateLoading;
  final int? stagedProgress;
  final EnrollmentStatus? stagedStatus;
  final bool changed;
  final String? errorKey;
  final String? feedbackKey;
  final int feedbackSerial;

  int? get progress => stagedProgress ?? course?.enrollment?.progress;
  EnrollmentStatus? get enrollmentStatus =>
      stagedStatus ?? course?.enrollment?.status;
  bool get isDirty {
    final enrollment = course?.enrollment;
    return enrollment != null &&
        (progress != enrollment.progress ||
            enrollmentStatus != enrollment.status);
  }

  CourseDetailsState copyWith({
    CourseDetailsStatus? status,
    Course? course,
    bool? saveLoading,
    bool? enrollLoading,
    bool? updateLoading,
    int? stagedProgress,
    bool clearStagedProgress = false,
    EnrollmentStatus? stagedStatus,
    bool clearStagedStatus = false,
    bool? changed,
    String? errorKey,
    bool clearError = false,
    String? feedbackKey,
    bool clearFeedback = false,
    int? feedbackSerial,
  }) =>
      CourseDetailsState(
        status: status ?? this.status,
        course: course ?? this.course,
        saveLoading: saveLoading ?? this.saveLoading,
        enrollLoading: enrollLoading ?? this.enrollLoading,
        updateLoading: updateLoading ?? this.updateLoading,
        stagedProgress:
            clearStagedProgress ? null : stagedProgress ?? this.stagedProgress,
        stagedStatus:
            clearStagedStatus ? null : stagedStatus ?? this.stagedStatus,
        changed: changed ?? this.changed,
        errorKey: clearError ? null : errorKey ?? this.errorKey,
        feedbackKey: clearFeedback ? null : feedbackKey ?? this.feedbackKey,
        feedbackSerial: feedbackSerial ?? this.feedbackSerial,
      );

  @override
  List<Object?> get props => [
        status,
        course,
        saveLoading,
        enrollLoading,
        updateLoading,
        stagedProgress,
        stagedStatus,
        changed,
        errorKey,
        feedbackKey,
        feedbackSerial,
      ];
}
