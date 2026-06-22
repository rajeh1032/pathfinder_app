import '../../domain/entities/applied_job.dart';
import 'job_model.dart';

class AppliedJobModel extends AppliedJob {
  const AppliedJobModel({
    required super.id,
    required super.job,
    required super.status,
    super.nextStep,
    super.createdAt,
    super.updatedAt,
    super.coverLetterId,
  });

  factory AppliedJobModel.fromJson(Map<String, dynamic> json) {
    final jobJson = json['jobs'];
    return AppliedJobModel(
      id: json['id']?.toString() ?? '',
      job: jobJson is Map<String, dynamic>
          ? JobModel.fromJson(jobJson)
          : JobModel.fromJson(json),
      status: json['status']?.toString() ?? 'submitted',
      nextStep: json['next_step']?.toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
      coverLetterId: json['cover_letter_id']?.toString(),
    );
  }
}
