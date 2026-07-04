import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_session_questions.dart';
import '../entities/interview_result.dart';

abstract class InterviewSessionRepository {
  Future<Either<Failure, InterviewSessionQuestions>> getSessionQuestions(
    String sessionId,
  );

  Future<Either<Failure, InterviewResult>> getSessionResult(String sessionId);

  Future<Either<Failure, Unit>> saveAnswer({
    required String sessionId,
    required String questionId,
    required int selectedOptionIndex,
  });

  Future<Either<Failure, Unit>> skipQuestion({
    required String sessionId,
    required String questionId,
  });

  Future<Either<Failure, Unit>> cancelSession(String sessionId);

  Future<Either<Failure, Unit>> finishSession(String sessionId);
}
