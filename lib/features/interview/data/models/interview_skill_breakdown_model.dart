import '../../domain/entities/interview_skill_breakdown.dart';
import 'interview_json_reader.dart';

class InterviewSkillBreakdownModel {
  const InterviewSkillBreakdownModel({
    required this.skillName,
    required this.score,
    required this.feedback,
    required this.status,
  });

  factory InterviewSkillBreakdownModel.fromJson(Map<String, dynamic> json) {
    return InterviewSkillBreakdownModel(
      skillName: InterviewJsonReader.readString(json, ['skill_name', 'skill']),
      score: InterviewJsonReader.readDouble(json, ['score']),
      feedback: InterviewJsonReader.readString(json, ['feedback']),
      status: InterviewJsonReader.readString(json, ['status']),
    );
  }

  final String skillName;
  final double score;
  final String feedback;
  final String status;

  InterviewSkillBreakdown toEntity() {
    return InterviewSkillBreakdown(
      skillName: skillName,
      score: score,
      feedback: feedback,
      status: status,
    );
  }
}
