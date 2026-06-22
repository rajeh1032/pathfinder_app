import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/saved_job.dart';

abstract class SavedJobsRepository {
  Future<Either<Failure, List<SavedJob>>> getSavedJobs();
}
