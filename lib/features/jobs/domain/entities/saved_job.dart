import 'package:equatable/equatable.dart';

import 'job.dart';

class SavedJob extends Equatable {
  const SavedJob({
    required this.id,
    required this.job,
    this.createdAt,
  });

  final String id;
  final Job job;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, job, createdAt];
}
