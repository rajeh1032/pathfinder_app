import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/interview_session_repository.dart';

@lazySingleton
class SaveInterviewAnswerUseCase {
  const SaveInterviewAnswerUseCase(this._repository);

  final InterviewSessionRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String sessionId,
    required String questionId,
    required int selectedOptionIndex,
  }) {
    return _repository.saveAnswer(
      sessionId: sessionId,
      questionId: questionId,
      selectedOptionIndex: selectedOptionIndex,
    );
  }
}
