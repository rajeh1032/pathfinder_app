part of 'interview_start_cubit.dart';

class InterviewStartState extends Equatable {
  static const Object _unset = Object();

  const InterviewStartState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.careerPaths = const [],
    this.selectedCareerPathId,
    this.selectedInterviewType = 'technical',
    this.totalQuestions = 20,
    this.errorMessage,
    this.createdSession,
  });

  final bool isLoading;
  final bool isSubmitting;
  final List<InterviewCareerPath> careerPaths;
  final String? selectedCareerPathId;
  final String selectedInterviewType;
  final int totalQuestions;
  final String? errorMessage;
  final InterviewSession? createdSession;

  InterviewStartState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    List<InterviewCareerPath>? careerPaths,
    Object? selectedCareerPathId = _unset,
    Object? selectedInterviewType = _unset,
    Object? totalQuestions = _unset,
    Object? errorMessage = _unset,
    Object? createdSession = _unset,
  }) {
    return InterviewStartState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      careerPaths: careerPaths ?? this.careerPaths,
      selectedCareerPathId: identical(selectedCareerPathId, _unset)
          ? this.selectedCareerPathId
          : selectedCareerPathId as String?,
      selectedInterviewType: identical(selectedInterviewType, _unset)
          ? this.selectedInterviewType
          : selectedInterviewType as String,
      totalQuestions: identical(totalQuestions, _unset)
          ? this.totalQuestions
          : totalQuestions as int,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      createdSession: identical(createdSession, _unset)
          ? this.createdSession
          : createdSession as InterviewSession?,
    );
  }

  bool get hasCareerPaths => careerPaths.isNotEmpty;

  bool get canStart =>
      hasCareerPaths &&
      selectedCareerPathId != null &&
      !isLoading &&
      !isSubmitting;

  @override
  List<Object?> get props => [
        isLoading,
        isSubmitting,
        careerPaths,
        selectedCareerPathId,
        selectedInterviewType,
        totalQuestions,
        errorMessage,
        createdSession,
      ];
}
