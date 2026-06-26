import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cv_anaysis_entity.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import 'cv_history_state.dart';

class CvHistoryCubit extends Cubit<CvHistoryState> {
  CvHistoryCubit(this.repository) : super(const CvHistoryInitial());

  final CvAnalysisRepository repository;
  List<CvHistoryItemEntity> _items = const [];

  Future<void> loadHistory() async {
    emit(const CvHistoryLoading());
    final result = await repository.getHistory();
    result.fold(
      (failure) => emit(CvHistoryError(failure.message)),
      (history) {
        _items = history.items;
        emit(_items.isEmpty ? const CvHistoryEmpty() : CvHistoryLoaded(_items));
      },
    );
  }

  Future<void> openFile(CvHistoryItemEntity cv) async {
    if (!cv.hasFile) {
      emit(const CvHistoryError('cvHistory.noFile'));
      if (_items.isNotEmpty) emit(CvHistoryLoaded(_items));
      return;
    }

    emit(CvHistoryLoaded(_items, openingCvId: cv.id));
    final result = await repository.getFileUrl(cv.id);
    result.fold(
      (failure) => emit(CvHistoryError(failure.message)),
      (file) => emit(CvHistoryFileReady(items: _items, file: file)),
    );
  }

  void markFileHandled() {
    if (_items.isEmpty) {
      emit(const CvHistoryEmpty());
      return;
    }
    emit(CvHistoryLoaded(_items));
  }
}
