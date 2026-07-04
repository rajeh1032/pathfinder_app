import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/interview_career_path.dart';
import '../../domain/entities/interview_session.dart';
import '../../domain/use_cases/create_interview_session_use_case.dart';
import '../../domain/use_cases/get_interview_career_paths_use_case.dart';

part 'interview_start_state.dart';

@injectable
class InterviewStartCubit extends Cubit<InterviewStartState> {
  InterviewStartCubit({
    required GetInterviewCareerPathsUseCase getCareerPathsUseCase,
    required CreateInterviewSessionUseCase createInterviewSessionUseCase,
  })  : _getCareerPathsUseCase = getCareerPathsUseCase,
        _createInterviewSessionUseCase = createInterviewSessionUseCase,
        super(const InterviewStartState());

  final GetInterviewCareerPathsUseCase _getCareerPathsUseCase;
  final CreateInterviewSessionUseCase _createInterviewSessionUseCase;

  Future<void> loadCareerPaths() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getCareerPathsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          careerPaths: const [],
          selectedCareerPathId: null,
        ),
      ),
      (careerPaths) {
        final selectedCareerPathId = state.selectedCareerPathId ??
            (careerPaths.isNotEmpty ? careerPaths.first.id : null);
        emit(
          state.copyWith(
            isLoading: false,
            careerPaths: careerPaths,
            selectedCareerPathId: selectedCareerPathId,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void selectCareerPath(String careerPathId) {
    if (careerPathId == state.selectedCareerPathId) return;
    emit(state.copyWith(selectedCareerPathId: careerPathId));
  }

  void selectInterviewType(String interviewType) {
    if (interviewType == state.selectedInterviewType) return;
    emit(state.copyWith(selectedInterviewType: interviewType));
  }

  Future<void> startInterview() async {
    if (!state.canStart) return;

    final selectedCareerPathId = state.selectedCareerPathId;
    if (selectedCareerPathId == null) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final result = await _createInterviewSessionUseCase(
      careerPathId: selectedCareerPathId,
      interviewType: state.selectedInterviewType,
      totalQuestions: state.totalQuestions,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: failure.message,
        ),
      ),
      (session) => emit(
        state.copyWith(
          isSubmitting: false,
          createdSession: session,
          errorMessage: null,
        ),
      ),
    );
  }

  void clearCreatedSession() {
    if (state.createdSession == null) return;
    emit(state.copyWith(createdSession: null));
  }
}
