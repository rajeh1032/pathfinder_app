
/// Lightweight status check — used by checkStatus() to know if the user
/// already has a CV uploaded/analyzed before showing upload UI.
class CvStatusEntity {
  final bool hasCv;
  final String? cvId;
  final String status; // none | uploaded | processing | analyzed | failed

  const CvStatusEntity({
    required this.hasCv,
    required this.status,
    this.cvId,
  });

  factory CvStatusEntity.fromJson(Map<String, dynamic> json) {
    return CvStatusEntity(
      hasCv: json['has_cv'] as bool? ?? false,
      cvId: json['cv_id'] as String?,
      status: json['status'] as String? ?? 'none',
    );
  }
}

/// Full CV + its analysis result, returned after upload/analyze or when
/// fetching the latest/by-id analysis.
class CvWithAnalysisEntity {
  final CvEntity cv;
  final String originalName;
  final CvAnalysisDetailsEntity? analysis;

  const CvWithAnalysisEntity({
    required this.cv,
    required this.originalName,
    this.analysis,
  });

  factory CvWithAnalysisEntity.fromJson(Map<String, dynamic> json) {
    final analysisJson = json['cv_analyses'] is List
        ? (json['cv_analyses'] as List).firstOrNull
        : json['cv_analyses'];

    return CvWithAnalysisEntity(
      cv: CvEntity.fromJson(json),
      originalName: json['original_name'] as String? ?? '',
      analysis: analysisJson != null
          ? CvAnalysisDetailsEntity.fromJson(
        analysisJson as Map<String, dynamic>,
      )
          : null,
    );
  }
}

class CvEntity {
  final String id;
  final String status; // uploaded | processing | analyzed | failed
  final DateTime uploadedAt;

  const CvEntity({
    required this.id,
    required this.status,
    required this.uploadedAt,
  });

  factory CvEntity.fromJson(Map<String, dynamic> json) {
    return CvEntity(
      id: json['id'] as String,
      status: json['status'] as String? ?? 'uploaded',
      uploadedAt: DateTime.parse(
        json['uploaded_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

class CvAnalysisDetailsEntity {
  final int score;
  final String summary;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> suggestions;

  const CvAnalysisDetailsEntity({
    required this.score,
    required this.summary,
    required this.strengths,
    required this.weaknesses,
    required this.suggestions,
  });

  factory CvAnalysisDetailsEntity.fromJson(Map<String, dynamic> json) {
    return CvAnalysisDetailsEntity(
      score: json['score'] as int? ?? 0,
      summary: json['summary'] as String? ?? '',
      strengths: List<String>.from(json['strengths'] ?? []),
      weaknesses: List<String>.from(json['weaknesses'] ?? []),
      suggestions: List<String>.from(json['suggestions'] ?? []),
    );
  }
}

extension _FirstOrNullExt<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}