import 'package:equatable/equatable.dart';

import '../../domain/entities/saved_job.dart';

enum SavedJobsStatus { initial, loading, success, failure }

class SavedJobsCubitState extends Equatable {
  const SavedJobsCubitState({
    this.status = SavedJobsStatus.initial,
    this.jobs = const [],
    this.errorMessage,
  });

  final SavedJobsStatus status;
  final List<SavedJob> jobs;
  final String? errorMessage;

  bool get isLoading => status == SavedJobsStatus.loading;
  bool get isSuccess => status == SavedJobsStatus.success;
  bool get isFailure => status == SavedJobsStatus.failure;

  SavedJobsCubitState copyWith({
    SavedJobsStatus? status,
    List<SavedJob>? jobs,
    String? errorMessage,
  }) {
    return SavedJobsCubitState(
      status: status ?? this.status,
      jobs: jobs ?? this.jobs,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, jobs, errorMessage];
}
