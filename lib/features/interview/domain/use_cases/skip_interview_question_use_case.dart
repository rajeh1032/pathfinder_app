import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/interview_session_repository.dart';

@lazySingleton
class SkipInterviewQuestionUseCase {
  const SkipInterviewQuestionUseCase(this._repository);

  final InterviewSessionRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String sessionId,
    required String questionId,
  }) {
    return _repository.skipQuestion(
      sessionId: sessionId,
      questionId: questionId,
    );
  }
}
