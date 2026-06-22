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
    emit(const ChatSessionsLoading());
    try {
      final sessions = await _repository.getSessions();
      emit(ChatSessionsLoaded(sessions));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<ChatSessionEntity?> createSession({String? title}) async {
    try {
      final session = await _repository.createSession(title: title);
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
    emit(const ChatLoading());
    try {
      final messages = await _repository.getMessages(sessionId);
      emit(ChatLoaded(messages: messages, sessionId: sessionId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
  Future<void> getSessions() async {
    emit(const ChatSessionsLoading());
    try {
      final sessions = await _repository.getSessions();
      emit(ChatSessionsLoaded(sessions));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final currentState = state;
    final List<ChatMessageEntity> currentMessages =
    currentState is ChatLoaded ? currentState.messages : [];
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
      if (userMessage != null) updatedMessages.add(userMessage);
      if (assistantMessage != null) updatedMessages.add(assistantMessage);

      emit(ChatLoaded(
        messages: updatedMessages,
        sessionId: sessionId,
        isTyping: false,
      ));
    } catch (e) {
      emit(ChatLoaded(
        messages: [...currentMessages, optimisticUserMessage],
        sessionId: sessionId,
        isTyping: false,
      ));
      emit(ChatError(e.toString()));
    }
  }
}