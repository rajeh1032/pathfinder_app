part of 'interview_history_cubit.dart';

class InterviewHistoryState extends Equatable {
  const InterviewHistoryState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.items = const [],
    this.summary,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<InterviewHistoryItem> items;
  final InterviewHistorySummary? summary;
  final int selectedFilterIndex;
  final String searchQuery;
  final int currentPage;
  final bool hasNextPage;

  static const Object _unset = Object();

  InterviewHistoryState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    Object? errorMessage = _unset,
    List<InterviewHistoryItem>? items,
    Object? summary = _unset,
    int? selectedFilterIndex,
    String? searchQuery,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return InterviewHistoryState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      items: items ?? this.items,
      summary: identical(summary, _unset)
          ? this.summary
          : summary as InterviewHistorySummary?,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  bool get hasItems => items.isNotEmpty;

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        errorMessage,
        items,
        summary,
        selectedFilterIndex,
        searchQuery,
        currentPage,
        hasNextPage,
      ];
}
