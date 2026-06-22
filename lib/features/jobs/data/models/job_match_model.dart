import '../../domain/entities/job_match.dart';
import 'job_model.dart';

class JobMatchModel extends JobMatch {
  const JobMatchModel({
    required super.id,
    required super.jobId,
    required super.cvId,
    required super.matchPercentage,
    required super.matchedSkills,
    required super.missingSkills,
    required super.reason,
    required super.job,
  });

  factory JobMatchModel.fromJson(Map<String, dynamic> json) {
    final jobJson = json['jobs'];
    final matchJson = json['match'];
    final job = jobJson is Map<String, dynamic>
        ? JobModel.fromJson(jobJson)
        : JobModel.fromJson(json);
    final match = matchJson is Map<String, dynamic> ? matchJson : json;
    final matchedSkills = _stringList(match['matched_skills']);

    return JobMatchModel(
      id: _string(
        json['id'] ?? json['match_id'] ?? match['id'],
        fallback: job.id,
      ),
      jobId: _string(json['job_id'], fallback: job.id),
      cvId: _nullableString(json['cv_id'] ?? match['cv_id']),
      matchPercentage: _int(match['match_percentage']),
      matchedSkills: matchedSkills,
      missingSkills: _withoutMatchedSkills(
        _stringList(match['missing_skills']),
        matchedSkills,
      ),
      reason: _string(match['ai_reason']),
      job: job,
    );
  }
}

List<String> _withoutMatchedSkills(
  List<String> missingSkills,
  List<String> matchedSkills,
) {
  final matched = matchedSkills.map((skill) => skill.toLowerCase()).toSet();
  return missingSkills
      .where((skill) => !matched.contains(skill.toLowerCase()))
      .toList(growable: false);
}

String _string(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString();
  return text.isEmpty ? fallback : text;
}

String? _nullableString(Object? value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

int _int(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> _stringList(Object? value) {
  if (value is List) {
    return value
        .map((item) => item.toString())
        .where((item) => item.trim().isNotEmpty)
        .toList();
  }
  return const [];
}
