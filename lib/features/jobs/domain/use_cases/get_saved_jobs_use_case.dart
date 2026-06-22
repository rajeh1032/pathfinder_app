import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/saved_job.dart';
import '../repositories/saved_jobs_repository.dart';

@lazySingleton
class GetSavedJobsUseCase {
  const GetSavedJobsUseCase(this._repository);

  final SavedJobsRepository _repository;

  Future<Either<Failure, List<SavedJob>>> call() => _repository.getSavedJobs();
}
