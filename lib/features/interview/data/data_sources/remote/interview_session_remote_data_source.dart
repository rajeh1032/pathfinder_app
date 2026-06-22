import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/interview_result_model.dart';
import '../../models/interview_session_questions_model.dart';

abstract class InterviewSessionRemoteDataSource {
  Future<InterviewSessionQuestionsModel> getSessionQuestions(String sessionId);

  Future<InterviewResultModel> getSessionResult(String sessionId);

  Future<void> saveAnswer({
    required String sessionId,
    required String questionId,
    required int selectedOptionIndex,
  });

  Future<void> skipQuestion({
    required String sessionId,
    required String questionId,
  });

  Future<void> cancelSession(String sessionId);

  Future<void> finishSession(String sessionId);
}

@LazySingleton(as: InterviewSessionRemoteDataSource)
class InterviewSessionRemoteDataSourceImpl
    implements InterviewSessionRemoteDataSource {
  const InterviewSessionRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<InterviewSessionQuestionsModel> getSessionQuestions(
    String sessionId,
  ) async {
    final response = await _apiClient.get(
      ApiEndpoints.interviewSessionQuestions(sessionId),
    );
    final payload = _extractObject(response.data);

    if (payload is Map<String, dynamic>) {
      final model = InterviewSessionQuestionsModel.fromJson(payload);
      if (model.sessionId.isNotEmpty) {
        return model;
      }
    }

    throw const FormatException('Invalid interview questions response');
  }

  @override
  Future<InterviewResultModel> getSessionResult(String sessionId) async {
    final response = await _apiClient.get(
      ApiEndpoints.interviewSessionResult(sessionId),
    );
    final payload = _extractObject(response.data);

    if (payload is Map<String, dynamic> && payload.isNotEmpty) {
      return InterviewResultModel.fromJson(payload);
    }

    throw const FormatException('Invalid interview result response');
  }

  @override
  Future<void> saveAnswer({
    required String sessionId,
    required String questionId,
    required int selectedOptionIndex,
  }) async {
    await _apiClient.patch(
      ApiEndpoints.interviewQuestionAnswer(sessionId, questionId),
      data: {'selected_option_index': selectedOptionIndex},
    );
  }

  @override
  Future<void> skipQuestion({
    required String sessionId,
    required String questionId,
  }) async {
    await _apiClient.patch(
      ApiEndpoints.interviewQuestionSkip(sessionId, questionId),
    );
  }

  @override
  Future<void> cancelSession(String sessionId) async {
    await _apiClient.patch(ApiEndpoints.cancelInterviewSession(sessionId));
  }

  @override
  Future<void> finishSession(String sessionId) async {
    await _apiClient.patch(ApiEndpoints.finishInterviewSession(sessionId));
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
