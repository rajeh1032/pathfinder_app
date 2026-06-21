import 'package:dio/dio.dart';

import '../../data/data_sources/remote/cv_anaylsis_remote_data_source.dart';

class CvAnalysisRemoteDataSourceImpl implements CvAnalysisRemoteDataSource {
  final Dio dio;

  CvAnalysisRemoteDataSourceImpl(this.dio);

  /// POST /api/v1/cvs/analyze
  @override
  Future<Map<String, dynamic>> uploadAndAnalyze(String filePath) async {
    final fileName = filePath.split('/').last;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });

    final response = await dio.post(
      '/v1/cvs/analyze',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    return response.data as Map<String, dynamic>;
  }

  /// GET /api/v1/cvs/latest
  @override
  Future<Map<String, dynamic>> getLatestAnalysis() async {
    final response = await dio.get('/v1/cvs/latest');
    return response.data as Map<String, dynamic>;
  }

  /// GET /api/v1/cvs/status
  @override
  Future<Map<String, dynamic>> getCvStatus() async {
    final response = await dio.get('/v1/cvs/status');
    return response.data as Map<String, dynamic>;
  }
}