import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_session_entity.dart';

DateTime _date(dynamic value) =>
    DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();

class ChatMessageModel {
  const ChatMessageModel(this.json, {this.sessionId = ''});
  final Map<String, dynamic> json;
  final String sessionId;

  ChatMessageEntity toEntity() => ChatMessageEntity(
        id: json['id'] as String? ??
            '${json['sender'] ?? 'message'}-${_date(json['created_at']).microsecondsSinceEpoch}',
        sessionId: json['session_id'] as String? ?? sessionId,
        sender: json['sender'] as String? ?? 'assistant',
        message: json['message'] as String? ?? '',
        tokens: (json['tokens'] as num?)?.round(),
        createdAt: _date(json['created_at']),
      );
}

class ChatSessionModel {
  const ChatSessionModel(this.json);
  final Map<String, dynamic> json;

  ChatSessionEntity toEntity() => ChatSessionEntity(
        id: json['id'] as String? ?? '',
        userId: json['user_id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        status: json['status'] as String? ?? 'active',
        createdAt: _date(json['created_at']),
        updatedAt: _date(json['updated_at'] ?? json['created_at']),
      );
}

class ChatReplyModel {
  const ChatReplyModel(this.json, {required this.sessionId});
  final Map<String, dynamic> json;
  final String sessionId;

  ChatReplyEntity toEntity() => ChatReplyEntity(
        userMessage: ChatMessageModel(
          json['userMessage'] as Map<String, dynamic>? ?? const {},
          sessionId: sessionId,
        ).toEntity(),
        assistantMessage: ChatMessageModel(
          json['assistantMessage'] as Map<String, dynamic>? ?? const {},
          sessionId: sessionId,
        ).toEntity(),
      );
}
