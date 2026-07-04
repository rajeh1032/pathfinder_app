import '../../domain/entities/interview_question.dart';

class InterviewQuestionModel {
  const InterviewQuestionModel({
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

  factory InterviewQuestionModel.fromJson(Map<String, dynamic> json) {
    return InterviewQuestionModel(
      id: _readString(json, ['id', 'question_id', 'questionId']),
      order: _readInt(json, ['question_order', 'questionOrder', 'order']),
      question: _readString(json, ['question', 'text', 'body']),
      options: _readList(json, ['options', 'answers', 'choices']),
      answerType: _readString(json, ['answer_type', 'answerType', 'type']),
      isSkipped: _readBool(json, ['is_skipped', 'isSkipped']),
      selectedOptionIndex: _readNullableInt(
        json,
        ['selected_option_index', 'selectedOptionIndex'],
      ),
      userAnswer:
          _readNullableString(json, ['user_answer', 'userAnswer', 'answer']),
      answeredAt: _readNullableString(json, ['answered_at', 'answeredAt']),
      feedback: _readNullableString(json, ['feedback']),
      score: _readNullableDouble(json, ['score']),
      questionStatus: _readNullableString(
        json,
        ['question_status', 'questionStatus'],
      ),
      aiSuggestion: _readNullableString(
        json,
        ['ai_suggestion', 'aiSuggestion'],
      ),
    );
  }

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

  InterviewQuestion toEntity() {
    return InterviewQuestion(
      id: id,
      order: order,
      question: question,
      options: options,
      answerType: answerType,
      isSkipped: isSkipped,
      selectedOptionIndex: selectedOptionIndex,
      userAnswer: userAnswer,
      answeredAt: answeredAt,
      feedback: feedback,
      score: score,
      questionStatus: questionStatus,
      aiSuggestion: aiSuggestion,
    );
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

  static String? _readNullableString(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value != null) {
        final text = value.toString().trim();
        if (text.isNotEmpty) return text;
      }
    }
    return null;
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

  static int? _readNullableInt(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      if (value is int) return value;
      final parsed = int.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return null;
  }

  static double? _readNullableDouble(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      final parsed = double.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return null;
  }

  static bool _readBool(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is bool) return value;
      if (value is num) return value != 0;
      if (value is String) {
        final text = value.trim().toLowerCase();
        if (text == 'true' || text == '1') return true;
        if (text == 'false' || text == '0') return false;
      }
    }
    return false;
  }

  static List<String> _readList(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is List) {
        return value
            .where((item) => item != null)
            .map((item) => item.toString())
            .toList();
      }
    }
    return const [];
  }
}
