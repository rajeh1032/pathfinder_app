import 'package:equatable/equatable.dart';

/// A single interview session entry shown in the history list.
class InterviewHistoryItem extends Equatable {
  const InterviewHistoryItem({
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

  final String id;
  final String interviewType;
  final String status;
  final int totalQuestions;
  final String? careerPathTitle;
  final double? overallScore;
  final String? quickAiInsight;
  final String? startedAt;
  final String? completedAt;

  bool get isCompleted => status == 'completed';

  /// Session duration in whole minutes when both timestamps are available.
  int? get durationMinutes {
    if (startedAt == null || completedAt == null) return null;
    final start = DateTime.tryParse(startedAt!);
    final end = DateTime.tryParse(completedAt!);
    if (start == null || end == null) return null;
    final diff = end.difference(start).inMinutes;
    return diff < 0 ? null : diff;
  }

  @override
  List<Object?> get props => [
        id,
        interviewType,
        status,
        totalQuestions,
        careerPathTitle,
        overallScore,
        quickAiInsight,
        startedAt,
        completedAt,
      ];
}
