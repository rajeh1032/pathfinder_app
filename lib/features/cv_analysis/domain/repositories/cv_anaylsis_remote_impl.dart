import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/chat_enjection.dart';
import '../../data/data_sources/remote/cv_anaylsis_remote_data_source.dart';

@LazySingleton(as: CvAnalysisRemoteDataSource)
class CvAnalysisRemoteDataSourceImpl implements CvAnalysisRemoteDataSource {
  final Dio _dio;

  CvAnalysisRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getCvStatus() async {
    try {
      final response = await _dio.get('/cv/status');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> uploadAndAnalyze(
      String filePath, {
        void Function(double progress)? onProgress,
      }) async {
    try {
      final fileName = filePath.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType('application', 'pdf'),
        ),
      });

      final response = await _dio.post(
        '/cv/upload',
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0 && onProgress != null) {
            onProgress(sent / total);
          }
        },
      );

      return response.data['cv'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getLatestAnalysis() async {
    try {
      final response = await _dio.get('/cv/latest');
      return response.data['cv'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getAnalysisById(String cvId) async {
    try {
      final response = await _dio.get('/cv/$cvId');
      return response.data['cv'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}