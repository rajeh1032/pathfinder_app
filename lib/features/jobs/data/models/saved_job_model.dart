import '../../domain/entities/saved_job.dart';
import 'job_model.dart';

class SavedJobModel extends SavedJob {
  const SavedJobModel({
    required super.id,
    required super.job,
    super.createdAt,
  });

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    final jobJson = json['jobs'];
    return SavedJobModel(
      id: json['id']?.toString() ?? '',
      job: jobJson is Map<String, dynamic>
          ? JobModel.fromJson(jobJson)
          : JobModel.fromJson(json),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    );
  }
}
