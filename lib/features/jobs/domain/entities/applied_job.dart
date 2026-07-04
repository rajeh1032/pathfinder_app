import 'package:equatable/equatable.dart';

import 'job.dart';

class AppliedJob extends Equatable {
  const AppliedJob({
    required this.id,
    required this.job,
    required this.status,
    this.nextStep,
    this.createdAt,
    this.updatedAt,
    this.coverLetterId,
  });

  final String id;
  final Job job;
  final String status;
  final String? nextStep;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? coverLetterId;

  @override
  List<Object?> get props => [
        id,
        job,
        status,
        nextStep,
        createdAt,
        updatedAt,
        coverLetterId,
      ];
}
