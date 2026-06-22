import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_session_questions.dart';
import '../repositories/interview_session_repository.dart';

@lazySingleton
class GetInterviewSessionQuestionsUseCase {
  const GetInterviewSessionQuestionsUseCase(this._repository);

  final InterviewSessionRepository _repository;

  Future<Either<Failure, InterviewSessionQuestions>> call(String sessionId) {
    return _repository.getSessionQuestions(sessionId);
  }
}
