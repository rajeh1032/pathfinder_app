import 'package:equatable/equatable.dart';

import 'interview_result_question.dart';
import 'interview_result_session.dart';
import 'interview_skill_breakdown.dart';

/// Score comparison against the user's previous completed session of the
/// same career path and interview type.
class InterviewScoreComparison extends Equatable {
  const InterviewScoreComparison({
    required this.currentScore,
    required this.trend,
    this.previousScore,
    this.scoreChange,
    this.improvementPercentage,
  });

  final double currentScore;

  /// `improved`, `declined`, `unchanged`, or `no_previous_data`.
  final String trend;
  final double? previousScore;
  final double? scoreChange;
  final int? improvementPercentage;

  bool get hasPrevious => previousScore != null;

  @override
  List<Object?> get props => [
        currentScore,
        trend,
        previousScore,
        scoreChange,
        improvementPercentage,
      ];
}

/// Aggregated counts for the result summary section.
class InterviewResultSummary extends Equatable {
  const InterviewResultSummary({
    required this.answeredQuestions,
    required this.skippedQuestions,
    required this.averageQuestionScore,
  });

  final int answeredQuestions;
  final int skippedQuestions;
  final double averageQuestionScore;

  @override
  List<Object?> get props =>
      [answeredQuestions, skippedQuestions, averageQuestionScore];
}

/// Aggregate root for a completed interview result.
class InterviewResult extends Equatable {
  const InterviewResult({
    required this.session,
    required this.comparison,
    required this.skillsBreakdown,
    required this.questionBreakdown,
    required this.summary,
  });

  final InterviewResultSession session;
  final InterviewScoreComparison comparison;
  final List<InterviewSkillBreakdown> skillsBreakdown;
  final List<InterviewResultQuestion> questionBreakdown;
  final InterviewResultSummary summary;

  @override
  List<Object?> get props => [
        session,
        comparison,
        skillsBreakdown,
        questionBreakdown,
        summary,
      ];
}
