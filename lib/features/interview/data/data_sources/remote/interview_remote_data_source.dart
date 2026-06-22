import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/interview_career_path_model.dart';
import '../../models/interview_session_model.dart';

abstract class InterviewRemoteDataSource {
  Future<List<InterviewCareerPathModel>> getCareerPaths();

  Future<InterviewSessionModel> createSession({
    required String careerPathId,
    required String interviewType,
    required int totalQuestions,
  });
}

@LazySingleton(as: InterviewRemoteDataSource)
class InterviewRemoteDataSourceImpl implements InterviewRemoteDataSource {
  const InterviewRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<InterviewCareerPathModel>> getCareerPaths() async {
    final response = await _apiClient.get(ApiEndpoints.interviewCareerPaths);
    final data = response.data;
    final items = _extractList(data);

    return items
        .whereType<Map<String, dynamic>>()
        .map(InterviewCareerPathModel.fromJson)
        .where((item) => item.id.isNotEmpty && item.name.isNotEmpty)
        .toList();
  }

  @override
  Future<InterviewSessionModel> createSession({
    required String careerPathId,
    required String interviewType,
    required int totalQuestions,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.interviewSessions,
      data: {
        'career_path_id': careerPathId,
        'interview_type': interviewType,
        'total_questions': totalQuestions,
      },
    );

    final payload = _extractObject(response.data);
    if (payload is Map<String, dynamic>) {
      final model = InterviewSessionModel.fromJson(payload);
      if (model.id.isEmpty) {
        throw const FormatException('Invalid interview session response');
      }

      return InterviewSessionModel(
        id: model.id,
        careerPathId:
            model.careerPathId.isNotEmpty ? model.careerPathId : careerPathId,
        interviewType: model.interviewType.isNotEmpty
            ? model.interviewType
            : interviewType,
        totalQuestions:
            model.totalQuestions > 0 ? model.totalQuestions : totalQuestions,
      );
    }

    throw const FormatException('Invalid interview session response');
  }

  List<dynamic> _extractList(dynamic data) {
    if (data is List) return data;
    final object = _extractObject(data);
    if (object is Map<String, dynamic>) {
      for (final key in [
        'data',
        'items',
        'results',
        'career_paths',
        'careerPaths'
      ]) {
        final value = object[key];
        if (value is List) return value;
      }
    }
    return const [];
  }

  dynamic _extractObject(dynamic data) {
    if (data is Map<String, dynamic>) {
      for (final key in ['data', 'session', 'result']) {
        final nested = data[key];
        if (nested is Map<String, dynamic>) return nested;
      }
      return data;
    }
    return data;
  }
}
