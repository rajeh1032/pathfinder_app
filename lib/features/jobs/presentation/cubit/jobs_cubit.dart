import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/jobs_repository.dart';
import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this._repository) : super(const JobsState());

  final JobsRepository _repository;

  Future<void> loadMatching() async {
    emit(state.copyWith(status: JobsStatus.loading, clearError: true));

    final savedResult = await _repository.getSavedJobs();
    final savedIds = savedResult.fold<Set<String>>(
      (_) => state.savedJobIds,
      (saved) => saved.map((item) => item.job.id).toSet(),
    );

    var result = await _repository.getMatchedJobs(limit: 20);
    final shouldGenerate = result.fold(
      (_) => false,
      (matches) => matches.isEmpty,
    );

    if (shouldGenerate) {
      result = await _repository.generateJobMatches(limit: 20);
    }

    result.fold(
      (failure) => emit(state.copyWith(
        status: JobsStatus.failure,
        errorMessage: failure.message,
        savedJobIds: savedIds,
      )),
      (matches) => emit(state.copyWith(
        status: JobsStatus.success,
        matches: matches,
        savedJobIds: savedIds,
      )),
    );
  }

  Future<void> loadJobDetails(String jobId) async {
    emit(state.copyWith(status: JobsStatus.loading, clearError: true));

    final savedResult = await _repository.getSavedJobs();
    final savedIds = savedResult.fold<Set<String>>(
      (_) => state.savedJobIds,
      (saved) => saved.map((item) => item.job.id).toSet(),
    );

    final result = await _repository.getJobDetails(jobId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: JobsStatus.failure,
        errorMessage: failure.message,
        savedJobIds: savedIds,
      )),
      (job) => emit(state.copyWith(
        status: JobsStatus.success,
        selectedJob: job,
        savedJobIds: savedIds,
      )),
    );
  }

  Future<void> loadSavedJobs() async {
    emit(state.copyWith(status: JobsStatus.loading, clearError: true));
    final result = await _repository.getSavedJobs();
    result.fold(
      (failure) => emit(state.copyWith(
        status: JobsStatus.failure,
        errorMessage: failure.message,
      )),
      (savedJobs) => emit(state.copyWith(
        status: JobsStatus.success,
        savedJobs: savedJobs,
        savedJobIds: savedJobs.map((item) => item.job.id).toSet(),
      )),
    );
  }

  Future<void> loadAppliedJobs() async {
    emit(state.copyWith(status: JobsStatus.loading, clearError: true));
    final result = await _repository.getAppliedJobs();
    result.fold(
      (failure) => emit(state.copyWith(
        status: JobsStatus.failure,
        errorMessage: failure.message,
      )),
      (appliedJobs) => emit(state.copyWith(
        status: JobsStatus.success,
        appliedJobs: appliedJobs,
      )),
    );
  }

  Future<void> toggleSave(String jobId) async {
    if (state.isSaving) return;
    final wasSaved = state.savedJobIds.contains(jobId);
    final nextSavedIds = {...state.savedJobIds};
    wasSaved ? nextSavedIds.remove(jobId) : nextSavedIds.add(jobId);
    emit(state.copyWith(isSaving: true, savedJobIds: nextSavedIds));

    final result = wasSaved
        ? await _repository.unsaveJob(jobId)
        : await _repository.saveJob(jobId);

    result.fold(
      (failure) {
        final rollbackIds = {...state.savedJobIds};
        wasSaved ? rollbackIds.add(jobId) : rollbackIds.remove(jobId);
        emit(state.copyWith(
          isSaving: false,
          savedJobIds: rollbackIds,
          errorMessage: failure.message,
        ));
      },
      (_) => emit(state.copyWith(isSaving: false, clearError: true)),
    );
  }

  Future<void> applyToJob(String jobId) async {
    if (state.isApplying) return;
    emit(state.copyWith(isApplying: true, clearError: true));

    final result = await _repository.applyToJob(jobId);
    result.fold(
      (failure) => emit(state.copyWith(
        isApplying: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(isApplying: false, clearError: true)),
    );
  }
}
