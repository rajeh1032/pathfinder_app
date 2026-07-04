part of 'interview_active_cubit.dart';

class InterviewActiveState extends Equatable {
  const InterviewActiveState({
    this.sessionId,
    this.isLoading = false,
    this.isActionLoading = false,
    this.errorMessage,
    this.sessionQuestions,
    this.currentQuestionIndex = 0,
  });

  final String? sessionId;
  final bool isLoading;
  final bool isActionLoading;
  final String? errorMessage;
  final InterviewSessionQuestions? sessionQuestions;
  final int currentQuestionIndex;

  static const Object _unset = Object();

  InterviewActiveState copyWith({
    Object? sessionId = _unset,
    bool? isLoading,
    bool? isActionLoading,
    Object? errorMessage = _unset,
    Object? sessionQuestions = _unset,
    int? currentQuestionIndex,
  }) {
    return InterviewActiveState(
      sessionId:
          identical(sessionId, _unset) ? this.sessionId : sessionId as String?,
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      sessionQuestions: identical(sessionQuestions, _unset)
          ? this.sessionQuestions
          : sessionQuestions as InterviewSessionQuestions?,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }

  bool get hasQuestions =>
      sessionQuestions != null && sessionQuestions!.questions.isNotEmpty;

  bool get isFirstQuestion => currentQuestionIndex <= 0;

  bool get isLastQuestion {
    final total = sessionQuestions?.questions.length ?? 0;
    return total > 0 && currentQuestionIndex >= total - 1;
  }

  InterviewQuestion? get currentQuestion =>
      sessionQuestions?.questionAt(currentQuestionIndex);

  int get currentQuestionNumber => hasQuestions ? currentQuestionIndex + 1 : 0;

  int get totalQuestions => sessionQuestions?.questions.length ?? 0;

  int? get selectedOptionIndex => currentQuestion?.selectedOptionIndex;

  @override
  List<Object?> get props => [
        sessionId,
        isLoading,
        isActionLoading,
        errorMessage,
        sessionQuestions,
        currentQuestionIndex,
      ];
}
