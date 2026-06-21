class DetectedSkillEntity {
  final String name;
  final String level;
  final String category;
  final String evidence;
  final String? skillId;
  final double confidence;

  const DetectedSkillEntity({
    required this.name,
    required this.level,
    required this.category,
    required this.evidence,
    this.skillId,
    required this.confidence,
  });

  factory DetectedSkillEntity.fromJson(Map<String, dynamic> json) {
    return DetectedSkillEntity(
      name: json['name'] as String,
      level: json['level'] as String,
      category: json['category'] as String,
      evidence: json['evidence'] as String,
      skillId: json['skill_id'] as String?,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}

class CvExtractedEntity {
  final List<String> projects;
  final List<String> languages;
  final List<String> jobKeywords;
  final List<String> certifications;
  final List<String> missingSkills;
  final List<String> interviewFocus;
  final List<String> recommendedRoles;

  const CvExtractedEntity({
    required this.projects,
    required this.languages,
    required this.jobKeywords,
    required this.certifications,
    required this.missingSkills,
    required this.interviewFocus,
    required this.recommendedRoles,
  });

  factory CvExtractedEntity.fromJson(Map<String, dynamic> json) {
    List<String> _list(String key) =>
        List<String>.from(json[key] as List? ?? []);

    return CvExtractedEntity(
      projects: _list('projects'),
      languages: _list('languages'),
      jobKeywords: _list('job_keywords'),
      certifications: _list('certifications'),
      missingSkills: _list('missing_skills'),
      interviewFocus: _list('interview_focus'),
      recommendedRoles: _list('recommended_roles'),
    );
  }
}

class CvAnalysisEntity {
  final String id;
  final String cvId;
  final int score;
  final String summary;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> suggestions;
  final List<DetectedSkillEntity> detectedSkills;
  final CvExtractedEntity extracted;
  final String status;
  final DateTime createdAt;

  const CvAnalysisEntity({
    required this.id,
    required this.cvId,
    required this.score,
    required this.summary,
    required this.strengths,
    required this.weaknesses,
    required this.suggestions,
    required this.detectedSkills,
    required this.extracted,
    required this.status,
    required this.createdAt,
  });

  factory CvAnalysisEntity.fromJson(Map<String, dynamic> json) {
    return CvAnalysisEntity(
      id: json['id'] as String,
      cvId: json['cv_id'] as String,
      score: json['score'] as int,
      summary: json['summary'] as String,
      strengths: List<String>.from(json['strengths'] as List? ?? []),
      weaknesses: List<String>.from(json['weaknesses'] as List? ?? []),
      suggestions: List<String>.from(json['suggestions'] as List? ?? []),
      detectedSkills: (json['detected_skills'] as List? ?? [])
          .map((s) => DetectedSkillEntity.fromJson(s as Map<String, dynamic>))
          .toList(),
      extracted: CvExtractedEntity.fromJson(
        json['extracted'] as Map<String, dynamic>? ?? {},
      ),
      status: json['status'] as String? ?? 'completed',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class CvEntity {
  final String id;
  final String userId;
  final String? fileUrl;
  final String storagePath;
  final String originalName;
  final String mimeType;
  final int sizeBytes;
  final String status;
  final DateTime uploadedAt;

  const CvEntity({
    required this.id,
    required this.userId,
    this.fileUrl,
    required this.storagePath,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.status,
    required this.uploadedAt,
  });

  factory CvEntity.fromJson(Map<String, dynamic> json) {
    return CvEntity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fileUrl: json['file_url'] as String?,
      storagePath: json['storage_path'] as String,
      originalName: json['original_name'] as String,
      mimeType: json['mime_type'] as String,
      sizeBytes: json['size_bytes'] as int,
      status: json['status'] as String,
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
    );
  }
}

class CvWithAnalysisEntity {
  final CvEntity cv;
  final CvAnalysisEntity analysis;

  const CvWithAnalysisEntity({
    required this.cv,
    required this.analysis,
  });
}

class CvStatusEntity {
  final bool hasCv;
  final bool hasCompletedAnalysis;
  final String? latestCvStatus;
  final String? requiredAction;

  const CvStatusEntity({
    required this.hasCv,
    required this.hasCompletedAnalysis,
    this.latestCvStatus,
    this.requiredAction,
  });

  factory CvStatusEntity.fromJson(Map<String, dynamic> json) {
    return CvStatusEntity(
      hasCv: json['hasCv'] as bool,
      hasCompletedAnalysis: json['hasCompletedAnalysis'] as bool,
      latestCvStatus: json['latestCvStatus'] as String?,
      requiredAction: json['requiredAction'] as String?,
    );
  }
}