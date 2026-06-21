import 'package:dio/dio.dart';

abstract class CvAnalysisRemoteDataSource {
  Future<Map<String, dynamic>> uploadAndAnalyze(String filePath);
  Future<Map<String, dynamic>> getLatestAnalysis();
  Future<Map<String, dynamic>> getCvStatus();
}

