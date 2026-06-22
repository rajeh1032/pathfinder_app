import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/interview_question.dart';
import '../../domain/entities/interview_session_questions.dart';
import '../../domain/use_cases/cancel_interview_session_use_case.dart';
import '../../domain/use_cases/finish_interview_session_use_case.dart';
import '../../domain/use_cases/get_interview_session_questions_use_case.dart';
import '../../domain/use_cases/save_interview_answer_use_case.dart';
import '../../domain/use_cases/skip_interview_question_use_case.dart';

part 'interview_active_state.dart';

@injectable
class InterviewActiveCubit extends Cubit<InterviewActiveState> {
  InterviewActiveCubit({
    required GetInterviewSessionQuestionsUseCase getSessionQuestionsUseCase,
    required SaveInterviewAnswerUseCase saveInterviewAnswerUseCase,
    required SkipInterviewQuestionUseCase skipInterviewQuestionUseCase,
    required FinishInterviewSessionUseCase finishInterviewSessionUseCase,
    required CancelInterviewSessionUseCase cancelInterviewSessionUseCase,
  })  : _getSessionQuestionsUseCase = getSessionQuestionsUseCase,
        _saveInterviewAnswerUseCase = saveInterviewAnswerUseCase,
        _skipInterviewQuestionUseCase = skipInterviewQuestionUseCase,
        _finishInterviewSessionUseCase = finishInterviewSessionUseCase,
        _cancelInterviewSessionUseCase = cancelInterviewSessionUseCase,
        super(const InterviewActiveState());

  final GetInterviewSessionQuestionsUseCase _getSessionQuestionsUseCase;
  final SaveInterviewAnswerUseCase _saveInterviewAnswerUseCase;
  final SkipInterviewQuestionUseCase _skipInterviewQuestionUseCase;
  final FinishInterviewSessionUseCase _finishInterviewSessionUseCase;
  final CancelInterviewSessionUseCase _cancelInterviewSessionUseCase;

  Future<void> loadSessionQuestions(String? sessionId) async {
    if (sessionId == null || sessionId.trim().isEmpty) {
      emit(state.copyWith(errorMessage: ErrorMessages.unknown));
      return;
    }

    emit(state.copyWith(
      sessionId: sessionId,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await _getSessionQuestionsUseCase(sessionId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          sessionQuestions: null,
        ),
      ),
      (sessionQuestions) {
        emit(
          state.copyWith(
            isLoading: false,
            sessionQuestions: _normalizeQuestions(sessionQuestions),
            currentQuestionIndex: 0,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<Failure?> selectOption(int selectedOptionIndex) async {
    final sessionId = state.sessionId;
    final question = state.currentQuestion;
    if (sessionId == null || question == null || state.isActionLoading) {
      return null;
    }

    emit(state.copyWith(isActionLoading: true, errorMessage: null));
    _updateCurrentQuestion(
      question.copyWith(
        selectedOptionIndex: selectedOptionIndex,
        isSkipped: false,
        questionStatus: 'answered',
        answeredAt: null,
      ),
    );

    final result = await _saveInterviewAnswerUseCase(
      sessionId: sessionId,
      questionId: question.id,
      selectedOptionIndex: selectedOptionIndex,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            isActionLoading: false,
            errorMessage: failure.message,
          ),
        );
        return failure;
      },
      (_) {
        emit(state.copyWith(isActionLoading: false, errorMessage: null));
        return null;
      },
    );
  }

  Future<bool> goNext() async {
    if (state.isActionLoading || !state.hasQuestions || state.isLastQuestion) {
      return false;
    }

    emit(
      state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        errorMessage: null,
      ),
    );
    return true;
  }

  Future<bool> goBack() async {
    if (state.isActionLoading || !state.hasQuestions || state.isFirstQuestion) {
      return false;
    }

    emit(
      state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
        errorMessage: null,
      ),
    );
    return true;
  }

  Future<Failure?> skipCurrentQuestion() async {
    final sessionId = state.sessionId;
    final question = state.currentQuestion;
    if (sessionId == null || question == null || state.isActionLoading) {
      return null;
    }

    emit(state.copyWith(isActionLoading: true, errorMessage: null));
    _updateCurrentQuestion(
      question.copyWith(
        selectedOptionIndex: null,
        isSkipped: true,
        questionStatus: 'skipped',
        answeredAt: null,
      ),
    );

    final result = await _skipInterviewQuestionUseCase(
      sessionId: sessionId,
      questionId: question.id,
    );

    return result.fold(
      (failure) async {
        emit(
          state.copyWith(
            isActionLoading: false,
            errorMessage: failure.message,
          ),
        );
        return failure;
      },
      (_) async {
        emit(state.copyWith(isActionLoading: false, errorMessage: null));
        if (!state.isLastQuestion) {
          await goNext();
        }
        return null;
      },
    );
  }

  Future<Failure?> finishSession() async {
    final sessionId = state.sessionId;
    if (sessionId == null || state.isActionLoading) {
      return null;
    }

    emit(state.copyWith(isActionLoading: true, errorMessage: null));
    final result = await _finishInterviewSessionUseCase(sessionId);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            isActionLoading: false,
            errorMessage: failure.message,
          ),
        );
        return failure;
      },
      (_) {
        emit(state.copyWith(isActionLoading: false, errorMessage: null));
        return null;
      },
    );
  }

  Future<void> cancelSession() async {
    final sessionId = state.sessionId;
    if (sessionId == null) return;

    await _cancelInterviewSessionUseCase(sessionId);
  }

  void _updateCurrentQuestion(InterviewQuestion updatedQuestion) {
    final sessionQuestions = state.sessionQuestions;
    if (sessionQuestions == null) return;

    final questions = [...sessionQuestions.questions];
    if (state.currentQuestionIndex < 0 ||
        state.currentQuestionIndex >= questions.length) {
      return;
    }

    questions[state.currentQuestionIndex] = updatedQuestion;
    emit(
      state.copyWith(
        sessionQuestions: sessionQuestions.copyWith(questions: questions),
      ),
    );
  }

  InterviewSessionQuestions _normalizeQuestions(
    InterviewSessionQuestions sessionQuestions,
  ) {
    final questions = [...sessionQuestions.questions]
      ..sort((left, right) => left.order.compareTo(right.order));
    return sessionQuestions.copyWith(questions: questions);
  }
}
