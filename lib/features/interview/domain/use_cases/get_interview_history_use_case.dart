import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_history.dart';
import '../repositories/interview_history_repository.dart';

@lazySingleton
class GetInterviewHistoryUseCase {
  const GetInterviewHistoryUseCase(this._repository);

  final InterviewHistoryRepository _repository;

  Future<Either<Failure, InterviewHistory>> call({
    String? query,
    String? interviewType,
    String? status,
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getHistory(
      query: query,
      interviewType: interviewType,
      status: status,
      page: page,
      limit: limit,
    );
  }
}
