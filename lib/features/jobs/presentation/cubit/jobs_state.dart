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
    this.searchQuery = '',
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
  final String searchQuery;

  bool get isLoading => status == JobsStatus.loading;

  List<JobMatch> get visibleMatches {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return matches;

    return matches.where((match) {
      final job = match.job;
      final searchableText = [
        job.title,
        job.company,
        job.location,
        job.description,
        job.salaryRange,
        job.level,
        job.category,
        job.employmentType,
        job.requiredSkills.join(' '),
        match.matchedSkills.join(' '),
        match.missingSkills.join(' '),
        match.reason,
      ].whereType<String>().join(' ').toLowerCase();

      return searchableText.contains(query);
    }).toList(growable: false);
  }

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
    String? searchQuery,
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
      searchQuery: searchQuery ?? this.searchQuery,
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
        searchQuery,
      ];
}
