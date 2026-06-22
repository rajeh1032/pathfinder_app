import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/chat_models.dart';
import 'chat_remote_data_source.dart';

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ChatSessionModel> createSession({String? title}) async {
    final response = await _apiClient.post(
      ApiEndpoints.chatSessions,
      data: title == null ? const {} : {'title': title},
    );
    final json = response.data as Map<String, dynamic>;
    return ChatSessionModel(json['session'] as Map<String, dynamic>);
  }

  @override
  Future<List<ChatSessionModel>> getSessions() async {
    final response = await _apiClient.get(ApiEndpoints.chatSessions);
    final json = response.data as Map<String, dynamic>;
    return (json['sessions'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(ChatSessionModel.new)
        .toList();
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String sessionId) async {
    final response = await _apiClient.get(ApiEndpoints.chatMessages(sessionId));
    final json = response.data as Map<String, dynamic>;
    return (json['messages'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((item) => ChatMessageModel(item, sessionId: sessionId))
        .toList();
  }

  @override
  Future<ChatReplyModel> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.sendChatMessage(sessionId),
      data: {'message': message},
    );
    return ChatReplyModel(
      response.data as Map<String, dynamic>,
      sessionId: sessionId,
    );
  }

  @override
  Future<void> deleteSession(String sessionId) =>
      _apiClient.delete(ApiEndpoints.deleteSession(sessionId));
}
