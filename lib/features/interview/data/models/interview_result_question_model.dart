import '../../domain/entities/interview_result_question.dart';
import 'interview_json_reader.dart';

class InterviewResultQuestionModel {
  const InterviewResultQuestionModel({
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

  factory InterviewResultQuestionModel.fromJson(Map<String, dynamic> json) {
    return InterviewResultQuestionModel(
      id: InterviewJsonReader.readString(json, ['id', 'question_id']),
      order: InterviewJsonReader.readInt(json, ['question_order', 'order']),
      question: InterviewJsonReader.readString(json, ['question', 'text']),
      options: InterviewJsonReader.readStringList(json, ['options']),
      isCorrect: InterviewJsonReader.readBool(json, ['is_correct', 'isCorrect']),
      score: InterviewJsonReader.readDouble(json, ['score']),
      questionStatus: InterviewJsonReader.readString(
        json,
        ['question_status', 'questionStatus'],
      ),
      selectedOptionIndex: InterviewJsonReader.readNullableInt(
        json,
        ['selected_option_index', 'selectedOptionIndex'],
      ),
      correctOptionIndex: InterviewJsonReader.readNullableInt(
        json,
        ['correct_option_index', 'correctOptionIndex'],
      ),
      feedback: InterviewJsonReader.readNullableString(json, ['feedback']),
      aiSuggestion: InterviewJsonReader.readNullableString(
        json,
        ['ai_suggestion', 'aiSuggestion'],
      ),
    );
  }

  final String id;
  final int order;
  final String question;
  final List<String> options;
  final bool isCorrect;
  final double score;
  final String questionStatus;
  final int? selectedOptionIndex;
  final int? correctOptionIndex;
  final String? feedback;
  final String? aiSuggestion;

  InterviewResultQuestion toEntity() {
    return InterviewResultQuestion(
      id: id,
      order: order,
      question: question,
      options: options,
      isCorrect: isCorrect,
      score: score,
      questionStatus: questionStatus.isEmpty ? 'unanswered' : questionStatus,
      selectedOptionIndex: selectedOptionIndex,
      correctOptionIndex: correctOptionIndex,
      feedback: feedback,
      aiSuggestion: aiSuggestion,
    );
  }
}
