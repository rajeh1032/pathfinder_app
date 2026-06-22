import 'package:equatable/equatable.dart';

import '../../domain/entities/applied_job.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/job_match.dart';
import '../../domain/entities/saved_job.dart';

enum JobsStatus { initial, loading, success, failure }

class JobsState extends Equatable {
  const JobsState({
    this.status = JobsStatus.initial,
    this.jobs = const [],
    this.matches = const [],
    this.savedJobs = const [],
    this.appliedJobs = const [],
    this.selectedJob,
    this.savedJobIds = const {},
    this.errorMessage,
    this.isSaving = false,
    this.isApplying = false,
  });

  final JobsStatus status;
  final List<Job> jobs;
  final List<JobMatch> matches;
  final List<SavedJob> savedJobs;
  final List<AppliedJob> appliedJobs;
  final Job? selectedJob;
  final Set<String> savedJobIds;
  final String? errorMessage;
  final bool isSaving;
  final bool isApplying;

  bool get isLoading => status == JobsStatus.loading;

  JobsState copyWith({
    JobsStatus? status,
    List<Job>? jobs,
    List<JobMatch>? matches,
    List<SavedJob>? savedJobs,
    List<AppliedJob>? appliedJobs,
    Job? selectedJob,
    Set<String>? savedJobIds,
    String? errorMessage,
    bool? isSaving,
    bool? isApplying,
    bool clearError = false,
  }) {
    return JobsState(
      status: status ?? this.status,
      jobs: jobs ?? this.jobs,
      matches: matches ?? this.matches,
      savedJobs: savedJobs ?? this.savedJobs,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      selectedJob: selectedJob ?? this.selectedJob,
      savedJobIds: savedJobIds ?? this.savedJobIds,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isSaving: isSaving ?? this.isSaving,
      isApplying: isApplying ?? this.isApplying,
    );
  }

  @override
  List<Object?> get props => [
        status,
        jobs,
        matches,
        savedJobs,
        appliedJobs,
        selectedJob,
        savedJobIds,
        errorMessage,
        isSaving,
        isApplying,
      ];
}
