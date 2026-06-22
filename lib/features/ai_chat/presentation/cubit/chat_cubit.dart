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

  void _emitIfOpen(ChatState nextState) {
    if (!isClosed) emit(nextState);
  }

  Future<void> loadSessions() async {
    if (isClosed) return;
    final currentState = state;

    if (currentState is! ChatLoaded) {
      _emitIfOpen(const ChatSessionsLoading());
    }

    final result = await _repository.getSessions();
    if (isClosed) return;
    result.fold(
      (failure) => _emitIfOpen(ChatError(failure.message)),
      (sessions) => currentState is ChatLoaded
          ? _emitIfOpen(currentState.copyWith(sessions: sessions))
          : _emitIfOpen(ChatSessionsLoaded(sessions)),
    );
  }

  Future<ChatSessionEntity?> createSession({String? title}) async {
    final result = await _repository.createSession(title: title);
    if (isClosed) return null;
    return result.fold(
      (failure) {
        _emitIfOpen(ChatError(failure.message));
        return null;
      },
      (session) => session,
    );
  }

  Future<void> deleteSession(String sessionId) async {
    final result = await _repository.deleteSession(sessionId);
    if (isClosed) return;
    await result.fold(
      (failure) async => _emitIfOpen(ChatError(failure.message)),
      (_) => loadSessions(),
    );
  }

  Future<void> loadMessages(String sessionId) async {
    if (isClosed) return;
    final currentState = state;
    final currentSessions = currentState is ChatLoaded
        ? currentState.sessions
        : <ChatSessionEntity>[];

    _emitIfOpen(const ChatLoading());

    final messagesResult = await _repository.getMessages(sessionId);
    if (isClosed) return;
    await messagesResult.fold(
      (failure) async => _emitIfOpen(ChatError(failure.message)),
      (messages) async {
        var sessions = currentSessions;
        if (sessions.isEmpty) {
          final sessionsResult = await _repository.getSessions();
          if (isClosed) return;
          sessionsResult.fold(
            (failure) => _emitIfOpen(ChatError(failure.message)),
            (value) => sessions = value,
          );
        }
        if (!isClosed && state is! ChatError) {
          _emitIfOpen(ChatLoaded(
            messages: messages,
            sessionId: sessionId,
            sessions: sessions,
          ));
        }
      },
    );
  }

  Future<void> getSessions() async => loadSessions();

  Future<void> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    if (isClosed) return;
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

    _emitIfOpen(ChatLoaded(
      messages: [...currentMessages, optimisticUserMessage],
      sessionId: sessionId,
      sessions: currentSessions,
      isTyping: true,
    ));

    final result = await _repository.sendMessage(
      sessionId: sessionId,
      message: message,
    );
    if (isClosed) return;
    await result.fold(
      (failure) async {
        _emitIfOpen(ChatLoaded(
          messages: [...currentMessages, optimisticUserMessage],
          sessionId: sessionId,
          sessions: currentSessions,
        ));
        _emitIfOpen(ChatError(failure.message));
      },
      (reply) async {
        final sessionsResult = await _repository.getSessions();
        if (isClosed) return;
        final sessions = sessionsResult.getOrElse(() => currentSessions);
        _emitIfOpen(ChatLoaded(
          messages: [
            ...currentMessages,
            reply.userMessage,
            reply.assistantMessage,
          ],
          sessionId: sessionId,
          sessions: sessions,
        ));
      },
    );
  }
}
