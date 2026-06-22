import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/applied_job_model.dart';
import '../../models/job_match_model.dart';
import '../../models/job_model.dart';
import '../../models/saved_job_model.dart';

abstract class JobsRemoteDataSource {
  Future<List<JobModel>> getJobs({int page = 1, int limit = 20});

  Future<List<JobMatchModel>> getMatchedJobs({int page = 1, int limit = 20});

  Future<List<JobMatchModel>> generateJobMatches({int limit = 20});

  Future<JobModel> getJobDetails(String jobId);

  Future<void> saveJob(String jobId);

  Future<void> unsaveJob(String jobId);

  Future<void> applyToJob(String jobId);

  Future<List<SavedJobModel>> getSavedJobs();

  Future<List<AppliedJobModel>> getAppliedJobs();
}

class JobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  const JobsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<JobModel>> getJobs({int page = 1, int limit = 20}) async {
    final response = await _apiClient.get(
      ApiEndpoints.jobs,
      queryParameters: {'page': page, 'limit': limit},
    );
    return _parseList(response.data, JobModel.fromJson);
  }

  @override
  Future<List<JobMatchModel>> getMatchedJobs({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      ApiEndpoints.matchedJobs,
      queryParameters: {
        'page': page,
        'limit': limit,
        'includeWeak': true,
        'includeFallback': true,
        'minScore': 0,
      },
    );
    return _parseList(response.data, JobMatchModel.fromJson);
  }

  @override
  Future<List<JobMatchModel>> generateJobMatches({int limit = 20}) async {
    final response = await _apiClient.post(
      ApiEndpoints.generateJobMatches,
      data: {
        'limit': limit,
        'concurrency': 2,
      },
    );
    return _parseList(response.data, JobMatchModel.fromJson);
  }

  @override
  Future<JobModel> getJobDetails(String jobId) async {
    final response = await _apiClient.get(ApiEndpoints.jobDetails(jobId));
    final json = _parseObject(response.data);
    return JobModel.fromJson(json);
  }

  @override
  Future<void> saveJob(String jobId) async {
    await _apiClient.post(ApiEndpoints.saveJob(jobId));
  }

  @override
  Future<void> unsaveJob(String jobId) async {
    await _apiClient.delete(ApiEndpoints.saveJob(jobId));
  }

  @override
  Future<void> applyToJob(String jobId) async {
    await _apiClient.post(ApiEndpoints.applyToJob(jobId));
  }

  @override
  Future<List<SavedJobModel>> getSavedJobs() async {
    final response = await _apiClient.get(ApiEndpoints.savedJobs);
    return _parseList(response.data, SavedJobModel.fromJson);
  }

  @override
  Future<List<AppliedJobModel>> getAppliedJobs() async {
    final response = await _apiClient.get(ApiEndpoints.appliedJobs);
    return _parseList(response.data, AppliedJobModel.fromJson);
  }
}

List<T> _parseList<T>(
  Object? body,
  T Function(Map<String, dynamic>) fromJson,
) {
  final list = switch (body) {
    {'data': final List<dynamic> data} => data,
    final List<dynamic> data => data,
    _ => throw const FormatException('Unexpected jobs response format'),
  };

  return list
      .whereType<Map<String, dynamic>>()
      .map(fromJson)
      .toList(growable: false);
}

Map<String, dynamic> _parseObject(Object? body) {
  final object = switch (body) {
    {'data': final Map<String, dynamic> data} => data,
    final Map<String, dynamic> data => data,
    _ => throw const FormatException('Unexpected job response format'),
  };
  return object;
}
