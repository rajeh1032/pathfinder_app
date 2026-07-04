import 'package:equatable/equatable.dart';

import '../../../../features/jobs/domain/entities/job.dart';

class CoverLetterInsight extends Equatable {
  const CoverLetterInsight({
    required this.id,
    required this.type,
    required this.message,
  });

  final String id;
  final String type;
  final String message;

  @override
  List<Object?> get props => [id, type, message];
}

class CoverLetter extends Equatable {
  const CoverLetter({
    required this.id,
    required this.jobId,
    required this.content,
    required this.status,
    required this.version,
    required this.title,
    required this.score,
    required this.tone,
    required this.targetRole,
    required this.companyName,
    required this.wordCount,
    required this.createdAt,
    this.job,
    this.insights = const [],
  });

  final String id;
  final String jobId;
  final String content;
  final String status;
  final int version;
  final String title;
  final int score;
  final String tone;
  final String targetRole;
  final String companyName;
  final int wordCount;
  final DateTime? createdAt;
  final Job? job;
  final List<CoverLetterInsight> insights;

  @override
  List<Object?> get props => [
        id,
        jobId,
        content,
        status,
        version,
        title,
        score,
        tone,
        targetRole,
        companyName,
        wordCount,
        createdAt,
        job,
        insights,
      ];
}
