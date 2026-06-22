import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_session_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatSessionEntity>> createSession({String? title});
  Future<Either<Failure, List<ChatSessionEntity>>> getSessions();
  Future<Either<Failure, List<ChatMessageEntity>>> getMessages(
      String sessionId);
  Future<Either<Failure, ChatReplyEntity>> sendMessage({
    required String sessionId,
    required String message,
  });
  Future<Either<Failure, Unit>> deleteSession(String sessionId);
}
