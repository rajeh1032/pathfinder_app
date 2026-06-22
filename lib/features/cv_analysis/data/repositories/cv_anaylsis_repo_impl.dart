import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import '../models/cv_anaysis_entity.dart';

@LazySingleton(as: CvAnalysisRepository)
class CvAnalysisRepositoryImpl implements CvAnalysisRepository {
  final ApiClient _apiClient;

  CvAnalysisRepositoryImpl(this._apiClient);

  @override
  Future<CvWithAnalysisEntity> uploadAndAnalyze(String filePath) async {
    final response = await _apiClient.uploadFile(
      ApiEndpoints.analyzeCv,
      file: File(filePath),
      fieldName: 'file',
    );
    return CvWithAnalysisModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<CvWithAnalysisEntity> getLatestAnalysis() async {
    final response = await _apiClient.get(ApiEndpoints.latestCvAnalysis);
    return CvWithAnalysisModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<CvStatusEntity> getCvStatus() async {
    final response = await _apiClient.get(ApiEndpoints.cvStatus);
    return CvStatusModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CvWithAnalysisEntity> getAnalysisById(String cvId) async {
    final response = await _apiClient.get(ApiEndpoints.cvDetails(cvId));
    return CvWithAnalysisModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}