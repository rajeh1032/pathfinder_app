import 'package:equatable/equatable.dart';

/// Session-level data and AI feedback for a completed interview.
class InterviewResultSession extends Equatable {
  const InterviewResultSession({
    required this.id,
    required this.careerPathId,
    required this.interviewType,
    required this.status,
    required this.totalQuestions,
    this.careerPathTitle,
    this.careerPathCategory,
    this.overallScore,
    this.quickAiInsight,
    this.startedAt,
    this.completedAt,
    this.durationMinutes,
    this.durationLabel,
    this.correctAnswers,
    this.wrongAnswers,
    this.skippedAnswers,
    this.feedbackSummary,
    this.strengths = const [],
    this.areasForImprovement = const [],
    this.recommendations = const [],
  });

  final String id;
  final String careerPathId;
  final String interviewType;
  final String status;
  final int totalQuestions;
  final String? careerPathTitle;
  final String? careerPathCategory;
  final double? overallScore;
  final String? quickAiInsight;
  final String? startedAt;
  final String? completedAt;
  final int? durationMinutes;
  final String? durationLabel;
  final int? correctAnswers;
  final int? wrongAnswers;
  final int? skippedAnswers;

  /// AI generated feedback text fields.
  final String? feedbackSummary;
  final List<String> strengths;
  final List<String> areasForImprovement;
  final List<String> recommendations;

  @override
  List<Object?> get props => [
        id,
        careerPathId,
        interviewType,
        status,
        totalQuestions,
        careerPathTitle,
        careerPathCategory,
        overallScore,
        quickAiInsight,
        startedAt,
        completedAt,
        durationMinutes,
        durationLabel,
        correctAnswers,
        wrongAnswers,
        skippedAnswers,
        feedbackSummary,
        strengths,
        areasForImprovement,
        recommendations,
      ];
}
