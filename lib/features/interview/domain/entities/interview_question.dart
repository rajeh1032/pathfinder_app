import 'package:equatable/equatable.dart';

class InterviewQuestion extends Equatable {
  const InterviewQuestion({
    required this.id,
    required this.order,
    required this.question,
    required this.options,
    required this.answerType,
    required this.isSkipped,
    this.selectedOptionIndex,
    this.userAnswer,
    this.answeredAt,
    this.feedback,
    this.score,
    this.questionStatus,
    this.aiSuggestion,
  });

  final String id;
  final int order;
  final String question;
  final List<String> options;
  final String answerType;
  final bool isSkipped;
  final int? selectedOptionIndex;
  final String? userAnswer;
  final String? answeredAt;
  final String? feedback;
  final double? score;
  final String? questionStatus;
  final String? aiSuggestion;

  static const Object _unset = Object();

  InterviewQuestion copyWith({
    int? order,
    String? question,
    List<String>? options,
    String? answerType,
    bool? isSkipped,
    Object? selectedOptionIndex = _unset,
    Object? userAnswer = _unset,
    Object? answeredAt = _unset,
    Object? feedback = _unset,
    Object? score = _unset,
    Object? questionStatus = _unset,
    Object? aiSuggestion = _unset,
  }) {
    return InterviewQuestion(
      id: id,
      order: order ?? this.order,
      question: question ?? this.question,
      options: options ?? this.options,
      answerType: answerType ?? this.answerType,
      isSkipped: isSkipped ?? this.isSkipped,
      selectedOptionIndex: identical(selectedOptionIndex, _unset)
          ? this.selectedOptionIndex
          : selectedOptionIndex as int?,
      userAnswer: identical(userAnswer, _unset)
          ? this.userAnswer
          : userAnswer as String?,
      answeredAt: identical(answeredAt, _unset)
          ? this.answeredAt
          : answeredAt as String?,
      feedback:
          identical(feedback, _unset) ? this.feedback : feedback as String?,
      score: identical(score, _unset) ? this.score : score as double?,
      questionStatus: identical(questionStatus, _unset)
          ? this.questionStatus
          : questionStatus as String?,
      aiSuggestion: identical(aiSuggestion, _unset)
          ? this.aiSuggestion
          : aiSuggestion as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        order,
        question,
        options,
        answerType,
        isSkipped,
        selectedOptionIndex,
        userAnswer,
        answeredAt,
        feedback,
        score,
        questionStatus,
        aiSuggestion,
      ];
}
