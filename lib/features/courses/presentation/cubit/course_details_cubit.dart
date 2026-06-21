import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/course_enrollment.dart';
import '../../domain/use_cases/enroll_course_use_case.dart';
import '../../domain/use_cases/get_course_details_use_case.dart';
import '../../domain/use_cases/save_course_use_case.dart';
import '../../domain/use_cases/update_enrollment_use_case.dart';
import 'course_details_state.dart';

@injectable
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(
    this._getDetails,
    this._save,
    this._unsave,
    this._enroll,
    this._updateEnrollment,
  ) : super(const CourseDetailsState());

  final GetCourseDetailsUseCase _getDetails;
  final SaveCourseUseCase _save;
  final UnsaveCourseUseCase _unsave;
  final EnrollCourseUseCase _enroll;
  final UpdateEnrollmentUseCase _updateEnrollment;

  Future<void> load(String? courseId) async {
    if (state.status == CourseDetailsStatus.loading) return;
    emit(const CourseDetailsState(status: CourseDetailsStatus.loading));
    final result = await _getDetails(courseId ?? '');
    result.fold(
      _emitFailure,
      (course) => emit(CourseDetailsState(
        status: CourseDetailsStatus.success,
        course: course,
      )),
    );
  }

  Future<void> toggleSave() async {
    final course = state.course;
    if (course == null || state.saveLoading) return;
    final wasSaved = course.isSaved;
    emit(state.copyWith(
      course: course.copyWith(isSaved: !wasSaved),
      saveLoading: true,
      clearFeedback: true,
    ));
    final result = wasSaved ? await _unsave(course.id) : await _save(course.id);
    result.fold(
      (_) => emit(state.copyWith(
        course: course,
        saveLoading: false,
        feedbackKey: 'courses.saveFailed',
        feedbackSerial: state.feedbackSerial + 1,
      )),
      (saved) => emit(state.copyWith(
        course: course.copyWith(isSaved: saved.isSaved),
        saveLoading: false,
        changed: true,
        feedbackKey: saved.isSaved ? 'courses.saved' : 'courses.unsaved',
        feedbackSerial: state.feedbackSerial + 1,
      )),
    );
  }

  Future<void> enroll() async {
    final course = state.course;
    if (course == null || state.enrollLoading || course.enrollment != null) {
      return;
    }
    emit(state.copyWith(enrollLoading: true, clearFeedback: true));
    final result = await _enroll(course.id);
    result.fold(
      (_) => emit(state.copyWith(
        enrollLoading: false,
        feedbackKey: 'courses.enrollFailed',
        feedbackSerial: state.feedbackSerial + 1,
      )),
      (value) => emit(state.copyWith(
        course: course.copyWith(enrollment: value.enrollment),
        enrollLoading: false,
        changed: true,
        clearStagedProgress: true,
        clearStagedStatus: true,
        feedbackKey: value.alreadyEnrolled == true
            ? 'courses.alreadyEnrolled'
            : 'courses.enrolled',
        feedbackSerial: state.feedbackSerial + 1,
      )),
    );
  }

  void stageProgress(int progress) {
    if (state.course?.enrollment == null || state.updateLoading) return;
    final status = progress == 100
        ? EnrollmentStatus.completed
        : state.enrollmentStatus == EnrollmentStatus.completed
            ? EnrollmentStatus.active
            : state.enrollmentStatus;
    emit(state.copyWith(stagedProgress: progress, stagedStatus: status));
  }

  void stageStatus(EnrollmentStatus status) {
    if (state.course?.enrollment == null || state.updateLoading) return;
    var progress = state.progress ?? 0;
    if (status == EnrollmentStatus.completed) progress = 100;
    if (status != EnrollmentStatus.completed && progress == 100) progress = 99;
    emit(state.copyWith(stagedStatus: status, stagedProgress: progress));
  }

  Future<void> updateEnrollment() async {
    final course = state.course;
    final enrollment = course?.enrollment;
    if (course == null ||
        enrollment == null ||
        !state.isDirty ||
        state.updateLoading) {
      return;
    }
    final progress = state.progress!;
    final status = state.enrollmentStatus!;
    emit(state.copyWith(updateLoading: true, clearFeedback: true));
    final result = await _updateEnrollment(UpdateEnrollmentParams(
      courseId: course.id,
      progress: progress != enrollment.progress ? progress : null,
      status: status != enrollment.status ? status : null,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        updateLoading: false,
        feedbackKey: failure is ValidationFailure
            ? failure.message
            : 'courses.updateFailed',
        feedbackSerial: state.feedbackSerial + 1,
      )),
      (value) => emit(state.copyWith(
        course: course.copyWith(enrollment: value.enrollment),
        updateLoading: false,
        changed: true,
        clearStagedProgress: true,
        clearStagedStatus: true,
        feedbackKey: 'courses.updateSuccess',
        feedbackSerial: state.feedbackSerial + 1,
      )),
    );
  }

  void _emitFailure(Failure failure) {
    final status = switch (failure) {
      NetworkFailure() => CourseDetailsStatus.networkError,
      UnauthorizedFailure() => CourseDetailsStatus.unauthorized,
      _ => CourseDetailsStatus.error,
    };
    final key = switch (failure) {
      NetworkFailure() => 'courses.networkError',
      UnauthorizedFailure() => 'courses.unauthorized',
      ValidationFailure() => failure.message,
      _ => 'courses.serverError',
    };
    emit(CourseDetailsState(status: status, errorKey: key));
  }
}
