import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_career_path.dart';
import '../repositories/interview_repository.dart';

@lazySingleton
class GetInterviewCareerPathsUseCase {
  const GetInterviewCareerPathsUseCase(this._repository);

  final InterviewRepository _repository;

  Future<Either<Failure, List<InterviewCareerPath>>> call() {
    return _repository.getCareerPaths();
  }
}
