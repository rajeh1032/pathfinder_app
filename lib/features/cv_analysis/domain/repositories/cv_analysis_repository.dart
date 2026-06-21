

import '../entities/cv_anaysis_entity.dart';

abstract class CvAnalysisRepository {
  /// Quick check: does this user already have a CV uploaded/analyzed?
  Future<CvStatusEntity> getCvStatus();

  /// Uploads the PDF at [filePath] and returns the analysis result
  /// once the backend finishes processing it.
  Future<CvWithAnalysisEntity> uploadAndAnalyze(String filePath);

  /// Fetches the most recent CV + its analysis for the current user.
  Future<CvWithAnalysisEntity> getLatestAnalysis();

  /// Fetches a specific CV + its analysis by id.
  Future<CvWithAnalysisEntity> getAnalysisById(String cvId);
}