import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cover_letter.dart';
import '../../domain/repositories/cover_letters_repository.dart';
import 'cover_letters_state.dart';

class CoverLettersCubit extends Cubit<CoverLettersState> {
  CoverLettersCubit(this._repository) : super(const CoverLettersState());

  final CoverLettersRepository _repository;

  Future<void> generate(
    String jobId, {
    String tone = 'professional',
    List<String> keywords = const [],
    String companyInterest = '',
    String achievement = '',
    String language = 'en',
  }) async {
    emit(state.copyWith(status: CoverLettersStatus.loading, clearError: true));
    final result = await _repository.generateCoverLetter(
      jobId: jobId,
      tone: tone,
      keywords: keywords,
      companyInterest: companyInterest,
      achievement: achievement,
      language: language,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: CoverLettersStatus.failure,
        errorMessage: failure.message,
      )),
      (letter) => emit(state.copyWith(
        status: CoverLettersStatus.success,
        current: letter,
      )),
    );
  }

  Future<void> loadOne(String id) async {
    emit(state.copyWith(status: CoverLettersStatus.loading, clearError: true));
    final result = await _repository.getCoverLetter(id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: CoverLettersStatus.failure,
        errorMessage: failure.message,
      )),
      (letter) => emit(state.copyWith(
        status: CoverLettersStatus.success,
        current: letter,
      )),
    );
  }

  Future<void> loadHistory() async {
    emit(state.copyWith(status: CoverLettersStatus.loading, clearError: true));
    final result = await _repository.getCoverLetters();
    result.fold(
      (failure) => emit(state.copyWith(
        status: CoverLettersStatus.failure,
        errorMessage: failure.message,
      )),
      (letters) => emit(state.copyWith(
        status: CoverLettersStatus.success,
        history: letters,
      )),
    );
  }

  Future<void> saveDraft(String content) async {
    final letter = state.current;
    if (letter == null || state.isSaving) return;

    emit(state.copyWith(isSaving: true, clearError: true));
    final result = await _repository.updateCoverLetter(
      id: letter.id,
      content: content,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isSaving: false,
        errorMessage: failure.message,
      )),
      (updated) => emit(state.copyWith(
        isSaving: false,
        current: updated,
        clearError: true,
      )),
    );
  }

  Future<void> exportCurrent() async {
    final letter = state.current;
    if (letter == null || state.isExporting) return;

    emit(state.copyWith(isExporting: true, clearError: true));
    final result = await _repository.exportCoverLetter(letter.id);
    result.fold(
      (failure) => emit(state.copyWith(
        isExporting: false,
        errorMessage: failure.message,
      )),
      (updated) => emit(state.copyWith(
        isExporting: false,
        current: updated,
        clearError: true,
      )),
    );
  }

  Future<void> deleteLetter(String id) async {
    if (state.isSaving) return;

    emit(state.copyWith(isSaving: true, clearError: true));
    final result = await _repository.deleteCoverLetter(id);
    result.fold(
      (failure) => emit(state.copyWith(
        isSaving: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isSaving: false,
        history: state.history.where((letter) => letter.id != id).toList(),
        clearError: true,
      )),
    );
  }

  void setCurrent(CoverLetter letter) {
    emit(state.copyWith(
      status: CoverLettersStatus.success,
      current: letter,
      clearError: true,
    ));
  }
}
