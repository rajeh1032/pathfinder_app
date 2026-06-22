import '../../domain/entities/cv_anaysis_entity.dart';

List<String> _strings(dynamic value) =>
    value is List ? value.map((item) => item.toString()).toList() : const [];

DateTime _date(dynamic value) =>
    DateTime.tryParse(value?.toString() ?? '') ??
    DateTime.fromMillisecondsSinceEpoch(0);

class DetectedSkillModel {
  const DetectedSkillModel({
    required this.name,
    required this.level,
    required this.category,
    required this.evidence,
    this.skillId,
    required this.confidence,
  });

  final String name;
  final String level;
  final String category;
  final String evidence;
  final String? skillId;
  final double confidence;

  factory DetectedSkillModel.fromJson(Map<String, dynamic> json) =>
      DetectedSkillModel(
        name: json['name'] as String? ?? '',
        level: json['level'] as String? ?? '',
        category: json['category'] as String? ?? '',
        evidence: json['evidence'] as String? ?? '',
        skillId: json['skill_id'] as String?,
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      );

  DetectedSkillEntity toEntity() => DetectedSkillEntity(
        name: name,
        level: level,
        category: category,
        evidence: evidence,
        skillId: skillId,
        confidence: confidence,
      );
}

class CvExtractedModel {
  const CvExtractedModel(this.json);
  final Map<String, dynamic> json;

  CvExtractedEntity toEntity() => CvExtractedEntity(
        projects: _strings(json['projects']),
        languages: _strings(json['languages']),
        jobKeywords: _strings(json['job_keywords']),
        certifications: _strings(json['certifications']),
        missingSkills: _strings(json['missing_skills']),
        interviewFocus: _strings(json['interview_focus']),
        recommendedRoles: _strings(json['recommended_roles']),
      );
}

class CvAnalysisModel {
  const CvAnalysisModel(this.json);
  final Map<String, dynamic> json;

  CvAnalysisEntity toEntity() => CvAnalysisEntity(
        id: json['id'] as String? ?? '',
        cvId: json['cv_id'] as String? ?? '',
        score: (json['score'] as num?)?.round() ?? 0,
        summary: json['summary'] as String? ?? '',
        strengths: _strings(json['strengths']),
        weaknesses: _strings(json['weaknesses']),
        suggestions: _strings(json['suggestions']),
        detectedSkills: (json['detected_skills'] as List? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(DetectedSkillModel.fromJson)
            .map((model) => model.toEntity())
            .toList(),
        extracted: CvExtractedModel(
          json['extracted'] as Map<String, dynamic>? ?? const {},
        ).toEntity(),
        status: json['status'] as String? ?? 'completed',
        createdAt: _date(json['created_at']),
      );
}

class CvModel {
  const CvModel(this.json);
  final Map<String, dynamic> json;

  CvEntity toEntity() => CvEntity(
        id: json['id'] as String? ?? '',
        userId: json['user_id'] as String? ?? '',
        fileUrl: json['file_url'] as String?,
        storagePath: json['storage_path'] as String? ?? '',
        originalName: json['original_name'] as String? ?? '',
        mimeType: json['mime_type'] as String? ?? '',
        sizeBytes: (json['size_bytes'] as num?)?.round() ?? 0,
        status: json['status'] as String? ?? '',
        uploadedAt: _date(json['uploaded_at'] ?? json['created_at']),
      );
}

class CvWithAnalysisModel {
  const CvWithAnalysisModel({required this.cv, required this.analysis});
  final CvModel cv;
  final CvAnalysisModel analysis;

  factory CvWithAnalysisModel.fromJson(Map<String, dynamic> json) =>
      CvWithAnalysisModel(
        cv: CvModel(json['cv'] as Map<String, dynamic>? ?? const {}),
        analysis: CvAnalysisModel(
          json['analysis'] as Map<String, dynamic>? ?? const {},
        ),
      );

  CvWithAnalysisEntity toEntity() =>
      CvWithAnalysisEntity(cv: cv.toEntity(), analysis: analysis.toEntity());
}

class CvStatusModel {
  const CvStatusModel(this.json);
  final Map<String, dynamic> json;

  CvStatusEntity toEntity() => CvStatusEntity(
        hasCv: json['hasCv'] as bool? ?? false,
        hasCompletedAnalysis: json['hasCompletedAnalysis'] as bool? ?? false,
        latestCvStatus: json['latestCvStatus'] as String?,
        requiredAction: json['requiredAction'] as String?,
      );
}
