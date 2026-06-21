import '../entities/cv_anaysis_entity.dart';

abstract class CvAnalysisRepository {
  /// POST /api/v1/cvs/analyze
  /// Upload PDF and get analysis result
  Future<CvWithAnalysisEntity> uploadAndAnalyze(String filePath);

  /// GET /api/v1/cvs/latest
  /// Get latest CV with full analysis
  Future<CvWithAnalysisEntity> getLatestAnalysis();

  /// GET /api/v1/cvs/status
  /// Check if user has CV and analysis
  Future<CvStatusEntity> getCvStatus();
  /// GET /api/v1/cvs/{id}
  /// Get CV with full analysis by ID
  Future<CvWithAnalysisEntity> getAnalysisById(String cvId);

}