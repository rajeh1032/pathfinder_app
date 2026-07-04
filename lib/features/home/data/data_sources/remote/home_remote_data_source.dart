import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';

abstract class HomeRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> getLatestCvAnalysis();
  Future<Map<String, dynamic>> getMyRoadmap();
  Future<List<Map<String, dynamic>>> getJobMatches();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _apiClient.get(ApiEndpoints.profileMe);
    return _readMap(response.data);
  }

  @override
  Future<Map<String, dynamic>> getLatestCvAnalysis() async {
    final response = await _apiClient.get(ApiEndpoints.latestCvAnalysis);
    return _readMap(response.data);
  }

  @override
  Future<Map<String, dynamic>> getMyRoadmap() async {
    final response = await _apiClient.get(ApiEndpoints.myRoadmap);
    return _readMap(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> getJobMatches() async {
    final response = await _apiClient.get(
      ApiEndpoints.jobMatches,
      queryParameters: const {'page': 1, 'limit': 3},
    );
    final envelope = response.data as Map<String, dynamic>;
    final data = envelope['data'];
    if (data is! List) return const [];
    return data.whereType<Map<String, dynamic>>().toList();
  }

  Map<String, dynamic> _readMap(dynamic responseData) {
    final envelope = responseData as Map<String, dynamic>;
    final data = envelope['data'];
    return data is Map<String, dynamic> ? data : const {};
  }
}
