import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/applied_job.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/job_match.dart';
import '../../domain/entities/saved_job.dart';
import '../../domain/repositories/jobs_repository.dart';
import '../data_sources/remote/jobs_remote_data_source.dart';

class JobsRepositoryImpl implements JobsRepository {
  const JobsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final JobsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Job>>> getJobs({
    int page = 1,
    int limit = 20,
  }) {
    return _guard(() => _remoteDataSource.getJobs(page: page, limit: limit));
  }

  @override
  Future<Either<Failure, List<Job>>> syncJobs({int limit = 20}) {
    return _guard(() => _remoteDataSource.syncJobs(limit: limit));
  }

  @override
  Future<Either<Failure, List<JobMatch>>> getMatchedJobs({
    int page = 1,
    int limit = 20,
  }) {
    return _guard(
      () => _remoteDataSource.getMatchedJobs(page: page, limit: limit),
    );
  }

  @override
  Future<Either<Failure, List<JobMatch>>> generateJobMatches({
    int limit = 20,
  }) {
    return _guard(() => _remoteDataSource.generateJobMatches(limit: limit));
  }

  @override
  Future<Either<Failure, Job>> getJobDetails(String jobId) {
    return _guard(() => _remoteDataSource.getJobDetails(jobId));
  }

  @override
  Future<Either<Failure, void>> saveJob(String jobId) {
    return _guard(() => _remoteDataSource.saveJob(jobId));
  }

  @override
  Future<Either<Failure, void>> unsaveJob(String jobId) {
    return _guard(() => _remoteDataSource.unsaveJob(jobId));
  }

  @override
  Future<Either<Failure, void>> applyToJob(String jobId) {
    return _guard(() => _remoteDataSource.applyToJob(jobId));
  }

  @override
  Future<Either<Failure, List<SavedJob>>> getSavedJobs() {
    return _guard(_remoteDataSource.getSavedJobs);
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> getAppliedJobs() {
    return _guard(_remoteDataSource.getAppliedJobs);
  }

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() request) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      return Right(await request());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}
