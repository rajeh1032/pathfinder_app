import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_session_entity.dart';
import '../../domain/repositories/chat_repo.dart';
import '../data_sources/remote/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatSessionEntity> createSession({String? title}) async {
    final data = await remoteDataSource.createSession(title: title);
    return ChatSessionEntity.fromJson(data);
  }

  @override
  Future<List<ChatSessionEntity>> getSessions() async {
    final data = await remoteDataSource.getSessions();
    return data.map((s) => ChatSessionEntity.fromJson(s)).toList();
  }

  @override
  Future<List<ChatMessageEntity>> getMessages(String sessionId) async {
    final data = await remoteDataSource.getMessages(sessionId);
    return data.map((m) => ChatMessageEntity.fromJson(m)).toList();
  }

  @override
  Future<Map<String, ChatMessageEntity>> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final data = await remoteDataSource.sendMessage(
      sessionId: sessionId,
      message: message,
    );

    return {
      'userMessage': ChatMessageEntity.fromJson(
        data['userMessage'] as Map<String, dynamic>,
      ),
      'assistantMessage': ChatMessageEntity.fromJson(
        data['assistantMessage'] as Map<String, dynamic>,
      ),
    };
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await remoteDataSource.deleteSession(sessionId);
  }
}