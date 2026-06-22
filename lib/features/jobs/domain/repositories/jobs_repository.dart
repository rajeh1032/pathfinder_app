import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/applied_job.dart';
import '../entities/job.dart';
import '../entities/job_match.dart';
import '../entities/saved_job.dart';

abstract class JobsRepository {
  Future<Either<Failure, List<Job>>> getJobs({int page = 1, int limit = 20});

  Future<Either<Failure, List<JobMatch>>> getMatchedJobs({
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<JobMatch>>> generateJobMatches({
    int limit = 20,
  });

  Future<Either<Failure, Job>> getJobDetails(String jobId);

  Future<Either<Failure, void>> saveJob(String jobId);

  Future<Either<Failure, void>> unsaveJob(String jobId);

  Future<Either<Failure, void>> applyToJob(String jobId);

  Future<Either<Failure, List<SavedJob>>> getSavedJobs();

  Future<Either<Failure, List<AppliedJob>>> getAppliedJobs();
}
