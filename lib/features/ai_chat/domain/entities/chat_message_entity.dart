import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  const ChatMessageEntity({
    required this.id,
    required this.sessionId,
    required this.sender,
    required this.message,
    this.tokens,
    required this.createdAt,
  });

  final String id;
  final String sessionId;
  final String sender;
  final String message;
  final int? tokens;
  final DateTime createdAt;

  bool get isFromUser => sender == 'user';

  @override
  List<Object?> get props =>
      [id, sessionId, sender, message, tokens, createdAt];
}

class ChatReplyEntity extends Equatable {
  const ChatReplyEntity(
      {required this.userMessage, required this.assistantMessage});

  final ChatMessageEntity userMessage;
  final ChatMessageEntity assistantMessage;

  @override
  List<Object?> get props => [userMessage, assistantMessage];
}
