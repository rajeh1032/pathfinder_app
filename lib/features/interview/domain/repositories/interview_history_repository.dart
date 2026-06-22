import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interview_history.dart';

abstract class InterviewHistoryRepository {
  Future<Either<Failure, InterviewHistory>> getHistory({
    String? query,
    String? interviewType,
    String? status,
    int page,
    int limit,
  });
}
