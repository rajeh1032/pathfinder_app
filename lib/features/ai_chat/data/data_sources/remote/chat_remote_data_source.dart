import '../../models/chat_models.dart';

abstract class ChatRemoteDataSource {
  Future<ChatSessionModel> createSession({String? title});
  Future<List<ChatSessionModel>> getSessions();
  Future<List<ChatMessageModel>> getMessages(String sessionId);
  Future<ChatReplyModel> sendMessage({
    required String sessionId,
    required String message,
  });
  Future<void> deleteSession(String sessionId);
}
