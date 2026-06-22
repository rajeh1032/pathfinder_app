import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_saved_jobs_use_case.dart';
import 'saved_jobs_state.dart';

@injectable
class SavedJobsCubit extends Cubit<SavedJobsCubitState> {
  SavedJobsCubit(this._getSavedJobs) : super(const SavedJobsCubitState());

  final GetSavedJobsUseCase _getSavedJobs;

  Future<void> load() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: SavedJobsStatus.loading));

    final result = await _getSavedJobs();

    result.fold(
      (failure) => emit(state.copyWith(
        status: SavedJobsStatus.failure,
        errorMessage: failure.message,
      )),
      (jobs) => emit(state.copyWith(
        status: SavedJobsStatus.success,
        jobs: jobs,
      )),
    );
  }
}
