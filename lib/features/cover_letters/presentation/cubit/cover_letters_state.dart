import 'package:equatable/equatable.dart';

import '../../domain/entities/cover_letter.dart';

enum CoverLettersStatus { initial, loading, success, failure }

class CoverLettersState extends Equatable {
  const CoverLettersState({
    this.status = CoverLettersStatus.initial,
    this.current,
    this.history = const [],
    this.errorMessage,
    this.isSaving = false,
    this.isExporting = false,
  });

  final CoverLettersStatus status;
  final CoverLetter? current;
  final List<CoverLetter> history;
  final String? errorMessage;
  final bool isSaving;
  final bool isExporting;

  CoverLettersState copyWith({
    CoverLettersStatus? status,
    CoverLetter? current,
    List<CoverLetter>? history,
    String? errorMessage,
    bool? clearError,
    bool? isSaving,
    bool? isExporting,
  }) {
    return CoverLettersState(
      status: status ?? this.status,
      current: current ?? this.current,
      history: history ?? this.history,
      errorMessage:
          clearError == true ? null : errorMessage ?? this.errorMessage,
      isSaving: isSaving ?? this.isSaving,
      isExporting: isExporting ?? this.isExporting,
    );
  }

  @override
  List<Object?> get props => [
        status,
        current,
        history,
        errorMessage,
        isSaving,
        isExporting,
      ];
}
