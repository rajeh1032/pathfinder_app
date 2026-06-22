import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_saved_courses_use_case.dart';
import 'saved_courses_state.dart';

/// Loads the user's saved courses from the `/saved` endpoint for the
/// compact profile preview. Owned by the courses feature.
@injectable
class SavedCoursesCubit extends Cubit<SavedCoursesState> {
  SavedCoursesCubit(this._getSavedCourses) : super(const SavedCoursesState());

  final GetSavedCoursesUseCase _getSavedCourses;

  static const _page = 1;
  static const _limit = 10;

  Future<void> load() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: SavedCoursesStatus.loading));

    final result = await _getSavedCourses(_page, _limit);

    result.fold(
      (failure) => emit(state.copyWith(
        status: SavedCoursesStatus.failure,
        errorMessage: failure.message,
      )),
      (page) => emit(state.copyWith(
        status: SavedCoursesStatus.success,
        courses: page.courses,
      )),
    );
  }
}
