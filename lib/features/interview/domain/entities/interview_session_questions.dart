import 'package:equatable/equatable.dart';

import 'interview_question.dart';

class InterviewSessionQuestions extends Equatable {
  const InterviewSessionQuestions({
    required this.sessionId,
    required this.status,
    required this.totalQuestions,
    required this.answeredCount,
    required this.skippedCount,
    required this.progress,
    required this.questions,
  });

  final String sessionId;
  final String status;
  final int totalQuestions;
  final int answeredCount;
  final int skippedCount;
  final double progress;
  final List<InterviewQuestion> questions;

  InterviewQuestion? questionAt(int index) {
    if (index < 0 || index >= questions.length) return null;
    return questions[index];
  }

  InterviewSessionQuestions copyWith({
    String? status,
    int? totalQuestions,
    int? answeredCount,
    int? skippedCount,
    double? progress,
    List<InterviewQuestion>? questions,
  }) {
    return InterviewSessionQuestions(
      sessionId: sessionId,
      status: status ?? this.status,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      answeredCount: answeredCount ?? this.answeredCount,
      skippedCount: skippedCount ?? this.skippedCount,
      progress: progress ?? this.progress,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [
        sessionId,
        status,
        totalQuestions,
        answeredCount,
        skippedCount,
        progress,
        questions,
      ];
}
