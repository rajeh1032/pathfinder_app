import 'package:equatable/equatable.dart';

/// A single evaluated question shown in the result question breakdown.
class InterviewResultQuestion extends Equatable {
  const InterviewResultQuestion({
    required this.id,
    required this.order,
    required this.question,
    required this.options,
    required this.isCorrect,
    required this.score,
    required this.questionStatus,
    this.selectedOptionIndex,
    this.correctOptionIndex,
    this.feedback,
    this.aiSuggestion,
  });

  final String id;
  final int order;
  final String question;
  final List<String> options;
  final bool isCorrect;

  /// Per-question score on a 0-100 scale.
  final double score;

  /// Backend status: `passed`, `needs_improvement`, `skipped`, `unanswered`.
  final String questionStatus;
  final int? selectedOptionIndex;
  final int? correctOptionIndex;
  final String? feedback;
  final String? aiSuggestion;

  bool get isSkipped => questionStatus == 'skipped';

  bool get hasDetails =>
      (feedback != null && feedback!.isNotEmpty) ||
      (aiSuggestion != null && aiSuggestion!.isNotEmpty);

  @override
  List<Object?> get props => [
        id,
        order,
        question,
        options,
        isCorrect,
        score,
        questionStatus,
        selectedOptionIndex,
        correctOptionIndex,
        feedback,
        aiSuggestion,
      ];
}
