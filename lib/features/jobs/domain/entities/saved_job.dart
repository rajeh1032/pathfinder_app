import 'package:equatable/equatable.dart';

import 'job.dart';

/// A saved job row with the full job payload for the Jobs feature, plus
/// convenience getters used by compact saved-job previews.
class SavedJob extends Equatable {
  const SavedJob({
    required this.id,
    required this.job,
    this.savedId,
    this.createdAt,
  });

  /// The job id. Use [savedId] when the saved row id is needed.
  final String id;
  final String? savedId;
  final Job job;
  final DateTime? createdAt;

  String get title => job.title;
  String? get company => job.company;
  String? get location => job.location;
  String? get jobType => job.employmentType;
  String? get logoUrl => job.companyLogoUrl;

  @override
  List<Object?> get props => [id, savedId, job, createdAt];
}
