import 'package:equatable/equatable.dart';

class InterviewSession extends Equatable {
  const InterviewSession({
    required this.id,
    required this.careerPathId,
    required this.interviewType,
    required this.totalQuestions,
  });

  final String id;
  final String careerPathId;
  final String interviewType;
  final int totalQuestions;

  @override
  List<Object?> get props => [id, careerPathId, interviewType, totalQuestions];
}
