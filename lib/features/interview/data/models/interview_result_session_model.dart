import '../../domain/entities/interview_result_session.dart';
import 'interview_json_reader.dart';

class InterviewResultSessionModel {
  const InterviewResultSessionModel({
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

  factory InterviewResultSessionModel.fromJson(Map<String, dynamic> json) {
    final careerPath = InterviewJsonReader.readObject(json, ['career_path']);
    final scoreBreakdown =
        InterviewJsonReader.readObject(json, ['score_breakdown']);
    final feedbackText =
        InterviewJsonReader.readObject(json, ['feedback_text']);

    return InterviewResultSessionModel(
      id: InterviewJsonReader.readString(json, ['id', 'session_id']),
      careerPathId:
          InterviewJsonReader.readString(json, ['career_path_id', 'careerPathId']),
      interviewType:
          InterviewJsonReader.readString(json, ['interview_type', 'interviewType']),
      status: InterviewJsonReader.readString(json, ['status']),
      totalQuestions:
          InterviewJsonReader.readInt(json, ['total_questions', 'totalQuestions']),
      careerPathTitle:
          InterviewJsonReader.readNullableString(careerPath, ['title', 'name']),
      careerPathCategory:
          InterviewJsonReader.readNullableString(careerPath, ['category']),
      overallScore:
          InterviewJsonReader.readNullableDouble(json, ['overall_score', 'overallScore']),
      quickAiInsight: InterviewJsonReader.readNullableString(
        json,
        ['quick_ai_insight', 'quickAiInsight'],
      ),
      startedAt:
          InterviewJsonReader.readNullableString(json, ['started_at', 'startedAt']),
      completedAt:
          InterviewJsonReader.readNullableString(json, ['completed_at', 'completedAt']),
      durationMinutes: InterviewJsonReader.readNullableInt(
        json,
        ['duration_minutes', 'durationMinutes'],
      ),
      durationLabel: InterviewJsonReader.readNullableString(
        json,
        ['duration_label', 'durationLabel'],
      ),
      correctAnswers:
          InterviewJsonReader.readNullableInt(scoreBreakdown, ['correct_answers']),
      wrongAnswers:
          InterviewJsonReader.readNullableInt(scoreBreakdown, ['wrong_answers']),
      skippedAnswers:
          InterviewJsonReader.readNullableInt(scoreBreakdown, ['skipped_answers']),
      feedbackSummary:
          InterviewJsonReader.readNullableString(feedbackText, ['summary']),
      strengths: InterviewJsonReader.readStringList(feedbackText, ['strengths']),
      areasForImprovement: InterviewJsonReader.readStringList(
        feedbackText,
        ['areas_for_improvement'],
      ),
      recommendations:
          InterviewJsonReader.readStringList(feedbackText, ['recommendations']),
    );
  }

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
  final String? feedbackSummary;
  final List<String> strengths;
  final List<String> areasForImprovement;
  final List<String> recommendations;

  InterviewResultSession toEntity() {
    return InterviewResultSession(
      id: id,
      careerPathId: careerPathId,
      interviewType: interviewType,
      status: status,
      totalQuestions: totalQuestions,
      careerPathTitle: careerPathTitle,
      careerPathCategory: careerPathCategory,
      overallScore: overallScore,
      quickAiInsight: quickAiInsight,
      startedAt: startedAt,
      completedAt: completedAt,
      durationMinutes: durationMinutes,
      durationLabel: durationLabel,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      skippedAnswers: skippedAnswers,
      feedbackSummary: feedbackSummary,
      strengths: strengths,
      areasForImprovement: areasForImprovement,
      recommendations: recommendations,
    );
  }
}
