import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_result.dart';
import '../repositories/interview_session_repository.dart';

@lazySingleton
class GetInterviewSessionResultUseCase {
  const GetInterviewSessionResultUseCase(this._repository);

  final InterviewSessionRepository _repository;

  Future<Either<Failure, InterviewResult>> call(String sessionId) {
    return _repository.getSessionResult(sessionId);
  }
}
