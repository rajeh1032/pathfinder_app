import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_session.dart';
import '../repositories/interview_repository.dart';

@lazySingleton
class CreateInterviewSessionUseCase {
  const CreateInterviewSessionUseCase(this._repository);

  final InterviewRepository _repository;

  Future<Either<Failure, InterviewSession>> call({
    required String careerPathId,
    required String interviewType,
    required int totalQuestions,
  }) {
    return _repository.createSession(
      careerPathId: careerPathId,
      interviewType: interviewType,
      totalQuestions: totalQuestions,
    );
  }
}
