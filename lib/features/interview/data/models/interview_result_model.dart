import '../../domain/entities/interview_result.dart';
import 'interview_json_reader.dart';
import 'interview_result_question_model.dart';
import 'interview_result_session_model.dart';
import 'interview_skill_breakdown_model.dart';

class InterviewResultModel {
  const InterviewResultModel({
    required this.session,
    required this.comparison,
    required this.skillsBreakdown,
    required this.questionBreakdown,
    required this.summary,
  });

  factory InterviewResultModel.fromJson(Map<String, dynamic> json) {
    final session = InterviewResultSessionModel.fromJson(
      InterviewJsonReader.readObject(json, ['session']),
    );
    final comparison = InterviewScoreComparisonModel.fromJson(
      InterviewJsonReader.readObject(json, ['comparison']),
    );
    final summary = InterviewResultSummaryModel.fromJson(
      InterviewJsonReader.readObject(json, ['summary']),
    );

    final rawSkills = json['skills_breakdown'];
    final skills = rawSkills is List
        ? rawSkills
            .whereType<Map<String, dynamic>>()
            .map(InterviewSkillBreakdownModel.fromJson)
            .where((skill) => skill.skillName.isNotEmpty)
            .toList()
        : <InterviewSkillBreakdownModel>[];

    final rawQuestions = json['question_breakdown'];
    final questions = rawQuestions is List
        ? rawQuestions
            .whereType<Map<String, dynamic>>()
            .map(InterviewResultQuestionModel.fromJson)
            .where((question) => question.id.isNotEmpty)
            .toList()
        : <InterviewResultQuestionModel>[];

    return InterviewResultModel(
      session: session,
      comparison: comparison,
      skillsBreakdown: skills,
      questionBreakdown: questions,
      summary: summary,
    );
  }

  final InterviewResultSessionModel session;
  final InterviewScoreComparisonModel comparison;
  final List<InterviewSkillBreakdownModel> skillsBreakdown;
  final List<InterviewResultQuestionModel> questionBreakdown;
  final InterviewResultSummaryModel summary;

  InterviewResult toEntity() {
    final questions = questionBreakdown.map((item) => item.toEntity()).toList()
      ..sort((left, right) => left.order.compareTo(right.order));

    return InterviewResult(
      session: session.toEntity(),
      comparison: comparison.toEntity(),
      skillsBreakdown:
          skillsBreakdown.map((skill) => skill.toEntity()).toList(),
      questionBreakdown: questions,
      summary: summary.toEntity(),
    );
  }
}

class InterviewScoreComparisonModel {
  const InterviewScoreComparisonModel({
    required this.currentScore,
    required this.trend,
    this.previousScore,
    this.scoreChange,
    this.improvementPercentage,
  });

  factory InterviewScoreComparisonModel.fromJson(Map<String, dynamic> json) {
    return InterviewScoreComparisonModel(
      currentScore: InterviewJsonReader.readDouble(json, ['current_score']),
      trend: InterviewJsonReader.readString(json, ['trend']),
      previousScore:
          InterviewJsonReader.readNullableDouble(json, ['previous_score']),
      scoreChange:
          InterviewJsonReader.readNullableDouble(json, ['score_change']),
      improvementPercentage: InterviewJsonReader.readNullableInt(
        json,
        ['improvement_percentage'],
      ),
    );
  }

  final double currentScore;
  final String trend;
  final double? previousScore;
  final double? scoreChange;
  final int? improvementPercentage;

  InterviewScoreComparison toEntity() {
    return InterviewScoreComparison(
      currentScore: currentScore,
      trend: trend.isEmpty ? 'no_previous_data' : trend,
      previousScore: previousScore,
      scoreChange: scoreChange,
      improvementPercentage: improvementPercentage,
    );
  }
}

class InterviewResultSummaryModel {
  const InterviewResultSummaryModel({
    required this.answeredQuestions,
    required this.skippedQuestions,
    required this.averageQuestionScore,
  });

  factory InterviewResultSummaryModel.fromJson(Map<String, dynamic> json) {
    return InterviewResultSummaryModel(
      answeredQuestions:
          InterviewJsonReader.readInt(json, ['answered_questions']),
      skippedQuestions:
          InterviewJsonReader.readInt(json, ['skipped_questions']),
      averageQuestionScore:
          InterviewJsonReader.readDouble(json, ['average_question_score']),
    );
  }

  final int answeredQuestions;
  final int skippedQuestions;
  final double averageQuestionScore;

  InterviewResultSummary toEntity() {
    return InterviewResultSummary(
      answeredQuestions: answeredQuestions,
      skippedQuestions: skippedQuestions,
      averageQuestionScore: averageQuestionScore,
    );
  }
}
