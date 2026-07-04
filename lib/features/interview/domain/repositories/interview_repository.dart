import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_career_path.dart';
import '../entities/interview_session.dart';

abstract class InterviewRepository {
  Future<Either<Failure, List<InterviewCareerPath>>> getCareerPaths();

  Future<Either<Failure, InterviewSession>> createSession({
    required String careerPathId,
    required String interviewType,
    required int totalQuestions,
  });
}
