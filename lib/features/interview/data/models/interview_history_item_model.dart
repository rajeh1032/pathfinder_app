import '../../domain/entities/interview_history_item.dart';
import 'interview_json_reader.dart';

class InterviewHistoryItemModel {
  const InterviewHistoryItemModel({
    required this.id,
    required this.interviewType,
    required this.status,
    required this.totalQuestions,
    this.careerPathTitle,
    this.overallScore,
    this.quickAiInsight,
    this.startedAt,
    this.completedAt,
  });

  factory InterviewHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return InterviewHistoryItemModel(
      id: InterviewJsonReader.readString(json, ['id', 'session_id']),
      interviewType: InterviewJsonReader.readString(
        json,
        ['interview_type', 'interviewType'],
      ),
      status: InterviewJsonReader.readString(json, ['status']),
      totalQuestions: InterviewJsonReader.readInt(
        json,
        ['total_questions', 'totalQuestions'],
      ),
      careerPathTitle: InterviewJsonReader.readNullableString(
        json,
        ['career_path_title', 'careerPathTitle'],
      ),
      overallScore: InterviewJsonReader.readNullableDouble(
        json,
        ['overall_score', 'overallScore'],
      ),
      quickAiInsight: InterviewJsonReader.readNullableString(
        json,
        ['quick_ai_insight', 'quickAiInsight'],
      ),
      startedAt: InterviewJsonReader.readNullableString(
        json,
        ['started_at', 'startedAt'],
      ),
      completedAt: InterviewJsonReader.readNullableString(
        json,
        ['completed_at', 'completedAt'],
      ),
    );
  }

  final String id;
  final String interviewType;
  final String status;
  final int totalQuestions;
  final String? careerPathTitle;
  final double? overallScore;
  final String? quickAiInsight;
  final String? startedAt;
  final String? completedAt;

  InterviewHistoryItem toEntity() {
    return InterviewHistoryItem(
      id: id,
      interviewType: interviewType,
      status: status,
      totalQuestions: totalQuestions,
      careerPathTitle: careerPathTitle,
      overallScore: overallScore,
      quickAiInsight: quickAiInsight,
      startedAt: startedAt,
      completedAt: completedAt,
    );
  }
}
