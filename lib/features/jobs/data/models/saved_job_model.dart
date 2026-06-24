import '../../domain/entities/saved_job.dart';
import 'job_model.dart';

class SavedJobModel extends SavedJob {
  const SavedJobModel({
    required super.id,
    required super.job,
    super.savedId,
    super.createdAt,
  });

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    final jobJson = json['jobs'] ?? json['job'];
    final job = jobJson is Map<String, dynamic>
        ? JobModel.fromJson(jobJson)
        : JobModel.fromJson(json);

    return SavedJobModel(
      id: job.id,
      savedId: json['id']?.toString(),
      job: job,
      createdAt: DateTime.tryParse(
        (json['created_at'] ?? json['saved_at'])?.toString() ?? '',
      ),
    );
  }

  SavedJob toEntity() => this;
}
