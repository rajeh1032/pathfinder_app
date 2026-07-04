import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_session_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatSessionsLoading extends ChatState {
  const ChatSessionsLoading();
}

class ChatSessionsLoaded extends ChatState {
  final List<ChatSessionEntity> sessions;

  const ChatSessionsLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final List<ChatMessageEntity> messages;
  final List<ChatSessionEntity> sessions;
  final bool isTyping;
  final String sessionId;

  const ChatLoaded({
    required this.messages,
    required this.sessionId,
    this.sessions = const [],
    this.isTyping = false,
  });

  ChatLoaded copyWith({
    List<ChatMessageEntity>? messages,
    List<ChatSessionEntity>? sessions,
    bool? isTyping,
    String? sessionId,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      sessions: sessions ?? this.sessions,
      isTyping: isTyping ?? this.isTyping,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  List<Object?> get props => [messages, sessions, isTyping, sessionId];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
