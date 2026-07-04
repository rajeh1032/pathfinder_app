import 'package:equatable/equatable.dart';

/// A single skill assessment item returned in the interview result payload.
class InterviewSkillBreakdown extends Equatable {
  const InterviewSkillBreakdown({
    required this.skillName,
    required this.score,
    required this.feedback,
    required this.status,
  });

  /// Skill display name (already human readable from the backend).
  final String skillName;

  /// Score on a 0-100 scale.
  final double score;

  /// Short AI feedback for the skill.
  final String feedback;

  /// Backend status such as `strong`, `needs_improvement`,
  /// or `insufficient_evidence`.
  final String status;

  /// Normalized 0-1 progress value used by progress indicators.
  double get progress => (score.clamp(0, 100)) / 100;

  @override
  List<Object?> get props => [skillName, score, feedback, status];
}
