part of 'interview_result_cubit.dart';

class InterviewResultState extends Equatable {
  const InterviewResultState({
    this.sessionId,
    this.isLoading = false,
    this.errorMessage,
    this.result,
  });

  final String? sessionId;
  final bool isLoading;
  final String? errorMessage;
  final InterviewResult? result;

  static const Object _unset = Object();

  InterviewResultState copyWith({
    Object? sessionId = _unset,
    bool? isLoading,
    Object? errorMessage = _unset,
    Object? result = _unset,
  }) {
    return InterviewResultState(
      sessionId:
          identical(sessionId, _unset) ? this.sessionId : sessionId as String?,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      result: identical(result, _unset) ? this.result : result as InterviewResult?,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [sessionId, isLoading, errorMessage, result];
}
