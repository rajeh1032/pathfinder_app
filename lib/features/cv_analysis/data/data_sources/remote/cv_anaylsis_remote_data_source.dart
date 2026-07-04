import '../../models/cv_anaysis_entity.dart';

abstract class CvAnalysisRemoteDataSource {
  Future<CvWithAnalysisModel> uploadAndAnalyze(String filePath);
  Future<CvWithAnalysisModel> getLatestAnalysis();
  Future<CvStatusModel> getCvStatus();
  Future<CvHistoryResultModel> getHistory();
  Future<CvFileUrlModel> getFileUrl(String cvId);
}
