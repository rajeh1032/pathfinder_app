import '../entities/chat_message_entity.dart';
import '../entities/chat_session_entity.dart';

abstract class ChatRepository{
  Future<ChatSessionEntity> createSession({String? title});
  Future<List<ChatSessionEntity>> getSessions();
  Future<List<ChatMessageEntity>> getMessages(String sessionId);
  Future<Map<String, ChatMessageEntity>> sendMessage({
    required String sessionId,
    required String message,
  });
  Future<void> deleteSession(String sessionId);}