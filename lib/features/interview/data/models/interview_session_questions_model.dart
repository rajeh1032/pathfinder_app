import '../../domain/entities/interview_session_questions.dart';
import 'interview_question_model.dart';

class InterviewSessionQuestionsModel {
  const InterviewSessionQuestionsModel({
    required this.sessionId,
    required this.status,
    required this.totalQuestions,
    required this.answeredCount,
    required this.skippedCount,
    required this.progress,
    required this.questions,
  });

  factory InterviewSessionQuestionsModel.fromJson(Map<String, dynamic> json) {
    final questions = _readQuestions(json);
    return InterviewSessionQuestionsModel(
      sessionId: _readString(json, ['session_id', 'sessionId', 'id']),
      status: _readString(json, ['status']),
      totalQuestions: _readInt(json, ['total_questions', 'totalQuestions']),
      answeredCount: _readInt(json, ['answered_count', 'answeredCount']),
      skippedCount: _readInt(json, ['skipped_count', 'skippedCount']),
      progress: _readDouble(json, ['progress']),
      questions: questions,
    );
  }

  final String sessionId;
  final String status;
  final int totalQuestions;
  final int answeredCount;
  final int skippedCount;
  final double progress;
  final List<InterviewQuestionModel> questions;

  InterviewSessionQuestions toEntity() {
    final sortedQuestions = questions
        .map((question) => question.toEntity())
        .toList()
      ..sort((left, right) => left.order.compareTo(right.order));

    return InterviewSessionQuestions(
      sessionId: sessionId,
      status: status,
      totalQuestions: totalQuestions,
      answeredCount: answeredCount,
      skippedCount: skippedCount,
      progress: progress,
      questions: sortedQuestions,
    );
  }

  static List<InterviewQuestionModel> _readQuestions(
      Map<String, dynamic> json) {
    final rawQuestions = json['questions'];
    if (rawQuestions is List) {
      return rawQuestions
          .whereType<Map<String, dynamic>>()
          .map(InterviewQuestionModel.fromJson)
          .toList();
    }
    return const [];
  }

  static String _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return '';
  }

  static int _readInt(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      if (value is int) return value;
      final parsed = int.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return 0;
  }

  static double _readDouble(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      final parsed = double.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return 0;
  }
}
