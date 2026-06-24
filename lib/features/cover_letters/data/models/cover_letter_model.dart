import '../../../jobs/data/models/job_model.dart';
import '../../domain/entities/cover_letter.dart';

class CoverLetterInsightModel extends CoverLetterInsight {
  const CoverLetterInsightModel({
    required super.id,
    required super.type,
    required super.message,
  });

  factory CoverLetterInsightModel.fromJson(Map<String, dynamic> json) {
    return CoverLetterInsightModel(
      id: _string(json['id']),
      type: _string(json['type'], fallback: 'info'),
      message: _string(json['message']),
    );
  }
}

class CoverLetterModel extends CoverLetter {
  const CoverLetterModel({
    required super.id,
    required super.jobId,
    required super.content,
    required super.status,
    required super.version,
    required super.title,
    required super.score,
    required super.tone,
    required super.targetRole,
    required super.companyName,
    required super.wordCount,
    required super.createdAt,
    super.job,
    super.insights,
  });

  factory CoverLetterModel.fromJson(Map<String, dynamic> json) {
    final jobJson = json['jobs'] ?? json['job'];
    final content = _string(json['content']);

    return CoverLetterModel(
      id: _string(json['id']),
      jobId: _string(json['job_id']),
      content: content,
      status: _string(json['status'], fallback: 'generated'),
      version: _int(json['version'], fallback: 1),
      title: _string(json['title'], fallback: 'Cover Letter'),
      score: _int(json['score']),
      tone: _string(json['tone'], fallback: 'professional'),
      targetRole: _string(json['target_role']),
      companyName: _string(json['company_name']),
      wordCount: _int(json['word_count'], fallback: _wordCount(content)),
      createdAt: _date(json['created_at']),
      job: jobJson is Map<String, dynamic> ? JobModel.fromJson(jobJson) : null,
      insights: _insights(json['insights']),
    );
  }
}

int _wordCount(String value) {
  return value
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.trim().isNotEmpty)
      .length;
}

String _string(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString();
  return text.trim().isEmpty ? fallback : text;
}

int _int(Object? value, {int fallback = 0}) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

DateTime? _date(Object? value) {
  final text = value?.toString();
  return text == null ? null : DateTime.tryParse(text);
}

List<CoverLetterInsightModel> _insights(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map<String, dynamic>>()
      .map(CoverLetterInsightModel.fromJson)
      .toList(growable: false);
}
