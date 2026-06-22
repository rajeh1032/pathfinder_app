import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/saved_job_model.dart';

abstract class SavedJobsRemoteDataSource {
  Future<List<SavedJobModel>> getSavedJobs();
}

@LazySingleton(as: SavedJobsRemoteDataSource)
class SavedJobsRemoteDataSourceImpl implements SavedJobsRemoteDataSource {
  const SavedJobsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<SavedJobModel>> getSavedJobs() async {
    final response = await _apiClient.get(ApiEndpoints.savedJobs);
    final body = response.data;

    // Handles { data: { jobs: [] } }, { data: { savedJobs: [] } },
    // { data: [] } and a bare [].
    final List<dynamic> list = switch (body) {
      {'data': {'jobs': final List<dynamic> l}} => l,
      {'data': {'savedJobs': final List<dynamic> l}} => l,
      {'data': final List<dynamic> l} => l,
      final List<dynamic> l => l,
      _ => throw const FormatException('Unexpected saved jobs response format'),
    };

    return list
        .whereType<Map<String, dynamic>>()
        .map(SavedJobModel.fromJson)
        .toList();
  }
}
