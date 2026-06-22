import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/interview_history_model.dart';

abstract class InterviewHistoryRemoteDataSource {
  Future<InterviewHistoryModel> getHistory({
    String? query,
    String? interviewType,
    String? status,
    int page,
    int limit,
  });
}

@LazySingleton(as: InterviewHistoryRemoteDataSource)
class InterviewHistoryRemoteDataSourceImpl
    implements InterviewHistoryRemoteDataSource {
  const InterviewHistoryRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<InterviewHistoryModel> getHistory({
    String? query,
    String? interviewType,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (query != null && query.trim().isNotEmpty) {
      queryParameters['q'] = query.trim();
    }
    if (interviewType != null && interviewType.isNotEmpty) {
      queryParameters['interview_type'] = interviewType;
    }
    if (status != null && status.isNotEmpty) {
      queryParameters['status'] = status;
    }

    final response = await _apiClient.get(
      ApiEndpoints.interviewSessions,
      queryParameters: queryParameters,
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return InterviewHistoryModel.fromJson(data);
    }

    throw const FormatException('Invalid interview history response');
  }
}
