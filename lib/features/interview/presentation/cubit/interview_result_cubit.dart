import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../domain/entities/interview_result.dart';
import '../../domain/use_cases/get_interview_session_result_use_case.dart';

part 'interview_result_state.dart';

@injectable
class InterviewResultCubit extends Cubit<InterviewResultState> {
  InterviewResultCubit({
    required GetInterviewSessionResultUseCase getSessionResultUseCase,
  })  : _getSessionResultUseCase = getSessionResultUseCase,
        super(const InterviewResultState());

  final GetInterviewSessionResultUseCase _getSessionResultUseCase;

  Future<void> loadResult(String? sessionId) async {
    if (sessionId == null || sessionId.trim().isEmpty) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: ErrorMessages.unknown,
        result: null,
      ));
      return;
    }

    emit(state.copyWith(
      sessionId: sessionId,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await _getSessionResultUseCase(sessionId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          result: null,
        ),
      ),
      (interviewResult) => emit(
        state.copyWith(
          isLoading: false,
          result: interviewResult,
          errorMessage: null,
        ),
      ),
    );
  }
}
