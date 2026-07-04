import 'package:equatable/equatable.dart';

import 'interview_history_item.dart';

/// Aggregated stats for the interview history header.
class InterviewHistorySummary extends Equatable {
  const InterviewHistorySummary({
    required this.totalInterviews,
    this.averageScore,
    this.bestScore,
    this.latestScore,
    this.latestCompletedAt,
  });

  final int totalInterviews;
  final double? averageScore;
  final double? bestScore;
  final double? latestScore;
  final String? latestCompletedAt;

  @override
  List<Object?> get props => [
        totalInterviews,
        averageScore,
        bestScore,
        latestScore,
        latestCompletedAt,
      ];
}

/// Pagination metadata returned alongside an interview history page.
class InterviewHistoryPagination extends Equatable {
  const InterviewHistoryPagination({
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    this.nextPage,
  });

  final int page;
  final int totalPages;
  final bool hasNextPage;
  final int? nextPage;

  @override
  List<Object?> get props => [page, totalPages, hasNextPage, nextPage];
}

/// Aggregate root for a single interview history fetch.
class InterviewHistory extends Equatable {
  const InterviewHistory({
    required this.items,
    required this.summary,
    required this.pagination,
  });

  final List<InterviewHistoryItem> items;
  final InterviewHistorySummary summary;
  final InterviewHistoryPagination pagination;

  @override
  List<Object?> get props => [items, summary, pagination];
}
