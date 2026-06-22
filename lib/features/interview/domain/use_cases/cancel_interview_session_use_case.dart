import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/interview_session_repository.dart';

@lazySingleton
class CancelInterviewSessionUseCase {
  const CancelInterviewSessionUseCase(this._repository);

  final InterviewSessionRepository _repository;

  Future<Either<Failure, Unit>> call(String sessionId) {
    return _repository.cancelSession(sessionId);
  }
}
