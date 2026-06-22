import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/debouncer.dart';
import '../../domain/entities/interview_history.dart';
import '../../domain/entities/interview_history_item.dart';
import '../../domain/use_cases/get_interview_history_use_case.dart';

part 'interview_history_state.dart';

@injectable
class InterviewHistoryCubit extends Cubit<InterviewHistoryState> {
  InterviewHistoryCubit({
    required GetInterviewHistoryUseCase getHistoryUseCase,
  })  : _getHistoryUseCase = getHistoryUseCase,
        super(const InterviewHistoryState());

  final GetInterviewHistoryUseCase _getHistoryUseCase;
  final Debouncer _searchDebouncer =
      Debouncer(const Duration(milliseconds: 450));

  static const int _pageSize = 20;

  /// Maps a filter chip index to a backend `interview_type` value.
  static const List<String?> _filterTypes = [null, 'technical', 'behavioral'];

  Future<void> loadHistory() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getHistoryUseCase(
      query: state.searchQuery,
      interviewType: _filterTypes[state.selectedFilterIndex],
      page: 1,
      limit: _pageSize,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          items: const [],
          summary: null,
          currentPage: 1,
          hasNextPage: false,
        ),
      ),
      (history) => emit(
        state.copyWith(
          isLoading: false,
          items: history.items,
          summary: history.summary,
          currentPage: history.pagination.page,
          hasNextPage: history.pagination.hasNextPage,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasNextPage) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.currentPage + 1;

    final result = await _getHistoryUseCase(
      query: state.searchQuery,
      interviewType: _filterTypes[state.selectedFilterIndex],
      page: nextPage,
      limit: _pageSize,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (history) => emit(
        state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...history.items],
          currentPage: history.pagination.page,
          hasNextPage: history.pagination.hasNextPage,
          errorMessage: null,
        ),
      ),
    );
  }

  void selectFilter(int index) {
    if (index == state.selectedFilterIndex ||
        index < 0 ||
        index >= _filterTypes.length) {
      return;
    }
    emit(state.copyWith(selectedFilterIndex: index));
    loadHistory();
  }

  void search(String query) {
    final normalized = query.trim();
    if (normalized == state.searchQuery) return;
    emit(state.copyWith(searchQuery: normalized));
    _searchDebouncer.run(loadHistory);
  }

  @override
  Future<void> close() {
    _searchDebouncer.dispose();
    return super.close();
  }
}
