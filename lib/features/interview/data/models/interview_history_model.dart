import '../../domain/entities/interview_history.dart';
import 'interview_history_item_model.dart';
import 'interview_json_reader.dart';

class InterviewHistoryModel {
  const InterviewHistoryModel({
    required this.items,
    required this.summary,
    required this.pagination,
  });

  factory InterviewHistoryModel.fromJson(Map<String, dynamic> json) {
    // [json] may be the full response envelope ({ data: {...}, meta: {...} })
    // or the already-unwrapped inner object ({ items, summary }).
    final inner = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final meta = InterviewJsonReader.readObject(json, ['meta']);
    final paginationJson = InterviewJsonReader.readObject(
      meta.isNotEmpty ? meta : inner,
      ['pagination'],
    );

    final rawItems = inner['items'] ?? inner['data'];
    final items = rawItems is List
        ? rawItems
            .whereType<Map<String, dynamic>>()
            .map(InterviewHistoryItemModel.fromJson)
            .where((item) => item.id.isNotEmpty)
            .toList()
        : <InterviewHistoryItemModel>[];

    return InterviewHistoryModel(
      items: items,
      summary: InterviewHistorySummaryModel.fromJson(
        InterviewJsonReader.readObject(inner, ['summary']),
      ),
      pagination: InterviewHistoryPaginationModel.fromJson(paginationJson),
    );
  }

  final List<InterviewHistoryItemModel> items;
  final InterviewHistorySummaryModel summary;
  final InterviewHistoryPaginationModel pagination;

  InterviewHistory toEntity() {
    return InterviewHistory(
      items: items.map((item) => item.toEntity()).toList(),
      summary: summary.toEntity(),
      pagination: pagination.toEntity(),
    );
  }
}

class InterviewHistoryPaginationModel {
  const InterviewHistoryPaginationModel({
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
    this.nextPage,
  });

  factory InterviewHistoryPaginationModel.fromJson(Map<String, dynamic> json) {
    final page = InterviewJsonReader.readNullableInt(json, ['page']) ?? 1;
    final totalPages =
        InterviewJsonReader.readNullableInt(json, ['totalPages']) ?? 1;
    final nextPage = InterviewJsonReader.readNullableInt(json, ['nextPage']);
    final hasNext = json.containsKey('hasNextPage')
        ? InterviewJsonReader.readBool(json, ['hasNextPage'])
        : page < totalPages;

    return InterviewHistoryPaginationModel(
      page: page,
      totalPages: totalPages,
      hasNextPage: hasNext,
      nextPage: nextPage,
    );
  }

  final int page;
  final int totalPages;
  final bool hasNextPage;
  final int? nextPage;

  InterviewHistoryPagination toEntity() {
    return InterviewHistoryPagination(
      page: page,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
      nextPage: nextPage,
    );
  }
}

class InterviewHistorySummaryModel {
  const InterviewHistorySummaryModel({
    required this.totalInterviews,
    this.averageScore,
    this.bestScore,
    this.latestScore,
    this.latestCompletedAt,
  });

  factory InterviewHistorySummaryModel.fromJson(Map<String, dynamic> json) {
    return InterviewHistorySummaryModel(
      totalInterviews: InterviewJsonReader.readInt(
        json,
        ['total_interviews', 'totalInterviews'],
      ),
      averageScore: InterviewJsonReader.readNullableDouble(
        json,
        ['average_score', 'averageScore'],
      ),
      bestScore:
          InterviewJsonReader.readNullableDouble(json, ['best_score', 'bestScore']),
      latestScore: InterviewJsonReader.readNullableDouble(
        json,
        ['latest_score', 'latestScore'],
      ),
      latestCompletedAt: InterviewJsonReader.readNullableString(
        json,
        ['latest_completed_at', 'latestCompletedAt'],
      ),
    );
  }

  final int totalInterviews;
  final double? averageScore;
  final double? bestScore;
  final double? latestScore;
  final String? latestCompletedAt;

  InterviewHistorySummary toEntity() {
    return InterviewHistorySummary(
      totalInterviews: totalInterviews,
      averageScore: averageScore,
      bestScore: bestScore,
      latestScore: latestScore,
      latestCompletedAt: latestCompletedAt,
    );
  }
}
