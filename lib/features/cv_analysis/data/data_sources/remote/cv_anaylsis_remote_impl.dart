import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/cv_anaysis_entity.dart';
import 'cv_anaylsis_remote_data_source.dart';

@LazySingleton(as: CvAnalysisRemoteDataSource)
class CvAnalysisRemoteDataSourceImpl implements CvAnalysisRemoteDataSource {
  const CvAnalysisRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CvStatusModel> getCvStatus() async {
    final response = await _apiClient.get(ApiEndpoints.cvStatus);
    return CvStatusModel(_payload(response.data));
  }

  @override
  Future<CvWithAnalysisModel> uploadAndAnalyze(String filePath) async {
    final response = await _apiClient.uploadFile(
      ApiEndpoints.analyzeCv,
      file: File(filePath),
      fieldName: 'file',
    );
    return CvWithAnalysisModel.fromJson(_payload(response.data));
  }

  @override
  Future<CvWithAnalysisModel> getLatestAnalysis() async {
    final response = await _apiClient.get(ApiEndpoints.latestCvAnalysis);
    return CvWithAnalysisModel.fromJson(_payload(response.data));
  }

  Map<String, dynamic> _payload(dynamic responseData) {
    final envelope = responseData as Map<String, dynamic>;
    final data = envelope['data'];
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid API response');
    }
    return data;
  }
}
