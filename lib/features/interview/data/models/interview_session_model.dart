import '../../domain/entities/interview_session.dart';

class InterviewSessionModel {
  const InterviewSessionModel({
    required this.id,
    required this.careerPathId,
    required this.interviewType,
    required this.totalQuestions,
  });

  factory InterviewSessionModel.fromJson(Map<String, dynamic> json) {
    return InterviewSessionModel(
      id: _readString(json, ['id', 'session_id', 'sessionId']),
      careerPathId: _readString(
        json,
        ['career_path_id', 'careerPathId'],
      ),
      interviewType: _readString(
        json,
        ['interview_type', 'interviewType'],
      ),
      totalQuestions: _readInt(json, ['total_questions', 'totalQuestions']),
    );
  }

  final String id;
  final String careerPathId;
  final String interviewType;
  final int totalQuestions;

  InterviewSession toEntity() {
    return InterviewSession(
      id: id,
      careerPathId: careerPathId,
      interviewType: interviewType,
      totalQuestions: totalQuestions,
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
}
