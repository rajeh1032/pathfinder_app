import '../../domain/entities/cv_anaysis_entity.dart';

/// Data-layer model for [DetectedSkillEntity].
/// Reuses the entity's own `fromJson` since it already matches the API
/// response shape (snake_case keys) — no extra mapping needed here.
class DetectedSkillModel extends DetectedSkillEntity {
  const DetectedSkillModel({
    required super.name,
    required super.level,
    required super.category,
    required super.evidence,
    super.skillId,
    required super.confidence,
  });

  factory DetectedSkillModel.fromJson(Map<String, dynamic> json) {
    final entity = DetectedSkillEntity.fromJson(json);
    return DetectedSkillModel(
      name: entity.name,
      level: entity.level,
      category: entity.category,
      evidence: entity.evidence,
      skillId: entity.skillId,
      confidence: entity.confidence,
    );
  }
}

/// Data-layer model for [CvExtractedEntity].
class CvExtractedModel extends CvExtractedEntity {
  const CvExtractedModel({
    required super.projects,
    required super.languages,
    required super.jobKeywords,
    required super.certifications,
    required super.missingSkills,
    required super.interviewFocus,
    required super.recommendedRoles,
  });

  factory CvExtractedModel.fromJson(Map<String, dynamic> json) {
    final entity = CvExtractedEntity.fromJson(json);
    return CvExtractedModel(
      projects: entity.projects,
      languages: entity.languages,
      jobKeywords: entity.jobKeywords,
      certifications: entity.certifications,
      missingSkills: entity.missingSkills,
      interviewFocus: entity.interviewFocus,
      recommendedRoles: entity.recommendedRoles,
    );
  }
}

/// Data-layer model for [CvAnalysisEntity].
class CvAnalysisModel extends CvAnalysisEntity {
  const CvAnalysisModel({
    required super.id,
    required super.cvId,
    required super.score,
    required super.summary,
    required super.strengths,
    required super.weaknesses,
    required super.suggestions,
    required super.detectedSkills,
    required super.extracted,
    required super.status,
    required super.createdAt,
  });

  factory CvAnalysisModel.fromJson(Map<String, dynamic> json) {
    final entity = CvAnalysisEntity.fromJson(json);
    return CvAnalysisModel(
      id: entity.id,
      cvId: entity.cvId,
      score: entity.score,
      summary: entity.summary,
      strengths: entity.strengths,
      weaknesses: entity.weaknesses,
      suggestions: entity.suggestions,
      detectedSkills: entity.detectedSkills,
      extracted: entity.extracted,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }
}

/// Data-layer model for [CvEntity].
class CvModel extends CvEntity {
  const CvModel({
    required super.id,
    required super.userId,
    super.fileUrl,
    required super.storagePath,
    required super.originalName,
    required super.mimeType,
    required super.sizeBytes,
    required super.status,
    required super.uploadedAt,
  });

  factory CvModel.fromJson(Map<String, dynamic> json) {
    final entity = CvEntity.fromJson(json);
    return CvModel(
      id: entity.id,
      userId: entity.userId,
      fileUrl: entity.fileUrl,
      storagePath: entity.storagePath,
      originalName: entity.originalName,
      mimeType: entity.mimeType,
      sizeBytes: entity.sizeBytes,
      status: entity.status,
      uploadedAt: entity.uploadedAt,
    );
  }
}

/// Data-layer model combining [CvModel] and [CvAnalysisModel].
///
/// Expected backend response shape (adjust keys if your API differs):
/// ```json
/// {
///   "cv": { ...CvEntity fields... },
///   "analysis": { ...CvAnalysisEntity fields... }
/// }
/// ```
class CvWithAnalysisModel extends CvWithAnalysisEntity {
  const CvWithAnalysisModel({
    required super.cv,
    required super.analysis,
  });

  factory CvWithAnalysisModel.fromJson(Map<String, dynamic> json) {
    return CvWithAnalysisModel(
      cv: CvModel.fromJson(json['cv'] as Map<String, dynamic>),
      analysis:
      CvAnalysisModel.fromJson(json['analysis'] as Map<String, dynamic>),
    );
  }
}

/// Data-layer model for [CvStatusEntity].
class CvStatusModel extends CvStatusEntity {
  const CvStatusModel({
    required super.hasCv,
    required super.hasCompletedAnalysis,
    super.latestCvStatus,
    super.requiredAction,
  });

  factory CvStatusModel.fromJson(Map<String, dynamic> json) {
    final entity = CvStatusEntity.fromJson(json);
    return CvStatusModel(
      hasCv: entity.hasCv,
      hasCompletedAnalysis: entity.hasCompletedAnalysis,
      latestCvStatus: entity.latestCvStatus,
      requiredAction: entity.requiredAction,
    );
  }
}