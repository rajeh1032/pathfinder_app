// lib/features/home/data/data_sources/remote/home_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  Future<Map<String, dynamic>?> getCvLatest();
  Future<Map<String, dynamic>?> getMyRoadmap();
  Future<List<Map<String, dynamic>>> getJobMatches();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>?> getCvLatest() async {
    try {
      final response = await dio.get('/v1/cvs/latest');
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) return null;
      final hasAnalysis = data['hasAnalysis'] as bool? ?? false;
      if (!hasAnalysis) return null;
      return data;
    } on DioException catch (e) {
      // 404 means no CV yet — return null gracefully
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getMyRoadmap() async {
    try {
      final response = await dio.get('/v1/roadmaps/me');
      return response.data['data'] as Map<String, dynamic>?;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getJobMatches() async {
    try {
      final response = await dio.get('/jobs/matches');
      final data = response.data['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }
}