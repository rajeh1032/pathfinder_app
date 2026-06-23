import 'package:equatable/equatable.dart';

import 'job.dart';

class JobMatch extends Equatable {
  const JobMatch({
    required this.id,
    required this.jobId,
    required this.cvId,
    required this.matchPercentage,
    required this.matchedSkills,
    required this.missingSkills,
    required this.reason,
    required this.job,
  });

  final String id;
  final String jobId;
  final String? cvId;
  final int matchPercentage;
  final List<String> matchedSkills;
  final List<String> missingSkills;
  final String reason;
  final Job job;

  @override
  List<Object?> get props => [
        id,
        jobId,
        cvId,
        matchPercentage,
        matchedSkills,
        missingSkills,
        reason,
        job,
      ];
}
