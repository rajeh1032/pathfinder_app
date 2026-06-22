import 'package:equatable/equatable.dart';

class DetectedSkillEntity extends Equatable {
  const DetectedSkillEntity({
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

  @override
  List<Object?> get props =>
      [name, level, category, evidence, skillId, confidence];
}

class CvExtractedEntity extends Equatable {
  const CvExtractedEntity({
    required this.projects,
    required this.languages,
    required this.jobKeywords,
    required this.certifications,
    required this.missingSkills,
    required this.interviewFocus,
    required this.recommendedRoles,
  });

  final List<String> projects;
  final List<String> languages;
  final List<String> jobKeywords;
  final List<String> certifications;
  final List<String> missingSkills;
  final List<String> interviewFocus;
  final List<String> recommendedRoles;

  @override
  List<Object?> get props => [
        projects,
        languages,
        jobKeywords,
        certifications,
        missingSkills,
        interviewFocus,
        recommendedRoles,
      ];
}

class CvAnalysisEntity extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        cvId,
        score,
        summary,
        strengths,
        weaknesses,
        suggestions,
        detectedSkills,
        extracted,
        status,
        createdAt,
      ];
}

class CvEntity extends Equatable {
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

  final String id;
  final String userId;
  final String? fileUrl;
  final String storagePath;
  final String originalName;
  final String mimeType;
  final int sizeBytes;
  final String status;
  final DateTime uploadedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        fileUrl,
        storagePath,
        originalName,
        mimeType,
        sizeBytes,
        status,
        uploadedAt,
      ];
}

class CvWithAnalysisEntity extends Equatable {
  const CvWithAnalysisEntity({required this.cv, required this.analysis});

  final CvEntity cv;
  final CvAnalysisEntity analysis;

  @override
  List<Object?> get props => [cv, analysis];
}

class CvStatusEntity extends Equatable {
  const CvStatusEntity({
    required this.hasCv,
    required this.hasCompletedAnalysis,
    this.latestCvStatus,
    this.requiredAction,
  });

  final bool hasCv;
  final bool hasCompletedAnalysis;
  final String? latestCvStatus;
  final String? requiredAction;

  @override
  List<Object?> get props => [
        hasCv,
        hasCompletedAnalysis,
        latestCvStatus,
        requiredAction,
      ];
}
