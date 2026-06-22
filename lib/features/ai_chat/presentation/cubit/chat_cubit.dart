import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_session_entity.dart';
import '../../domain/repositories/chat_repo.dart';
import 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit(this._repository) : super(const ChatInitial());

  Future<void> loadSessions() async {
    final currentState = state;

    if (currentState is! ChatLoaded) {
      emit(const ChatSessionsLoading());
    }

    try {
      final sessions = await _repository.getSessions();

      if (currentState is ChatLoaded) {
        emit(currentState.copyWith(sessions: sessions));
      } else {
        emit(ChatSessionsLoaded(sessions));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<ChatSessionEntity?> createSession({String? title}) async {
    try {
      final session = await _repository.createSession(title: title);
      await loadSessions();
      return session;
    } catch (e) {
      emit(ChatError(e.toString()));
      return null;
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      await _repository.deleteSession(sessionId);
      await loadSessions();
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> loadMessages(String sessionId) async {
    final currentState = state;
    final currentSessions = currentState is ChatLoaded
        ? currentState.sessions
        : <ChatSessionEntity>[];

    emit(const ChatLoading());

    try {
      final messages = await _repository.getMessages(sessionId);
      final sessions = currentSessions.isNotEmpty
          ? currentSessions
          : await _repository.getSessions();

      emit(ChatLoaded(
        messages: messages,
        sessionId: sessionId,
        sessions: sessions,
      ));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> getSessions() async => loadSessions();

  Future<void> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final currentState = state;

    final currentMessages = currentState is ChatLoaded
        ? currentState.messages
        : <ChatMessageEntity>[];

    final currentSessions = currentState is ChatLoaded
        ? currentState.sessions
        : <ChatSessionEntity>[];

    final optimisticUserMessage = ChatMessageEntity(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      sessionId: sessionId,
      sender: 'user',
      message: message,
      tokens: 0,
      createdAt: DateTime.now(),
    );

    emit(ChatLoaded(
      messages: [...currentMessages, optimisticUserMessage],
      sessionId: sessionId,
      sessions: currentSessions,
      isTyping: true,
    ));

    try {
      final result = await _repository.sendMessage(
        sessionId: sessionId,
        message: message,
      );

      final userMessage = result['userMessage'];
      final assistantMessage = result['assistantMessage'];

      final updatedMessages = [...currentMessages];

      if (userMessage != null) {
        updatedMessages.add(userMessage);
      } else {
        updatedMessages.add(optimisticUserMessage);
      }

      if (assistantMessage != null) {
        updatedMessages.add(assistantMessage);
      }

      final updatedSessions = await _repository.getSessions();

      emit(ChatLoaded(
        messages: updatedMessages,
        sessionId: sessionId,
        sessions: updatedSessions,
        isTyping: false,
      ));
    } catch (e) {
      emit(ChatLoaded(
        messages: [...currentMessages, optimisticUserMessage],
        sessionId: sessionId,
        sessions: currentSessions,
        isTyping: false,
      ));

      emit(ChatError(e.toString()));
    }
  }
}